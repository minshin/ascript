# Backup Manager plugin

This plugin adds backed-end database and application backups management features to [OctoberCMS](http://octobercms.com).

## Features
* Backup Database and Application files with mouse click
* Amazon S3, Rackspace, Dropbox Cloud Storage support
* Configurable scheduler for automatic backups
* Extensive settings options
* Restore database from backup
* Artisan commands for working with console

> **Important note:** Backup Manager to work requires **proc_open** function to be enabled in php configuration.

# Documentation

## Usage

After installation plugin will register backend **Backup Manager** menu position. From there you will be able to manage your backups.

**Create Application Backup** button will create backup with all your project files and database dump file. You can change which files will be backup  in **Plugin Settings**. Default settings will take project **root** and exclude **storage** and **vendor** folders from it.

**Create Database Backup** button will create only database backup.

**Clean Old Backups** button will delete all backups older than 90 days. This value is configurable in **Plugin Settings**

To download backup just click position on the list.

**Restore** button will restore database from selected backup.

> **Important note:** Restore action will restore only your database! To restore application files you must overwrite them manually.

## Searching backups list
Backups names are created dynamically from current datetime. So you can easily search for backups created at specific date. For example to find backups created 2015-05-20 just type 20150520 in search box.

## Maximum execution time error

If you see following error **Maximum execution time of .. seconds exceeded** than your current server configuration does not allow for dynamic change of this php value. Probably your application backup is to large and PHP cannot do this process in single request.

Here are some tips what can you do:

1. Change **max_execution_time** property value in your PHP configuration.
2. Use [Scheduler](#scheduler) to perform automatic backups.
3. Use [Console commands](#console-commands) to perform backups.

## Settings

This plugin ships with a settings page. Go to **Settings** and you will see a menu item **Backup Manager** listed under **Backup** section.

### Source

In this section you can specify which folders and files will be included or excluded. For default plugin will take **root** path and exclude **storage** and **vendor** folder. You can specify path to folders and individual files as well. For example to exclude your database config file, add this: **config/database.php**

### Destination

Property | Description
--------------------- | ---------------------
**File System** | The filesystem(s) on which the backups will be stored. Choose one or more of the filesystems you configured in **config/filesystems.php**
**Backups Path** | The path where the backups will be saved. This path is relative to the root you configured on your chosen filesystem(s)
**Prefix** | Prefix for backup name
**Suffix** | Suffix for backup name

### Clean

Property | Description
--------------------- | ---------------------
**Max age in days** | The clean action will remove all backups on all configured filesystems that are older then this amount of days.

### MySQL

Property | Description
--------------------- | ---------------------
**MySQL dump path** | The path to the mysqldump binary. You can leave this empty if the binary is installed in the default location.
**Use extended insert** | If your server supports it you can turn on extended insert. This will result in a smaller dump file and speeds up the backup process.

> **Important note:** Currently this plugin only supports MySQL and PostgreSQL database drivers.

###  Scheduler {#scheduler}

In this section you can specify automatic plugin tasks for database backup, application backup and clean old backups actions.

Each of those tasks can be run on a regular basis. See [October Documentation](http://octobercms.com/docs/plugin/registration#scheduled-tasks) for details.

> **Important note:** For scheduler to work you need to add this cron job on your server: * * * * * php /path/to/artisan schedule:run 1>> /dev/null 2>&1 . Remember to replace path to artisan command. Follow [Laravel documentation](http://laravel.com/docs/master/scheduling#introduction) for details.

## Amazon S3, Rackspace, Dropbox Cloud Storage

Plugin supports following storage drivers:
* Local Storage
* Amazon S3 Cloud Storage
* Rackspace Cloud Storage
* Dropbox Cloud Storage

More drivers can be added on feature requests. Just create an issue with **[Feature Request]** in title and I will see what can be done.

The filesystem configuration file is located at **config/filesystems.php**. Within this file you may configure all of your "disks". Example configurations for each supported driver is included in the configuration file. So, simply modify the configuration to reflect your storage preferences and credentials!

> **Important note:** For Amazon S3 and Rackspace to work you must install [October Drivers Plugin](http://octobercms.com/plugin/october-drivers).

### Dropbox configuration

First go to **config/filesystems.php** and add following code if not present already:

    'dropbox'   => [
        'driver'   => 'dropbox',
        'token'  => '',
        'key'    => '',
        'secret' => '',
        'app'    => '',
    ],

Go to [https://www.dropbox.com/developers/apps](https://www.dropbox.com/developers/apps) to obtain all necessary credentials.

Fill in configuration section with your credentials.

Go to plugin settings and check dropbox filesystem in **Destination** tab.

## Console commands {#console-commands}

Plugin will create three new artisan commands for working with console.

**backup:run** command will run new backup process. You can specify **--only-db** option for backup only database.

**backup:clean** command will run clean old backups process.

**backup:restore** command will run restore backup process. You can specify **--backup-id** option for selecting backup ID to restore or choose Id from list of backups printed in console.

> **Important note:** Restore command will restore only your database! To restore application files you must overwrite them manually.