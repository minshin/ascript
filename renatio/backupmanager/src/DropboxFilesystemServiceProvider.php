<?php namespace Renatio\BackupManager;

use Storage;
use League\Flysystem\Filesystem;
use Dropbox\Client as DropboxClient;
use League\Flysystem\Dropbox\DropboxAdapter;
use Illuminate\Support\ServiceProvider;

/**
 * Class DropboxFilesystemServiceProvider
 * @package Renatio\BackupManager
 */
class DropboxFilesystemServiceProvider extends ServiceProvider
{

    /**
     * Boot dropbox filesystem
     */
    public function boot()
    {
        Storage::extend('dropbox', function ($app, $config)
        {
            $client = new DropboxClient($config['token'], $config['secret']);

            return new Filesystem(new DropboxAdapter($client));
        });
    }

    /**
     * Satisfy the contract
     */
    public function register() {}

}