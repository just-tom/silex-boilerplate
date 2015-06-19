<?php
namespace App\Controllers\Base;

class IndexController
{
    public function indexAction(\Silex\Application $app){
        return $app['twig']->render('index.twig');
    }
}