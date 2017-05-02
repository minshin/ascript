<?php namespace Renatio\BackupManager\Classes;

use Config;
use Renatio\BackupManager\Models\Settings;

/**
 * Class MySQLDatabase
 * @package Renatio\BackupManager\Classes
 */
class MySQLDatabase implements DatabaseInterface
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
     * @var
     */
    protected $socket;


    /**
     * @param Console $console
     * @param $database
     * @param $user
     * @param $password
     * @param $host
     * @param $port
     * @param $socket
     */
    public function __construct(Console $console, $database, $user, $password, $host, $port, $socket)
    {
        $this->console = $console;
        $this->database = $database;
        $this->user = $user;
        $this->password = $password;
        $this->host = $host;
        $this->port = $port;
        $this->socket = $socket;
    }

    /**
     * Create a database dump.
     *
     * @param $destinationFile
     * @return bool|string
     */
    public function dump($destinationFile)
    {
        $tempFileHandle = tmpfile();
        fwrite($tempFileHandle,
            "[client]" . PHP_EOL .
            "user = '" . $this->user . "'" . PHP_EOL .
            "password = '" . $this->password . "'" . PHP_EOL .
            "host = '" . $this->host . "'" . PHP_EOL .
            "port = '" . $this->port . "'" . PHP_EOL
        );
        $temporaryCredentialsFile = stream_get_meta_data($tempFileHandle)['uri'];

        $command = sprintf('%smysqldump --defaults-extra-file=%s --skip-comments ' .
            ($this->useExtendedInsert() ? '--extended-insert ' : '--skip-extended-insert ') .
            $this->getExtraParameters() .
            ' %s > %s %s',
            $this->getDumpCommandPath(),
            escapeshellarg($temporaryCredentialsFile),
            escapeshellarg($this->database),
            escapeshellarg($destinationFile),
            escapeshellcmd($this->getSocketArgument())
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
        $tempFileHandle = tmpfile();
        fwrite($tempFileHandle,
            "[client]" . PHP_EOL .
            "user = '" . $this->user . "'" . PHP_EOL .
            "password = '" . $this->password . "'" . PHP_EOL .
            "host = '" . $this->host . "'" . PHP_EOL .
            "port = '" . $this->port . "'" . PHP_EOL
        );
        $temporaryCredentialsFile = stream_get_meta_data($tempFileHandle)['uri'];

        $command = sprintf('mysql --defaults-extra-file=%s %s < %s',
            escapeshellarg($temporaryCredentialsFile),
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
     * Get the path to the mysqldump.
     *
     * @return string
     */
    protected function getDumpCommandPath()
    {
        return Settings::get('dump_command_path');
    }

    /**
     * Determine if the dump should use extended-insert.
     *
     * @return string
     */
    protected function useExtendedInsert()
    {
        return Settings::get('use_extended_insert');
    }

    /**
     * Get extra parameters.
     *
     * @return string
     */
    protected function getExtraParameters()
    {
        return Settings::get('extra_parameters');
    }

    /**
     * Set the socket if one is specified in the configuration.
     *
     * @return string
     */
    protected function getSocketArgument()
    {
        if ($this->socket != '') {
            return '--socket=' . $this->socket;
        }

        return '';
    }

}