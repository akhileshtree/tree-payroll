<?php

class Zend_Plugin_SessionTrack extends Zend_Controller_Plugin_Abstract {
 
    public function preDispatch(Zend_Controller_Request_Abstract $request)
    {  
 
        $ZSN = new Zend_Session_Namespace('ZSN');
        $ZSN->setExpirationSeconds(60*20); 
    }
}
