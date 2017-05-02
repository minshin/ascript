<?php namespace Renatio\BackupManager\Classes;

use File;
use October\Rain\Exception\ApplicationException;
use Renatio\BackupManager\Models\Backup;
use SplFileInfo;
use Symfony\Component\Finder\Finder;
use ZipArchive;
use Storage;
use Session;

/**
 * Class FilesBackupHandler
 * @package Renatio\BackupManager\Classes
 */
class FilesBackupHandler implements BackupHandlerInterface
{

    /**
     * @var
     */
    protected $includedFiles;

    /**
     * @var
     */
    protected $excludedFiles;

    /**
     * @var
     */
    protected $settings;

    /**
     * Set all files that should be included.
     *
     * @param $includedFiles
     * @return $this
     */
    public function setIncludedFiles($includedFiles)
    {
        $this->includedFiles = $includedFiles;

        return $this;
    }

    /**
     * Set all files that should be excluded.
     *
     * @param $excludedFiles
     * @return $this
     */
    public function setExcludedFiles($excludedFiles)
    {
        $this->excludedFiles = $excludedFiles;

        return $this;
    }

    /**
     * Returns an array of files which should be backed up.
     *
     * @return array
     */
    public function getFilesToBeBackedUp()
    {
        $filesToBeIncluded = $this->getAllPathFromFileArray($this->includedFiles);
        $filesToBeExcluded = $this->getAllPathFromFileArray($this->excludedFiles);

        $filtered = $this->filterFiles($filesToBeIncluded, $filesToBeExcluded);

        $files = [];

        foreach ($filtered as $key => $item) {
            $files[] = $key;
        }

        return $files;
    }

    /**
     * Make a unique array of all file paths from a given array of files.
     *
     * @param $fileArray
     * @return array
     */
    public function getAllPathFromFileArray($fileArray)
    {
        $files = [];

        foreach ($fileArray as $file) {
            if (File::isFile($file)) {
                $files[] = new SplFileInfo($file);
            }

            if (File::isDirectory($file)) {
                $files = array_merge($files, $this->getAllFilesFromDirectory($file));
            }
        }

        return array_count_values(array_map(function (SplFileInfo $file) {
            return $file->getPathName();
        }, $files));
    }

    /**
     * Recursively get all the files within a given directory.
     *
     * @param $directory
     * @return array
     */
    protected function getAllFilesFromDirectory($directory)
    {
        $finder = (new Finder())
            ->ignoreDotFiles(false)
            ->ignoreVCS(false)
            ->files()
            ->in($directory);

        return iterator_to_array($finder, false);
    }

    /**
     * Create a zip for the given files.
     *
     * @param $files
     * @return string
     */
    public function createZip($files)
    {
        $tempZipFile = tempnam(sys_get_temp_dir(), "renatio-backupmanager");

        $zip = new ZipArchive();
        $zip->open($tempZipFile, ZipArchive::CREATE);

        foreach ($files as $file) {
            if (file_exists($file['realFile'])) {
                $zip->addFile($file['realFile'], $file['fileInZip']);
            }
        }

        $zip->close();

        $this->clearTempFiles($files);

        return $tempZipFile;
    }

    /**
     * Copy files to storage
     *
     * @param $backupZipFile
     * @return $this
     */
    public function copyFilesToStorage($backupZipFile)
    {
        $filePath = $this->getBackupDestinationFileName();

        foreach ($this->settings->filesystem as $fileSystem) {
            $this->copyFileToFileSystem($backupZipFile, $fileSystem, $filePath);
        }

        unlink($backupZipFile);

        Session::put('backup.file_path', $filePath);

        return $this;
    }

