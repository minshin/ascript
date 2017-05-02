<?php namespace Renatio\BackupManager\Classes;

/**
 * Interface BackupHandlerInterface
 * @package Renatio\BackupManager\Classes
 */
interface BackupHandlerInterface
{

    /**
     * Returns an array of files which should be backed up.
     *
     * @return array
     */
    public function getFilesToBeBackedUp();

}