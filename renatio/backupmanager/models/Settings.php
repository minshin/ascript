<?php namespace Renatio\BackupManager\Models;

use Model;
use Config;

/**
 * Class Settings
 * @package Renatio\BackupManager\Models
 */
class Settings extends Model
{

    /**
     * @var array
     */
    public $implement = ['System.Behaviors.SettingsModel'];

    /**
     * @var string
     */
    public $settingsCode = 'renatio_backupmanager_settings';

    /**
     * @var string
     */
    public $settingsFields = 'fields.yaml';

    /**
     * Get filesystems options
     *
     * @return array
     */
    public function getFilesystemOptions()
    {
        $disks = Config::get('filesystems.disks');

        $options = [];

        foreach ($disks as $key => $disk) {
            $options[$key] = $key;
        }

        return $options;
    }

    /**
     * Init default settings
     */
    public function initSettingsData()
    {
        foreach ($this->getDefaultSettings() as $key => $setting) {
            $this->{$key} = $setting;
        }
    }

    /**
     * Get default backup settings
     *
     * @return array
     */
    public function getDefaultSettings()
    {
        return [
            'include' => [
                ['path' => 'root']
            ],
            'exclude' => [
                ['path' => 'storage'],
                ['path' => 'vendor']
            ],
            'filesystem' => ['local'],
            'backups_path' => 'backups',
            'prefix' => '',
            'suffix' => '',
            'max_age_in_days' => 90,
            'dump_command_path' => '',
            'use_extended_insert' => false,
        ];
    }

    /**
     * Populate include or exclude backup paths
     *
     * @param $values
     * @return array
     */
    public function setBackupPaths($values)
    {
        $paths = [];

        foreach ($values as $val) {
            $paths[] = base_path(str_replace('root', '', $val['path']));
        }

        return $paths;
    }

    /**
     * Get scheduler options
     *
     * @return array
     */
    public function getSchedulerOptions()
    {
        return [
            '' => trans('renatio.backupmanager::lang.schedule.choose'),
            'everyFiveMinutes' => trans('renatio.backupmanager::lang.schedule.every_five_minutes'),
            'everyTenMinutes' => trans('renatio.backupmanager::lang.schedule.every_ten_minutes'),
            'everyThirtyMinutes' => trans('renatio.backupmanager::lang.schedule.every_thirty_minutes'),
            'hourly' => trans('renatio.backupmanager::lang.schedule.hourly'),
            'daily' => trans('renatio.backupmanager::lang.schedule.daily'),
            'weekly' => trans('renatio.backupmanager::lang.schedule.weekly'),
            'monthly' => trans('renatio.backupmanager::lang.schedule.monthly'),
            'yearly' => trans('renatio.backupmanager::lang.schedule.yearly'),
        ];
    }

}