<?php
namespace App;

use App\Controllers as Controllers;
use Igorw\Silex\ConfigServiceProvider;
use Silex\Application as Application;

class Bootstrap extends Application
{
    public function __construct()
    {
        parent::__construct();

        $this->registerParameters();
        $this->registerServices();
        $this->registerRoutes();
    }

    protected function registerParameters()
    {
        $paths = isset($this['base_path']) ? $this['base_path'] : array();

        if (!isset($paths['base'])) {
            $paths['base'] = realpath(__DIR__ . '/../');
        }

        $this->register( new ConfigServiceProvider($paths['base'] . "/app/Config/Config.yml", array('base_path' => $paths['base'])) );

        foreach ($this['default_paths'] as $key => $value) {
            if (!isset($paths[$key])) {
                $paths[$key] = $value;
            }
        }

        $this['paths'] = $paths;
    }

    protected function registerServices()
    {
        $this->register( new ConfigServiceProvider($this['paths']['config.path'] . "/Services.yml", array('twig.path' => $this['paths']['twig.default.path'])));

        foreach($this['services'] as $serviceName => $serviceData)
        {
            $this->register( new $serviceData['class'],(array_key_exists('parameters',$serviceData)) ? $serviceData['parameters'] : array() );
        }
    }

    protected function registerRoutes()
    {
        $this->register( new ConfigServiceProvider($this['paths']['config.path'] . "/Routes.yml") );

        $routes = $this['config.routes'];
        foreach ($routes as $name => $route)
        {
            $this->match($route['pattern'], $route['defaults']['_controller'])->bind($name)->method(isset($route['method'])?$route['method']:'GET');
        }
    }

}