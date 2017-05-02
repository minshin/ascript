<?php namespace Renatio\BackupManager\Console;

use Illuminate\Console\Command;
use Renatio\BackupManager\Classes\BackupManager;
use Symfony\Component\Console\Input\InputOption;

/**
 * Class Backup
 * @package Renatio\BackupManager\Console
 */
class Backup extends Command
{

    /**
     * The console command name.
     *
     * @var string
     */
    protected $name = 'backup:run';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Run the backup';

    /**
     * Execute the console command.
     *
     * @return bool
     */
    public function fire()
    {
        $manager = BackupManager::instance();

        $this->info(trans('renatio.backupmanager::lang.backup_command.start'));

        /*
         * Dump database
         */
        $this->comment(trans('renatio.backupmanager::lang.backups.dump_database'));
        $manager->dumpDatabase();

        /*
        * Prepare files for backup
        */
        if ( ! $this->option('only-db'))
        {
            $this->comment(trans('renatio.backupmanager::lang.backups.prepare_files'));
            $manager->prepareFiles();
        }

        /*
        * Compress files
        */
        $this->comment(trans('renatio.backupmanager::lang.backups.compress_files'));
        $manager->compressFiles();

        /*
        * Copy files to storage
        */
        $this->comment(trans('renatio.backupmanager::lang.backups.copy_files'));
        $manager->copyFiles();

        $this->info(trans('renatio.backupmanager::lang.backups.backup_success'));
    }

    /**
     * Get the console command options.
     *
     * @return array
     */
    protected function getOptions()
    {
        return [
            ['only-db', null, InputOption::VALUE_NONE, trans('renatio.backupmanager::lang.backup_command.only_db')],
        ];
    }

}