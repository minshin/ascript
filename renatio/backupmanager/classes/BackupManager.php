<?php namespace Renatio\BackupManager\Classes;

use Session;
use October\Rain\Support\Traits\Singleton;
use ApplicationException;
use Renatio\BackupManager\Models\Backup;
use Renatio\BackupManager\Models\Settings;

/**
 * Class BackupManager
 * @package Renatio\BackupManager\Classes
 */
class BackupManager
{

    /**
     * Traits
     */
    use Singleton;

    /**
     * The files for backup.
     * @var array
     */
    protected $files = [];

    /**
     * Backup settings
     * @var
     */
    protected $settings;

    /**
     * @var
     */
    protected $fileHandler;

    /**
     * @var
     */
    protected $dbHandler;

    /**
     * Initialize this singleton.
     */
    protected function init()
    {
        $this->settings = Settings::instance();

        $this->dbHandler = app()->make('Renatio\BackupManager\Classes\DatabaseBackupHandler');

        $this->fileHandler = app()->make('Renatio\BackupManager\Classes\FilesBackupHandler');
        $this->fileHandler->setSettings($this->settings);
    }

    /**
     * Dump database action
     *
     * @return $this
     */
    public function dumpDatabase()
    {
        $this->clearFiles();

        foreach ($this->dbHandler->getFilesToBeBackedUp() as $file)
        {
            $this->files[] = ['realFile' => $file, 'fileInZip' => 'db/dump.sql'];
            $this->setFiles();
        }

        Session::put('backup.type', 'db');

        return $this;
    }

    /**
     * Prepare files for backup action
     *
     * @return array
     */
    public function prepareFiles()
    {
        $this->getFiles();

        $fileBackupHandler = $this->fileHandler
            ->setIncludedFiles($this->settings->setBackupPaths($this->settings->include))
            ->setExcludedFiles($this->settings->setBackupPaths($this->settings->exclude));

        foreach ($fileBackupHandler->getFilesToBeBackedUp() as $file)
        {
            $this->files[] = ['realFile' => $file, 'fileInZip' => 'files/' . $file];
            $this->setFiles();
        }

        Session::put('backup.type', 'app');

        return $this;
    }

    /**
     * Compress files action
     *
     * @return $this
     * @throws ApplicationException
     */
    public function compressFiles()
    {
        $this->getFiles();

        if (count($this->files) == 0)
        {
            throw new ApplicationException(trans('renatio.backupmanager::lang.backup.no_files'));
        }

        $backupZipFile = $this->fileHandler->createZip($this->files);

        $this->clearFiles();

        Session::put('backupZipFile', $backupZipFile);

        return $this;
    }

    /**
     * Copy files action
     *
     * @return $this
     */
    public function copyFiles()
    {
        $this->fileHandler->copyFilesToStorage(Session::pull('backupZipFile'));

        (new Backup)->saveRecord();

        return $this;
    }

    /**
     * Restore database action
     *
     * @return $this
     */
    public function restoreDB()
    {
        $this->dbHandler->restoreDatabase();

        return $this;
    }

    /**
     * Get dump file for restore
     *
     * @param null $id
     * @return $this
     */
    public function getDumpFile($id = null)
    {
        $id = $id ?: post('id');

        $this->fileHandler->getDumpFilePath($id);

        return $this;
    }

    /**
     * Get files from session
     */
    private function getFiles()
    {
        $this->files = Session::get('backupFiles');
    }

    /**
     * Set files in session
     */
    private function setFiles()
    {
        Session::put('backupFiles', $this->files);
    }

    /**
     * Clear files in session
     */
    private function clearFiles()
    {
        Session::forget('backupFiles');
    }

}