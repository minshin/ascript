<?php namespace Uxms\Matrix\Controllers;

use Backend\Facades\BackendMenu;
use Backend\Classes\Controller;
use October\Rain\Support\Facades\Flash;
use System\Classes\SettingsManager;
use Uxms\Matrix\Models\Table;


class Tables extends Controller
{
    public $implement = [
        'Backend.Behaviors.FormController',
        'Backend.Behaviors.ListController'
    ];

    public $requiredPermissions = ['uxms.matrix.tables'];

    public $formConfig = 'config_form.yaml';
    public $listConfig = 'config_list.yaml';

    public $ip_blacklist = '';

    public function __construct()
    {
        parent::__construct();

        BackendMenu::setContext('Uxms.Matrix', 'matrix', 'tables');
        SettingsManager::setContext('Uxms.Matrix', 'tables');
    }

    public function onEmptyLog()
    {
        Table::truncate();
        Flash::success(trans('uxms.matrix::lang.tables.empty_ok'));
        return $this->listRefresh();
    }

    public function index_onDelete()
    {
        if (($checkedIds = post('checked')) && is_array($checkedIds) && count($checkedIds)) {
            foreach ($checkedIds as $recordId) {
                if (!$record = Table::find($recordId))
                    continue;

                $record->delete();
            }

            Flash::success(trans('backend::lang.list.delete_selected_success'));
        } else {
            Flash::error(trans('backend::lang.list.delete_selected_empty'));
        }

        return $this->listRefresh();
    }
}
