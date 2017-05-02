<?php

namespace Renatio\BackupManager\Tests;

use App;
use Renatio\BackupManager\Plugin;
use TestCase;

/**
 * Class PluginTest
 * @package Renatio\BackupManager\Tests
 */
class PluginTest extends TestCase
{

    /**
     * @var
     */
    protected $plugin;

    /**
     * @return void
     */
    public function setUp()
    {
        parent::setUp();

        $this->plugin = new Plugin(new App);
    }

    /** @test */
    public function it_provides_plugin_details()
    {
        $this->assertArrayHasKey('name', $this->plugin->pluginDetails());
        $this->assertArrayHasKey('description', $this->plugin->pluginDetails());
    }

    /** @test */
    public function it_registers_navigation()
    {
        $this->assertArrayHasKey('backupmanager', $this->plugin->registerNavigation());
    }

    /** @test */
    public function it_registers_permissions()
    {
        $this->assertArrayHasKey('renatio.backupmanager.access_backups', $this->plugin->registerPermissions());
        $this->assertArrayHasKey('renatio.backupmanager.access_settings', $this->plugin->registerPermissions());
    }

    /** @test */
    public function it_registers_settings()
    {
        $this->assertArrayHasKey('settings', $this->plugin->registerSettings());
    }

}