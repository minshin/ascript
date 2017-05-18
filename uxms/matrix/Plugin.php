<?php namespace Uxms\Matrix;

use Backend;
use System\Classes\PluginBase;


class Plugin extends PluginBase
{
    public function pluginDetails()
    {
        return [
            'name'        => 'uxms.matrix::lang.app.name',
            'description' => 'uxms.matrix::lang.app.desc',
            'author'      => 'uXMs Devs',
            'icon'        => 'icon-table',
            'homepage'    => 'https://uxms.net'
        ];
    }

    public function registerPermissions()
    {
        return [
            'uxms.matrix.tables' => [
                'tab' => trans('uxms.matrix::lang.app.name'),
                'label' => 'Access & Edit Matrix Tables'
            ],
            'uxms.matrix.datas' => [
                'tab' => trans('uxms.matrix::lang.app.name'),
                'label' => 'Access & Edit Table Datas'
            ]
        ];
    }

    public function registerComponents()
    {
        return ['Uxms\Matrix\Components\MatrixTable' => 'matrixTable'];
    }

    public function registerNavigation()
    {
        return [
            'matrix' => [
                'label'       => 'uxms.matrix::lang.app.menu_label',
                'url'         => Backend::url('uxms/matrix/tables'),
                'icon'        => 'icon-table',
                'iconSvg'     => 'plugins/uxms/matrix/assets/img/icon.svg',
                'permissions' => ['uxms.matrix.*'],
                'order'       => 998,

                'sideMenu' => [
                    'tables' => [
                        'label'       => 'uxms.matrix::lang.tables.page_title',
                        'icon'        => 'icon-table',
                        'url'         => Backend::url('uxms/matrix/tables'),
                        'permissions' => ['uxms.matrix.tables']
                    ],
                    'datas' => [
                        'label'       => 'uxms.matrix::lang.datas.page_title',
                        'icon'        => 'icon-database',
                        'url'         => Backend::url('uxms/matrix/datas'),
                        'permissions' => ['uxms.matrix.datas']
                    ]
                ]
            ]
        ];
    }

    /**
     * The register() method is called immediately when the plugin is registered.
     */
    public function register()
    {
    }

    /**
     * The boot() method is called right before a request is routed
     */
    public function boot()
    {
    }
}
