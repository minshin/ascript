<?php namespace Renatio\BackupManager\Models;

use Artisan;
use Model;
use ApplicationException;
use Session;
use File;
use Storage;

/**
 * Backup Model
 */
class Backup extends Model
{

    /**
     * @var string The database table used by the model.
     */
    public $table = 'renatio_backupmanager_backups';

    /**
     * @var array Fillable fields
     */
    protected $fillable = [
        'disk_name',
        'file_path',
        'type',
        'filesystems',
        'file_size'
    ];

    /**
     * Save backup record
     */
    public function saveRecord()
    {
        $backup = Session::pull('backup');

        $filePath = $backup['file_path'];

        self::create([
            'disk_name'   => basename($filePath),
            'file_path'   => $filePath,
            'type'        => $backup['type'],
            'filesystems' => implode(', ', Settings::get('filesystem')),
        ]);
    }

    /**
     * Bind before create event
     */
    public function beforeCreate()
    {
        $this->file_size = $this->getFileSize($this->file_path);
    }

    /**
     * Get file size
     *
     * @param $filePath
     * @return mixed
     */
    public function getFileSize($filePath)
    {
        foreach ($this->getFilesystems() as $fileSystem)
        {
            return Storage::disk($fileSystem)->size($filePath);
        }
    }

    /**
     * Get pretty file size
     *
     * @param $val
     * @return mixed
     */
    public function getFileSizeAttribute($val)
    {
        return File::sizeToString($val);
    }

    /**
     * Bind to before delete event
     */
    public function beforeDelete()
    {
        $this->deleteFile();
    }

    /**
     * Delete backup file for each file system
     */
    private function deleteFile()
    {
        foreach ($this->getFilesystems() as $fileSystem)
        {
            $this->deleteFilesystemFile($fileSystem);
        }
    }

    /**
     * Get file
     *
     * @return mixed
     * @throws ApplicationException
     */
    public function getFile()
    {
        foreach ($this->getFilesystems() as $fileSystem)
        {
            if ($this->fileExists($fileSystem))
            {
                return Storage::disk($fileSystem)->get($this->file_path);
            }
        }

        throw new ApplicationException(trans('renatio.backupmanager::lang.backups.file_not_found'));
    }

    /**
     * Read stream to get backup
     *
     * @return bool
     */
    public function readStream()
    {
        foreach ($this->getFilesystems() as $fileSystem)
        {
            if ($this->fileExists($fileSystem))
            {
                if ($fileSystem == 'local')
                {
                    $fp = fopen(storage_path('app/' . $this->file_path), 'rb');
                    fpassthru($fp);
                } else
                {
                    $stream = Storage::disk($fileSystem)->getDriver()->readStream($this->file_path);
                    fpassthru($stream);
                }

                return true;
            }
        }
    }

    /**
     * Check file exists in filesystem
     *
     * @param $fileSystem
     * @return mixed
     */
    public function fileExists($fileSystem)
    {
        return Storage::disk($fileSystem)->exists($this->file_path);
    }

    /**
     * Delete file from filesystem
     *
     * @param $fileSystem
     */
    private function deleteFilesystemFile($fileSystem)
    {
        if ($this->fileExists($fileSystem))
        {
            Storage::disk($fileSystem)->delete($this->file_path);
        }
    }

    /**
     * Get filesystems
     *
     * @return array
     */
    private function getFilesystems()
    {
        return explode(', ', $this->filesystems);;
    }

    /**
     * Delete local file
     */
    public function deleteLocalFile()
    {
        if (strpos($this->filesystems, 'local') === false)
        {
            Storage::disk('local')->delete($this->file_path);
        }
    }
}