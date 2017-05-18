<?php namespace Uxms\Matrix\Controllers;

use Backend\Facades\BackendMenu;
use Backend\Classes\Controller;
use Illuminate\Support\Facades\Input;
use October\Rain\Support\Facades\Flash;
use System\Classes\SettingsManager;
use Uxms\Matrix\Models\Table;


class Datas extends Controller
{
    public $implement = [
        'Backend.Behaviors.FormController',
        'Backend.Behaviors.ListController'
    ];

    public $requiredPermissions = ['uxms.matrix.datas'];

    public $formConfig = 'config_form.yaml';
    public $listConfig = 'config_list.yaml';

    protected $vData = [];
    protected $vMatrixData = [];

    public function __construct()
    {
        parent::__construct();

        BackendMenu::setContext('Uxms.Matrix', 'matrix', 'datas');
        SettingsManager::setContext('Uxms.Matrix', 'datas');

        if ($this->action == 'update') {
            $tbl = Table::find($this->params[0]);

            $this->vData['id'] = $tbl->id;
            $this->vData['columnHeads'] = $tbl->column_names;
            $this->vData['rowHeads'] = $tbl->row_names;
            $this->vMatrixData = $tbl->matrix_data;
        }
    }

    public function onUpdateTableData()
    {
        try {
            $tbl = Table::find(Input::get('tableid'));
            $tbl->matrix_data = Input::get('matrixdata');
            $tbl->save();

            Flash::success(trans('uxms.matrix::lang.datas.success'));
        } catch (\Exception $e) {
            Flash::error($e->getMessage());
        }
    }
}
