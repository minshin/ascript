<?php namespace Xeor\Comments\Models;

use DB;
use Auth;
use Model;
use Markdown;
use Debugbar;

class Comment extends Model
{
    use \October\Rain\Database\Traits\NestedTree;

    public $table = 'xeor_comments_comments';

    /**
     * Relations
     */
    public $hasMany = [
        'votes' => [
            'Xeor\Comments\Models\Vote',
        ],
    ];

    public function beforeSave()
    {
        $this->content_html = self::formatHtml($this->content);

        // This next section builds the thread field
        if (!empty($this->thread)) {
            // Allow calling code to set thread itself.
            $thread = $this->thread;
        }
        else if ($this->parent_id == 0) {
            // This is a comment with no parent comment (depth 0): we start
            // by retrieving the maximum thread level.
            $max = DB::table('xeor_comments_comments')->where('uri', $this->uri)->max('thread');
            // Strip the "/" from the end of the thread.
            $max = rtrim($max, '/');
            // We need to get the value at the correct depth.
            $parts = explode('.', $max);
            $firstsegment = $parts[0];
            // Finally, build the thread field for this new comment.
            $thread = $this->int2vancode($this->vancode2int($firstsegment) + 1) . '/'; //TODO
        } else {
            // This is a comment with a parent comment, so increase the part of the
            // thread value at the proper depth.

            // Get the parent comment:
            $parent = self::find($this->parent_id);
            // Strip the "/" from the end of the parent thread.
            $parent->thread = (string)rtrim((string)$parent->thread, '/');
            // Get the max value in *this* thread.
            $max = DB::table('xeor_comments_comments')->where('thread', $parent->thread)->where('uri', $this->uri)->max('thread');

            if ($max == '') {
                // First child of this parent.
                $thread = $parent->thread . '.' . $this->int2vancode(0) . '/';
            } else {
                // Strip the "/" at the end of the thread.
                $max = rtrim($max, '/');
                // Get the value at the correct depth.
                $parts = explode('.', $max);
                $parent_depth = count(explode('.', $parent->thread));
                $last = $parts[$parent_depth];
                // Finally, build the thread field for this new comment.
                $thread = $parent->thread . '.' . $this->int2vancode($this->vancode2int($last) + 1) . '/';
            }
        }
        $this->thread = $thread;
    }

    public static function formatHtml($input, $preview = false)
    {
        $result = Markdown::parse(strip_tags(trim($input)));
        return $result;
    }

    /**
     * Generate vancode.
     *
     * Consists of a leading character indicating length, followed by N digits
     * with a numerical value in base 36. Vancodes can be sorted as strings
     * without messing up numerical order.
     *
     * It goes:
     * 00, 01, 02, ..., 0y, 0z,
     * 110, 111, ... , 1zy, 1zz,
     * 2100, 2101, ..., 2zzy, 2zzz,
     * 31000, 31001, ...
     */
    protected function int2vancode($i = 0)
    {
        $num = base_convert((int)$i, 10, 36);
        $length = strlen($num);

        return chr($length + ord('0') - 1) . $num;
    }

    /**
     * Decode vancode back to an integer.
     */
    protected function vancode2int($c = '00')
    {
        return base_convert(substr($c, 1), 36, 10);
    }

    /**
     * Used to test if a certain user has permission to edit post,
     * returns TRUE if the user is the owner or has other posts access.
     * @param User $user
     * @return bool
     */
    public function canEdit($userId)
    {
        return ($userId > 0) && ($this->user_id == $userId);
    }

    public function getStatistics($type = 'point') {

        $results = [
            'total' => 0,
            'data' => [],
        ];

        $data = Db::table('xeor_comments_votes')->where('comment_id', $this->id)->where('value_type', $type)->lists('value');
        if ($data) {
            asort($data, SORT_NUMERIC);
            $results['total'] = count($data);
            $results['data']  = array_count_values($data);
        }

        return $results;
    }

    public function getTotalVotes()
    {
        return Db::table('xeor_comments_votes')->where('comment_id', $this->id)->count();
    }

    public function getScore($rateType)
    {
        $score = 0;
        $totalArr = array();
        $valueType = $rateType == 'stars' ? 'percent' : 'point';
        $data = Db::table('xeor_comments_votes')->where('comment_id', $this->id)->where('value_type', $valueType)->lists('value');
        if (isset($data) && !empty($data)) {
            foreach ($data as $value) {
                $totalArr[] = (int) $value;
            }
        }
        if (!empty($totalArr)) {
            switch ($rateType) {
                case 'stars':
                    $score = round(array_sum($totalArr) / count($totalArr));
                    break;
                case 'number':
                    $score = array_sum($totalArr);
                    break;
                default:
                    $score = 0;
            }
        }
        return $score;
    }

    //
    // Scopes
    //

    /**
     * Allows filtering for specifc categories
     * @param  Illuminate\Query\Builder  $query      QueryBuilder
     * @param  array                     $types      List of types ids
     * @return Illuminate\Query\Builder              QueryBuilder
     */
    public function scopeFilterTypes($query, $types)
    {
        return $query->whereIn('type', $types);
    }

    public function scopeIsPublished($query)
    {
        return $query
            ->whereNotNull('published')
            ->where('published', '=', 1);
    }

    /**
     * Lists comments for the front end
     * @param  array $options Display options
     * @return self
     */
    public function scopeListFrontEnd($query, $options)
    {
        /*
         * Default options
         */
        extract(array_merge([
            'page'       => 1,
            'perPage'    => 30,
            'published'  => true
        ], $options));

        if ($published) {
            $query->isPublished();
        }

        /*
         * Sorting
         */
        list($sortField, $sortDirection) = [$sort, 'asc'];
        if ($sortField == 'torder') {
            $sortField = DB::raw('SUBSTRING(thread, 1, (LENGTH(thread) - 1))');
        }
        $query->orderBy($sortField, $sortDirection);

        $query->orderBy('id', 'asc'); //TODO
        return $query->paginate($perPage, $page);
    }
}