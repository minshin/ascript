<?php namespace Xeor\Comments\Console;

use Exception;
use Illuminate\Console\Command;
use Xeor\Comments\Models\Comment;

class CommentsFixTree extends Command
{
    /**
     * The console command name.
     * @var string
     */
    protected $name = 'comments:fixtree';

    /**
     * The console command description.
     * @var string
     */
    protected $description = 'Fixes the tree based on parentage info.';

    /**
     * Create a new command instance.
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     * @return void
     */
    public function fire()
    {
        try {
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
            $this->info(sprintf('Done!'));
        }
        catch (Exception $ex) {
            $this->error($ex->getMessage());
        }
    }

    /**
     * Get the console command arguments.
     * @return array
     */
    protected function getArguments()
    {
        return [];
    }

    /**
     * Get the console command options.
     * @return array
     */
    protected function getOptions()
    {
        return [];
    }
}
