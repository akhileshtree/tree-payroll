<?php

// Define path to application directory
defined('APPLICATION_PATH')
    || define('APPLICATION_PATH', realpath(dirname(__FILE__) . '/../application'));

// Define application environment
defined('APPLICATION_ENV')
    || define('APPLICATION_ENV', (getenv('APPLICATION_ENV') ? getenv('APPLICATION_ENV') : 'production'));

// Ensure library/ is on include_path
set_include_path(implode(PATH_SEPARATOR, array(
    realpath(APPLICATION_PATH . '/../library'),
    get_include_path(),
)));

/** Zend_Application */
require_once 'Zend/Application.php';

// Create application, bootstrap, and run
$application = new Zend_Application(
    APPLICATION_ENV,
    APPLICATION_PATH . '/configs/application.ini'
);

//$db = Zend_Registry::get('dbadapter');

//$config = Zend_Registry::get('config');
//echo $dbUsername = $db->database->params->username;
//$dbPassword = $db->database->params->password;
//$dbName = $db->database->params->dbname;


$options = $application->getOptions();
 $db = Zend_Db::factory($options['resources']['db']['adapter'], array(
	    'host' => $options['resources']['db']['params']['host'],
        'username' => $options['resources']['db']['params']['username'],
        'password' => $options['resources']['db']['params']['password'],
        'dbname' => $options['resources']['db']['params']['dbname']
   ));

$host=$options['resources']['db']['params']['host'];
$uname=$options['resources']['db']['params']['username'];
$pass=$options['resources']['db']['params']['password'];
$database = $options['resources']['db']['params']['dbname'];

$connection=mysqli_connect($host,$uname,$pass) or die("Database Connection Failed");
$selectdb=mysqli_select_db($connection,$database) or die("Database could not be selected"); 
$result=mysqli_select_db($connection,$database) or die("database cannot be selected <br>");
?>