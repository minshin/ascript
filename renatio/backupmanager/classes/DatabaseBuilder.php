<?php

namespace Renatio\BackupManager\Classes;

use Exception;

/**
 * Class DatabaseBuilder
 * @package Renatio\BackupManager\Classes
 */
class DatabaseBuilder
{

    /**
     * @var
     */
    protected $database;

    /**
     * @var Console
     */
    protected $console;

    /**
     * Instantiate console
     *
     * @param Console $console
     */
    public function __construct(Console $console)
    {
        $this->console = $console;
    }

    /**
     * Get database
     *
     * @param array $realConfig
     * @param $driver
     * @return mixed
     * @throws Exception
     */
    public function getDatabase(array $realConfig, $driver)
    {
        $this->buildDatabase($realConfig, $driver);

        return $this->database;
    }

    /**
     * Build up database
     *
     * @param array $config
     * @param $driver
     * @throws Exception
     */
    protected function buildDatabase(array $config, $driver)
    {
        switch ($driver) {
            case 'mysql':
                $this->buildMySQL($config);
                break;

            case 'pgsql':
                $this->buildPgSQL($config);
                break;
        }
    }

    /**
     * Determine the host from the given config.
     *
     * @param array $config
     * @return mixed
     * @throws Exception
     */
    public function determineHost(array $config)
    {
        if (isset($config['host'])) {
            return $config['host'];
        }

        if (isset($config['read']['host'])) {
            return $config['read']['host'];
        }

        throw new Exception(trans('renatio.backupmanager::lang.database.determine_host'));
    }

    /**
     * Build MySql database
     *
     * @param array $config
     * @throws Exception
     */
    private function buildMySQL(array $config)
    {
        $port = ! empty($config['port']) ? $config['port'] : 3306;

        $socket = isset($config['unix_socket']) ? $config['unix_socket'] : '';

        $this->database = new MySQLDatabase(
            $this->console,
            $config['database'],
            $config['username'],
            $config['password'],
            $this->determineHost($config),
            $port,
            $socket
        );
    }

    /**
     * Build Postgres database
     *
     * @param $config
     * @throws Exception
     */
    private function buildPgSQL($config)
    {
        $port = ! empty($config['port']) ? $config['port'] : 5432;

        $this->database = new PgSQLDatabase(
            $this->console,
            $config['database'],
            $config['username'],
            $config['password'],
            $this->determineHost($config),
            $port
        );
    }

}