<?php namespace Renatio\BackupManager\Controllers;

use BackendMenu;
use Flash;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use ApplicationException;
use Illuminate\Support\Facades\Artisan;
use Redirect;
use Backend\Classes\Controller;
use Renatio\BackupManager\Classes\BackupManager;
use Renatio\BackupManager\Models\Backup;
use Symfony\Component\HttpFoundation\ResponseHeaderBag;
use Symfony\Component\HttpFoundation\StreamedResponse;
use System\Classes\SettingsManager;

/**
 * Backups Back-end Controller
 */
class Backups extends Controller
{

    /**
     * @var array
     */
    public $requiredPermissions = ['renatio.backupmanager.access_backups'];

    /**
     * @var array
     */
    public $implement = [
        'Backend.Behaviors.ListController'
    ];

    /**
     * @var array
     */
    protected $options = [];

    /**
     * @var string
     */
    public $listConfig = 'config_list.yaml';

    /**
     * Constructor
     */
    public function __construct()
    {
        parent::__construct();

        $this->addJs('/plugins/renatio/backupmanager/assets/js/backup.js');

        BackendMenu::setContext('Renatio.BackupManager', 'backupmanager', 'backups');
        SettingsManager::setContext('Renatio.BackupManager', 'settings');
    }

    /**
     * Index method
     */
    public function index()
    {
        $this->checkSystemRequirements();

        $this->asExtension('ListController')->index();
    }

    /**
     * On create backup action
     *
     * @return mixed
     * @throws \SystemException
     */
    public function onCreateBackup()
    {
        try
        {
            $this->vars['backupSteps'] = $this->buildBackupSteps(post('only_db'));

        } catch (Exception $ex)
        {
            $this->handleError($ex);
        }

        return $this->makePartial('execute');
    }

    /**
     * Build backup steps
     *
     * @param int $only_db
     * @return array
     */
    protected function buildBackupSteps($only_db = 0)
    {
        /*
         * Dump database
         */
        $backupSteps[] = [
            'code'  => 'dumpDatabase',
            'label' => trans('renatio.backupmanager::lang.backups.dump_database'),
        ];

        /*
        * Prepare files for backup
        */
        if ( ! $only_db)
        {
            $backupSteps[] = [
                'code'  => 'prepareFiles',
                'label' => trans('renatio.backupmanager::lang.backups.prepare_files'),
            ];
        }

        /*
        * Compress files
        */
        $backupSteps[] = [
            'code'  => 'compressFiles',
            'label' => trans('renatio.backupmanager::lang.backups.compress_files'),
        ];

        /*
        * Copy files to storage
        */
        $backupSteps[] = [
            'code'  => 'copyFiles',
            'label' => trans('renatio.backupmanager::lang.backups.copy_files'),
        ];

        /*
        * Finish up
        */
        $backupSteps[] = [
            'code'  => 'completeBackup',
            'label' => trans('renatio.backupmanager::lang.backups.backup_completing'),
        ];

        return $backupSteps;
    }

    /**
     * Build restore steps
     *
     * @return array
     */
    protected function buildRestoreSteps()
    {
        /*
        * Get dump file from storage
        */
        $restoreSteps[] = [
            'code'  => 'getDumpFile',
            'label' => trans('renatio.backupmanager::lang.restore.preparing_files'),
            'id'    => post('id')
        ];

        /*
        * Restore database
        */
        $restoreSteps[] = [
            'code'  => 'restoreDatabase',
            'label' => trans('renatio.backupmanager::lang.restore.restoring_db'),
        ];

        /*
        * Finish up
        */
        $restoreSteps[] = [
            'code'  => 'completeRestore',
            'label' => trans('renatio.backupmanager::lang.restore.completing'),
        ];

        return $restoreSteps;
    }

    /**
     * Run a specific backup/restore step
     *
     * @return mixed
     * @throws ApplicationException
     */
    public function onExecuteStep()
    {
        /*
         * Address timeout limits
         */
        @set_time_limit(3600);

        $manager = BackupManager::instance();
        $stepCode = post('code');

        switch ($stepCode)
        {
            case 'dumpDatabase':
                $manager->dumpDatabase();
                break;

            case 'prepareFiles':
                $manager->prepareFiles();
                break;

            case 'compressFiles':
                $manager->compressFiles();
                break;

            case 'copyFiles':
                $manager->copyFiles();
                break;

            case 'getDumpFile':
                $manager->getDumpFile();
                break;

            case 'restoreDatabase':
                $manager->restoreDB();
                break;

            case 'completeRestore':
                Flash::success(trans('renatio.backupmanager::lang.restore.success'));

                return Redirect::refresh();
            case 'completeBackup':
                Flash::success(trans('renatio.backupmanager::lang.backups.backup_success'));

                return Redirect::refresh();
        }
    }

