<?php namespace Uxms\Matrix\Updates;

use Illuminate\Support\Facades\Schema;
use October\Rain\Database\Updates\Migration;

class CreateUxmsMatrixTables extends Migration
{
    public function up()
    {
        Schema::create('uxms_matrix_tables', function ($table)
        {
            $table->engine = 'InnoDB';
            $table->increments('id');
            $table->string('name');
            $table->text('columns_title')->nullable();
            $table->string('prefix')->nullable();
            $table->string('suffix')->nullable();
            $table->text('column_names')->nullable();
            $table->text('row_names')->nullable();
            $table->longText('matrix_data')->nullable();

            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('uxms_matrix_tables');
    }
}
