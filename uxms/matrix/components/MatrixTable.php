<?php namespace Uxms\Matrix\Components;

use Cms\Classes\ComponentBase;
use Uxms\Matrix\Models\Table as MatrixModel;


class MatrixTable extends ComponentBase
{
    private $table = null;

    public function componentDetails()
    {
        return [
            'name'          => 'uxms.matrix::lang.components.table.name',
            'description'   => 'uxms.matrix::lang.components.table.desc'
        ];
    }

    public function defineProperties()
    {
        return [
            'table' => [
                'title'       => 'uxms.matrix::lang.components.table.table_name',
                'description' => 'uxms.matrix::lang.components.table.table_desc',
                'type'        => 'dropdown',
                'default'     => ''
            ]
        ];
    }

    public function getTableOptions()
    {
        return ['' => '- choose -'] + MatrixModel::lists('name', 'id');
    }

    /**
     * Returns a defined property or parameter value.
     *
     * @param $name - The property or parameter name to look for.
     * @param $default - A default value to return if no value found.
     * @return string
     */
    public function propertyOrParam($name, $default = null)
    {
        $value = $this->property($name, $default);

        if (substr($name, 0, 1) == ':')
            return $this->param(str_replace(':', '', $name), $default);

        return $value;
    }

    public function onRun()
    {
        $this->table = MatrixModel::find($this->propertyOrParam('table'));
    }

    public function onRender()
    {
        if ($this->table)
            return $this->buildHtmlTable();
        else
            return null;
    }

    public function tableData()
    {
        return $this->table;
    }

    private function buildHtmlTable()
    {
        $tableHtml = '
        <table class="table table-bordered table-hover ux-table">
            <thead>';
        if ($this->table->columns_title):
            $tableHtml .= '
                <tr>
                    <th></th>
                    <th colspan="4" style="text-align: center;">'.$this->table->columns_title.'</th>
                </tr>';
        endif;
        $tableHtml .= '
                <tr>
                    <th></th>';
                    foreach ($this->table->column_names as $column) {
                        $tableHtml .= '<th><span>'.$column["col"].'</span></th>';
                    }
        $tableHtml .= '
                </tr>
            </thead>
            <tbody>';
                foreach ($this->table->row_names as $rowKey => $row) {
                    $tableHtml .= '
                    <tr>
                        <td class="list-checkbox">'.$row["row"].'</td>';
                    foreach ($this->table->column_names as $colKey => $column) {
                        $tableHtml .= '
                            <td>
                                <div>'.(isset($this->table->matrix_data[$rowKey."_".$colKey]) ? $this->table->prefix.$this->table->matrix_data[$rowKey."_".$colKey].$this->table->suffix : "").'</div>
                            </td>';
                    }
                    $tableHtml .= '
                        </tr>';
                }
        $tableHtml .= '
            </tbody>
        </table>';

        return $tableHtml;
    }
}
