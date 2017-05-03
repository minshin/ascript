<?php namespace Xeor\Comments\Updates;

use Db;
use Schema;
use October\Rain\Database\Updates\Migration;
use Xeor\Comments\Models\Comment;

class CommentsAddNestedFields extends Migration
{

    public function up()
    {
        if (Schema::hasColumn('xeor_comments_comments', 'parent_id')) {
            return;
        }

        Schema::table('xeor_comments_comments', function($table) {
            $table->renameColumn('pid', 'parent_id');
        });

        Db::statement('ALTER TABLE `xeor_comments_comments` MODIFY `parent_id` INTEGER UNSIGNED NULL;');

        Schema::table('xeor_comments_comments', function($table)
        {
            $table->integer('nest_left')->nullable();
            $table->integer('nest_right')->nullable();
            $table->integer('nest_depth')->nullable();
            $table->string('thread');
        });

        if ($comments = Comment::all()) {
            // Remove old values
            foreach ($comments as $comment) {
                $comment->nest_left = 0;
                $comment->nest_right = 0;
                $comment->nest_depth = 0;
                $comment->save();
            }
            // Set default values
            foreach ($comments as $comment) {
                $comment->setDefaultLeftAndRight();
                $comment->save();
            }
            // Fix tree
            $comments = $comments->sortBy('id');
            foreach ($comments as $comment) {
                if (isset($comment->parent_id) && $comment->parent_id > 0)
                    $comment->makeChildOf($comment->parent_id);
                $comment->save();
            }
        }

    }

    public function down()
    {
    }

}