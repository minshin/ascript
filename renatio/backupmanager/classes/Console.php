<?php namespace Renatio\BackupManager\Classes;

use Symfony\Component\Process\Process;

/**
 * Class Console
 * @package Renatio\BackupManager\Classes
 */
class Console
{

    /**
     * Run console
     *
     * @param $command
     * @return bool|string
     */
    public function run($command)
    {
        $process = new Process($command);

        $process->setTimeout(60 * 5);

        $process->run();

        if ($process->isSuccessful())
        {
            return true;
        } else
        {
            return $process->getErrorOutput();
        }
    }

}