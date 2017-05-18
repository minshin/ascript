<?php namespace Uxms\Matrix\Models;

use Model;

class Table extends Model
{
    protected $table = 'uxms_matrix_tables';

    protected $jsonable = ['matrix_data', 'column_names', 'row_names'];
}