    /**
     * Copy the given file on the given disk to the given destination.
     *
     * @param string $file
     * @param \Illuminate\Contracts\Filesystem\Filesystem $disk
     * @param string $destination
     * @param bool $addIgnoreFile
     */
    protected function copyFile($file, $disk, $destination, $addIgnoreFile = false)
    {
        $destinationDirectory = dirname($destination);

        $disk->makeDirectory($destinationDirectory);

        if ($addIgnoreFile) {
            $this->writeIgnoreFile($disk, $destinationDirectory);
        }

        /*
         * The file could be quite large. Use a stream to copy it
         * to the target disk to avoid memory problems
         */
        $disk->getDriver()->writeStream($destination, fopen($file, 'r+'));
    }

    /**
     * Write an ignore-file on the given disk in the given directory.
     *
     * @param \Illuminate\Contracts\Filesystem\Filesystem $disk
     * @param string $dumpDirectory
     */
    protected function writeIgnoreFile($disk, $dumpDirectory)
    {
        $gitIgnoreContents = '*' . PHP_EOL . '!.gitignore';

        $disk->put($dumpDirectory . '/.gitignore', $gitIgnoreContents);
    }

    /**
     * Determine the name of the zip that contains the backup.
     *
     * @return string
     */
    protected function getBackupDestinationFileName()
    {
        $backupDirectory = $this->settings->backups_path;
        $backupFilename = $this->settings->prefix . date('YmdHis') . $this->settings->suffix . '.zip';

        return $backupDirectory . '/' . $backupFilename;
    }

    /**
     * Copy the given file to given filesystem.
     *
     * @param string $file
     * @param $fileSystem
     * @param $filePath
     */
    public function copyFileToFileSystem($file, $fileSystem, $filePath)
    {
        $disk = Storage::disk($fileSystem);

        $this->copyFile($file, $disk, $filePath, $fileSystem == 'local');
    }

    /**
     * Set settings
     *
     * @param $settings
     */
    public function setSettings($settings)
    {
        $this->settings = $settings;
    }

    /**
     * Get dump file path
     *
     * @param $id
     * @return FilesBackupHandler
     * @throws ApplicationException
     */
    public function getDumpFilePath($id)
    {
        return $this->unzipBackup($id);
    }

    /**
     * Unzip backup file
     *
     * @param $id
     * @return $this
     * @throws ApplicationException
     */
    private function unzipBackup($id)
    {
        $backup = Backup::findOrFail($id);

        $filePath = $this->getBackupFromStorage($backup);

        $zip = new ZipArchive;
        $res = $zip->open($filePath);
        if ($res === true) {
            $zip->extractTo(storage_path('temp'), ['db/dump.sql']);
            $zip->close();
            $backup->deleteLocalFile();

            return $this;
        }

        throw new ApplicationException(trans('renatio.backupmanager::lang.restore.open_error'));
    }

    /**
     * Get backup file from storage
     *
     * @param $backup
     * @return string
     */
    private function getBackupFromStorage($backup)
    {
        $filePath = storage_path('app/' . $backup->file_path);

        if ($backup->fileExists('local')) {
            return $filePath;
        }

        Storage::disk('local')->put($backup->file_path, $backup->getFile());

        return $filePath;
    }

    /**
     * Filter files to backup
     *
     * @param $filesToBeIncluded
     * @param $filesToBeExcluded
     * @return array
     */
    private function filterFiles($filesToBeIncluded, $filesToBeExcluded)
    {
        reset($filesToBeIncluded);
        $filtered = array_filter($filesToBeIncluded, function ($count) use (&$filesToBeIncluded, $filesToBeExcluded) {
            $result = ! array_key_exists(key($filesToBeIncluded), $filesToBeExcluded) || $count > 1;
            next($filesToBeIncluded);

            return $result;
        });

        return $filtered;
    }

    /**
     * @param $files
     */
    private function clearTempFiles($files)
    {
        foreach ($files as $file) {
            if (strpos($file['realFile'], sys_get_temp_dir() . '/renatio-backupmanager') !== false) {
                unlink($file['realFile']);
            }
        }
    }

}