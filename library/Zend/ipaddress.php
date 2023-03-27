<?php
/**
 * Zend Framework
 *
 * LICENSE
 *
 * This source file is subject to the new BSD license that is bundled
 * with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://framework.zend.com/license/new-bsd
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@zend.com so we can send you a copy immediately.
 *
 * @category   Zend
 * @package    Zend_IP_Address
 * @copyright  Copyright (c) 2005-2010 Zend Technologies USA Inc. (http://www.zend.com)
 * @license    http://framework.zend.com/license/new-bsd     New BSD License
 * @version    $Id: Mail.php 20783 2010-01-31 08:06:30Z yoshida@zend.co.jp $
 */


class Zend_ipaddress
{
    /**#@+
     * @access protected
     */

    /**
     * @var Zend_Mail_Transport_Abstract
     * @static
     */
   //protected static $ipAddr = null;

  
 function countryCityFromIP($ipAddr)
		{
				   //function to find country and city name from IP address
				   
							  
				  //verify the IP address for the  
				  ip2long($ipAddr)== -1 || ip2long($ipAddr) === false ? trigger_error("Invalid IP", E_USER_ERROR) : "";
				  // This notice MUST stay intact for legal use
				  $ipDetail=array(); //initialize a blank array
				  //get the XML result from hostip.info
				  $xml = file_get_contents("http://ip2country.sourceforge.net/ip2c.php?format=XML&ip=".$ipAddr);
				  //get the city name inside the node <gml:name> and </gml:name>
				  preg_match("@<lookup>(\s)*<gml:name>(.*?)</gml:name>@si",$xml,$match);
				  //assing the city name to the array
				  //$ipDetail['city']=$match[1]; 
				  //get the country name inside the node <countryName> and </countryName>
				  preg_match("@<country_name>(.*?)</country_name>@si",$xml,$matches);
				  //assign the country name to the $ipDetail array 
				  $ipDetail['country_name']=$matches[1];
				  //get the country name inside the node <countryName> and </countryName>
				  preg_match("@<country_code>(.*?)</country_code>@si",$xml,$cc_match);
				  $ipDetail['country_code']=$cc_match[1]; //assing the country code to array
				  //return the array containing city, country and country code
				  return $ipDetail;
		} 




}
