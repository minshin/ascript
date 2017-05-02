<?php namespace Renatio\BackupManager\Classes;

/**
 * Interface DatabaseInterface
 * @package Renatio\BackupManager\Classes
 */
interface DatabaseInterface
{

    /**
     * Create a database dump.
     *
     * @param $destinationFile
     * @return mixed
     */
    public function dump($destinationFile);

    /**
     * Return the file extension of a dump file (sql, ...).
     *
     * @return string
     */
    public function getFileExtension();

}