<?php namespace Renatio\BackupManager\Classes;

use Config;
use Renatio\BackupManager\Models\Settings;
use Log;

/**
 * Class PgSQLDatabase
 * @package Renatio\BackupManager\Classes
 */
class PgSQLDatabase implements DatabaseInterface
{

    /**
     * @var Console
     */
    protected $console;

    /**
     * @var
     */
    protected $database;

    /**
     * @var
     */
    protected $user;

    /**
     * @var
     */
    protected $password;

    /**
     * @var
     */
    protected $host;

    /**
     * @var
     */
    protected $port;

    /**
     * @param Console $console
     * @param $database
     * @param $user
     * @param $password
     * @param $host
     * @param $port
     */
    public function __construct(Console $console, $database, $user, $password, $host, $port)
    {
        $this->console = $console;
        $this->database = $database;
        $this->user = $user;
        $this->password = $password;
        $this->host = $host;
        $this->port = $port;
    }

    /**
     * Create a database dump.
     *
     * @param $destinationFile
     * @return bool|string
     */
    public function dump($destinationFile)
    {
        $command = sprintf('PGPASSWORD=%s %spg_dump --host=%s --port=%s --username=%s -c %s -f %s',
            escapeshellarg($this->password),
            $this->getDumpCommandPath(),
            escapeshellarg($this->host),
            escapeshellarg($this->port),
            escapeshellarg($this->user),
            escapeshellarg($this->database),
            escapeshellarg($destinationFile)
        );

        return $this->console->run($command);
    }

    /**
     * Restore database
     *
     * @param $inputFile
     * @return bool|string
     */
    public function restore($inputFile)
    {
        $command = sprintf('PGPASSWORD=%s psql --host=%s --port=%s --user=%s %s -f %s',
            escapeshellarg($this->password),
            escapeshellarg($this->host),
            escapeshellarg($this->port),
            escapeshellarg($this->user),
            escapeshellarg($this->database),
            escapeshellarg($inputFile)
        );

        return $this->console->run($command);
    }

    /**
     * Get the default file extension.
     *
     * @return string
     */
    public function getFileExtension()
    {
        return 'sql';
    }

    /**
     * Get the path to the pg_dump.
     *
     * @return string
     */
    protected function getDumpCommandPath()
    {
        return Settings::get('dump_command_path');
    }

    /**
     * Set the socket if one is specified in the configuration.
     *
     * @return string
     */
    protected function getSocketArgument()
    {
        if ($this->socket != '')
        {
            return '--socket=' . $this->socket;
        }

        return '';
    }

}