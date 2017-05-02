<?php namespace Renatio\BackupManager\Console;

use Illuminate\Console\Command;
use Renatio\BackupManager\Classes\BackupManager;
use Renatio\BackupManager\Models\Backup as BackupModel;
use Symfony\Component\Console\Input\InputOption;

/**
 * Class Restore
 * @package Renatio\BackupManager\Console
 */
class Restore extends Command
{

    /**
     * The console command name.
     *
     * @var string
     */
    protected $name = 'backup:restore';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Restore database backup';

    /**
     * Fire command
     *
     * @return bool
     */
    public function fire()
    {
        $manager = BackupManager::instance();

        if ($this->askBackupId())
        {
            /*
            * Get dump file
            */
            $this->comment(trans('renatio.backupmanager::lang.restore.preparing_files'));
            $manager->getDumpFile($this->option('backup-id'));

            /*
             * Restore database
             */
            $this->comment(trans('renatio.backupmanager::lang.restore.restoring_db'));
            $manager->restoreDB();

            $this->info(trans('renatio.backupmanager::lang.restore.success'));

            return true;
        }
    }

    /**
     * Ask question about backup id
     *
     * @return bool
     */
    private function askBackupId()
    {
        $backups = BackupModel::all();

        if ( ! $backups)
        {
            $this->info(trans('renatio.backupmanager::lang.restore.no_backups'));

            return false;
        }

        $backupId = $this->getBackupIdOption($backups);

        if ( ! BackupModel::find($backupId))
        {
            $this->error(trans('renatio.backupmanager::lang.restore.backup_not_exist'));

            return false;
        }

        $this->input->setOption('backup-id', $backupId);

        return true;
    }

    /**
     * Get the console command options.
     *
     * @return array
     */
    protected function getOptions()
    {
        return [
            ['backup-id', null, InputOption::VALUE_REQUIRED, trans('renatio.backupmanager::lang.restore.backup_ask'), null],
        ];
    }

    /**
     * Print console table
     *
     * @param $backups
     */
    private function printBackupsTable($backups)
    {
        $rows = [];

        foreach ($backups as $backup)
        {
            $rows[] = [
                $backup->id,
                $backup->disk_name,
                $backup->file_size,
                $backup->created_at->toDayDateTimeString()
            ];
        }

        $this->info(trans('renatio.backupmanager::lang.restore.available_backups'));
        $this->table([
            trans('renatio.backupmanager::lang.field.id'),
            trans('renatio.backupmanager::lang.field.disk_name'),
            trans('renatio.backupmanager::lang.field.file_size'),
            trans('renatio.backupmanager::lang.field.created_at'),
        ], $rows);
    }

    /**
     * Get backup id option
     *
     * @param $backups
     * @return array|string
     */
    private function getBackupIdOption($backups)
    {
        $backupId = $this->option('backup-id');
        if ( ! $backupId)
        {
            $this->printBackupsTable($backups);

            $backupId = $this->ask(trans('renatio.backupmanager::lang.restore.choose_backup'));
        }

        return $backupId;
    }

}