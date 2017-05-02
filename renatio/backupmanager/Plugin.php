<?php

namespace Renatio\BackupManager;

use Backend\Facades\Backend;
use Renatio\BackupManager\Classes\Schedule;
use Renatio\BackupManager\Console\Backup;
use Renatio\BackupManager\Console\Clean;
use Renatio\BackupManager\Console\Restore;
use Renatio\BackupManager\Models\Settings;
use System\Classes\PluginBase;

/**
 * Class Plugin
 * @package Renatio\BackupManager
 */
class Plugin extends PluginBase
{

    /**
     * @return array
     */
    public function pluginDetails()
    {
        return [
            'name' => 'renatio.backupmanager::lang.plugin.name',
            'description' => 'renatio.backupmanager::lang.plugin.description',
            'author' => 'Renatio',
            'icon' => 'icon-database'
        ];
    }

    /**
     * @return array
     */
    public function registerNavigation()
    {
        return [
            'backupmanager' => [
                'label' => 'renatio.backupmanager::lang.navigation.backupmanager',
                'url' => Backend::url('renatio/backupmanager/backups'),
                'icon' => 'icon-database',
                'permissions' => ['renatio.backupmanager.access_backups'],
                'order' => 500,
            ],
        ];
    }

    /**
     * @return array
     */
    public function registerPermissions()
    {
        return [
            'renatio.backupmanager.access_settings' => [
                'label' => 'renatio.backupmanager::lang.permissions.access_settings',
                'tab' => 'renatio.backupmanager::lang.permissions.tab'
            ],
            'renatio.backupmanager.access_backups' => [
                'label' => 'renatio.backupmanager::lang.permissions.access_backups',
                'tab' => 'renatio.backupmanager::lang.permissions.tab'
            ],
        ];
    }

    /**
     * @return array
     */
    public function registerSettings()
    {
        return [
            'settings' => [
                'label' => 'renatio.backupmanager::lang.settings.label',
                'description' => 'renatio.backupmanager::lang.settings.description',
                'category' => 'renatio.backupmanager::lang.settings.category',
                'icon' => 'icon-database',
                'class' => Settings::class,
                'order' => 500,
                'keywords' => 'backup manager database',
                'permissions' => ['renatio.backupmanager.access_settings']
            ]
        ];
    }

    /**
     * @return void
     */
    public function register()
    {
        $this->registerConsoleCommand('backup.clean', Clean::class);
        $this->registerConsoleCommand('backup.run', Backup::class);
        $this->registerConsoleCommand('backup.restore', Restore::class);
    }

    /**
     * @param $schedule
     */
    public function registerSchedule($schedule)
    {
        (new Schedule($schedule))
            ->databaseBackup()
            ->appBackup()
            ->cleanOldBackups();
    }

    /**
     * @return void
     */
    public function boot()
    {
        $this->app->register(DropboxFilesystemServiceProvider::class);
    }

}