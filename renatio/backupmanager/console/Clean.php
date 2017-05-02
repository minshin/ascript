<?php namespace Renatio\BackupManager\Console;

use Carbon\Carbon;
use Illuminate\Console\Command;
use Renatio\BackupManager\Models\Backup;
use Renatio\BackupManager\Models\Settings;
use Symfony\Component\Console\Input\InputOption;

/**
 * Class Clean
 * @package Renatio\BackupManager\Console
 */
class Clean extends Command
{

    /**
     * The console command name.
     *
     * @var string
     */
    protected $name = 'backup:clean';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Clean all backups older than specified number of days in settings';

    /**
     * Fire command
     */
    public function fire()
    {
        $maxAgeInDays = Settings::get('max_age_in_days');

        if ($this->option('force') || $this->confirm(trans('renatio.backupmanager::lang.clean.confirm', ['days' => $maxAgeInDays]), true))
        {
            $this->cleanAll($maxAgeInDays);
        } else
        {
            $this->info(trans('renatio.backupmanager::lang.clean.aborted'));
        }

        return true;
    }

    /**
     * Clean old backups
     *
     * @param $maxAgeInDays
     * @return int
     */
    private function cleanOldBackups($maxAgeInDays)
    {
        $expireDate = Carbon::now()->subDays($maxAgeInDays);

        $oldBackups = Backup::where('created_at', '<', $expireDate)->get();

        foreach ($oldBackups as $oldBackup)
        {
            $oldBackup->delete();
        }

        return count($oldBackups);
    }

    /**
     * Process cleaning
     *
     * @param $maxAgeInDays
     */
    private function cleanAll($maxAgeInDays)
    {
        $this->info(trans('renatio.backupmanager::lang.clean.start_info', ['days' => $maxAgeInDays]));

        $count = $this->cleanOldBackups($maxAgeInDays);

        $this->commentResult($maxAgeInDays, $count);
    }

    /**
     * Get the console command options.
     *
     * @return array
     */
    protected function getOptions()
    {
        return [
            ['force', null, InputOption::VALUE_NONE, trans('renatio.backupmanager::lang.clean.force')],
        ];
    }

    /**
     * Comment result
     *
     * @param $maxAgeInDays
     * @param $count
     */
    private function commentResult($maxAgeInDays, $count)
    {
        if ($count)
        {
            $this->comment(trans('renatio.backupmanager::lang.clean.deleted_info', ['count' => $count]));
        } else
        {
            $this->comment(trans('renatio.backupmanager::lang.clean.no_backups', ['days' => $maxAgeInDays]));
        }
        $this->info(trans('renatio.backupmanager::lang.clean.complete_message'));
    }

}