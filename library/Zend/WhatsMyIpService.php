<?php

//require_once 'Zend/Service/Abstract.php';

class WhatsMyIpService extends Zend_Service_Abstract
{
	/**
	 * The service endpoint.
	 * This is where Zend_Http_Client will navigate
	 * to fill service requests
	 * @var string
	 */
	protected $_endpoint = 'http://whatismyip.com';
 
	/**
	 * handle to the client
	 * @var Zend_Http_Client
	 */
	protected $_client;
 
	public function __construct()
	{
		$this->_client = self::getHttpClient();
	}
 
	/**
	 * Method to get the external IP of the computer / server
	 * script is running on
	 * @return string
	 */
	public function getMyIp()
	{
		//reset the client parameters, set the URL to whatismyip.com
		//and actually preform the request
		$result = $this->_client
			->resetParameters()
			->setUri($this->_endpoint)
			->request(Zend_Http_Client::GET);
 
		//check to make sure that the result isnt a HTTP error
		if($result->isError()){
			throw new Exception('Client returned error: ' . $result->getMessage());
		}
 
		try{
			//setup the query object with the result body (HTML page)
			$query = new Zend_Dom_Query($result->getBody());
 
			$domCollection = $query->query('h1');
		}catch(Zend_Dom_Exception $e){
			throw new Exception('Error Loading Document: ' . $e);
		}
 
		//check to make sure the query return a result
		if($domCollection->count() == 0){
			throw new Exception('Cannot find DOM Element');
		}
 
		//get the titlestring from the nodevalue
		$titleString = (string) $domCollection->current()->nodeValue;
 
		//now we should have the content of h1 stored in the titleString
		//it should read something like "Your IP Address Is: xxx.xxx.xxx.xxx"
 
		//Now we will parse out the IP address using regular expressions
		if (preg_match('/([\d]{1,3}\.[\d]{1,3}\.[\d]{1,3}\.[\d]{1,3})/', $titleString, $matches)) {
			return $matches[1];
		}else{
			throw new Exception('Unable to parse IP from page');
		}
	}
}