    /**
     * Delete checked backups
     *
     * @return mixed
     */
    public function index_onDelete()
    {
        if (($checkedIds = post('checked')) && is_array($checkedIds) && count($checkedIds))
        {

            $this->deleteCheckedBackups($checkedIds);

        } else
        {
            Flash::error(trans('renatio.backupmanager::lang.backups.delete_selected_empty'));
        }

        return $this->listRefresh();
    }

    /**
     * Clean old backups action
     *
     * @return mixed
     */
    public function index_onClean()
    {
        Artisan::call('backup:clean', ['--force' => true]);

        Flash::success(trans('renatio.backupmanager::lang.clean.complete_message'));

        return $this->listRefresh();
    }


    /**
     * Load restore form
     *
     * @return mixed
     * @throws \SystemException
     */
    public function onLoadRestore()
    {
        try
        {
            $this->vars['backup'] = $this->getBackupForRestore();

        } catch (Exception $ex)
        {
            $this->handleError($ex);
        }

        return $this->makePartial('restore_form');
    }

    /**
     * Restore database action
     *
     * @return mixed
     * @throws \SystemException
     */
    public function onRestore()
    {
        try
        {
            $this->vars['backupSteps'] = $this->buildRestoreSteps();

        } catch (Exception $ex)
        {
            $this->handleError($ex);
        }

        return $this->makePartial('execute');
    }

    /**
     * Download backup
     *
     * @param $id
     * @return Backups
     */
    public function download($id)
    {
        try
        {
            $backup = Backup::findOrFail($id);

            return $this->generateDownloadResponse($backup);

        } catch (ModelNotFoundException $e)
        {
            Flash::error(trans('renatio.backupmanager::lang.backups.backup_not_found'));

        } catch (ApplicationException $e)
        {
            Flash::error($e->getMessage());
        }

        return Redirect::back();
    }

    /**
     * Delete checked backups
     *
     * @param $checkedIds
     */
    private function deleteCheckedBackups($checkedIds)
    {
        foreach ($checkedIds as $backupId)
        {
            if ( ! $backup = Backup::find($backupId)) continue;
            $backup->delete();
        }

        Flash::success(trans('renatio.backupmanager::lang.backups.delete_selected_success'));
    }

    /**
     * Generate download response
     *
     * @param Backup $backup
     * @return StreamedResponse
     */
    private function generateDownloadResponse(Backup $backup)
    {
        $response = new StreamedResponse(
            function () use ($backup)
            {
                $backup->readStream();
            });

        $response->headers->set('Content-Type', 'application/zip');
        $contentDisposition = $response->headers->makeDisposition(ResponseHeaderBag::DISPOSITION_ATTACHMENT, $backup->disk_name);
        $response->headers->set('Content-Disposition', $contentDisposition);

        return $response;
    }

    /**
     * Get backup for restore action
     *
     * @return mixed
     * @throws ApplicationException
     */
    private function getBackupForRestore()
    {
        $checked = post('checked');

        if (count($checked) !== 1)
        {
            throw new ApplicationException(trans('renatio.backupmanager::lang.restore.invalid_check'));
        }

        try
        {
            return Backup::findOrFail($checked[0]);

        } catch (ModelNotFoundException $ex)
        {
            throw new ApplicationException(trans('renatio.backupmanager::lang.restore.invalid_check'));
        }
    }

    /**
     * Check system requirements
     */
    private function checkSystemRequirements()
    {
        $showHint = false;
        $issues = [];
        if (ini_get('memory_limit') < 128)
        {
            $issues[] = trans('renatio.backupmanager::lang.issue.memory_limit', ['limit' => ini_get('memory_limit')]);
            $showHint = true;
        }

        $this->vars['showHint'] = $showHint;
        $this->vars['issues'] = $issues;
    }
}