<?php

return [
    'app' => [
        'name' => 'Matrix Table',
        'desc' => 'You can create matrix tables with any dimensions easily!',
        'menu_label' => 'Matrix Table'
    ],

    'generic' => [
        'return' => 'Return to list'
    ],

    /************************************************
     ************ COMPONENT TRANSLATIONS ************
     ************************************************/

    'components' => [
        'table' => [
            'name' => 'Matrix Table',
            'desc' => 'Add this component to any page/layout for showing related matrix table on the page',

            'table_name' => 'Matrix table',
            'table_desc' => 'Select matrix table to show on the page'
        ]
    ],

    /************************************************
     ************ PAGES AND TRANSLATIONS ************
     ************************************************/

    'tables' => [
        'page_title' => 'Matrix Tables',
        'page_title_one' => 'Matrix Table',

        'name' => 'Scheme Name',
        'created_at' => 'Created',
        'columns_title' => 'Head title for columns (leave blank for hide)',
        'rows_title' => 'Head title for rows',
        'column_names' => 'Columns',
        'column_name' => 'Column name',
        'row_names' => 'Rows',
        'row_name' => 'Row name',
        'prefix' => 'Prefix for each row',
        'suffix' => 'Suffix for each row',

        'new' => 'New Matrix Table',
        'edit' => 'Edit Matrix Table',
        'empty' => 'Purge all matrix tables',
        'emptysure' => 'Are you sure to delete all matrix tables?',
        'emptying' => 'Deleting..',
        'empty_ok' => 'Empty success.'
    ],

    'datas' => [
        'page_title' => 'Table Datas',
        'page_title_one' => 'Table Data',

        'edit' => 'Edit Datas for Table',
        'success' => 'Updated successfully',

        'warning_title' => 'Missing Info',
        'warning_message' => 'Column or Row headers are missing. Please check from "Matrix Tables" section first.',

        'savesure' => 'If you change column and row data, you need to re-check Table Datas for inconsistencies for new scheme. Sure to update?'
    ]
];
