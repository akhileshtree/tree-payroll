<?php
error_reporting(0);
//ALTER TABLE `tbl_payment_detail` ADD `recepitDate` DATETIME NOT NULL AFTER `amount`, ADD `paymentMode` VARCHAR(250) NOT NULL AFTER `recepitDate`, ADD `discription` VARCHAR(250) NOT NULL AFTER `paymentMode`;
//ALTER TABLE `tbl_district` ADD `dis_code` VARCHAR(20) NOT NULL AFTER `district`, ADD `dis_address` VARCHAR(300) NOT NULL AFTER `dis_code`;
// Define path to application directory
defined('APPLICATION_PATH')
    || define('APPLICATION_PATH', realpath(dirname(__FILE__) . '/application'));

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


$options = $application->getOptions();
 $db = Zend_Db::factory($options['resources']['db']['adapter'], array(
	    'host' => $options['resources']['db']['params']['host'],
        'username' => $options['resources']['db']['params']['username'],
        'password' => $options['resources']['db']['params']['password'],
        'dbname' => $options['resources']['db']['params']['dbname']
   ));

//$db=Zend_Db_Table::getDefaultAdapter();


 $db->beginTransaction();
 $sql = file_get_contents(APPLICATION_PATH . '/data/data.sql');
 $db->query($sql);
 $db->commit();
$application->bootstrap()
            ->run();