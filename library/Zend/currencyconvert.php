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


class Zend_currencyconvert
{

	function convert_number($number) 
	{	 
			if (($number < 0) || ($number > 999999999)) 
			{ 
			throw new Exception("Number is out of range");
			} 

			$Gn = floor($number / 1000000);  /* Millions (giga) */ 
			$number -= $Gn * 1000000; 
			$kn = floor($number / 1000);     /* Thousands (kilo) */ 
			$number -= $kn * 1000; 
			$Hn = floor($number / 100);      /* Hundreds (hecto) */ 
			$number -= $Hn * 100; 
			$Dn = floor($number / 10);       /* Tens (deca) */ 
			$n = $number % 10;               /* Ones */ 

			$res = ""; 

			if ($Gn) 
			{ 
				$res .= $this->convert_number($Gn) . " Million"; 
			} 

			if ($kn) 
			{ 
				$res .= (empty($res) ? "" : " ") . 
					$this->convert_number($kn) . " Thousand"; 
			} 

			if ($Hn) 
			{ 
				$res .= (empty($res) ? "" : " ") . 
					$this->convert_number($Hn) . " Hundred"; 
			} 

			$ones = array("", "One", "Two", "Three", "Four", "Five", "Six", 
				"Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", 
				"Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eightteen", 
				"Nineteen"); 
			$tens = array("", "", "Twenty", "Thirty", "Fourty", "Fifty", "Sixty", 
				"Seventy", "Eigthy", "Ninety"); 

			if ($Dn || $n) 
			{ 
				if (!empty($res)) 
				{ 
					$res .= " and "; 
				} 

				if ($Dn < 2) 
				{ 
					$res .= $ones[$Dn * 10 + $n]; 
				} 
				else 
				{ 
					$res .= $tens[$Dn]; 

					if ($n) 
					{ 
						$res .= " " . $ones[$n]; 
					} 
				} 
			} 

			if (empty($res)) 
			{ 
				$res = "zero"; 
			} 

			return $res; 
	} //end function



}