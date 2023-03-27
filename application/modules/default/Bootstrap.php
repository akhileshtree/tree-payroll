<?php
class Default_Bootstrap extends Zend_Application_Module_Bootstrap
{
	protected function _initRoutes()
    {

        $router = Zend_Controller_Front::getInstance()->getRouter();
        $loginRoute = new Zend_Controller_Router_Route('login', array('module' => 'default', 'controller' => 'Index', 'action' => 'login'));
        $logoutRoute = new Zend_Controller_Router_Route('logout', array('module' => 'default', 'controller' => 'Index', 'action' => 'logout'));
        $routesArray = array('login' => $loginRoute, 'logout' => $logoutRoute);
        $router->addRoutes($routesArray);

    }

    protected function _initPlugins()
    {

        $frontController = Zend_Controller_Front::getInstance();
        $frontController->registerPlugin(new Zend_Plugin_SessionTrack());

    }

}