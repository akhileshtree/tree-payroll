<?php

class Default_Model_DbTable_Adduser extends Zend_Db_Table_Abstract
{
    protected $_name = 'tbl_register';

		public function adduser($UserName,$user,$pwd, $Address, $mobileNo, $email, $img, $Role)
		{
			$mssg = "";
			$data = array(
				'UserName'=>"$UserName",
				'Name'=>"$user",
				'Password'=>md5("$pwd"),
				'Address'=>"$Address",
				'mobileNo'=>"$mobileNo",
				'emailId'=>"$email",
				'photo'=>"$img",
				'Role'=>"$Role",
			);
			
			try{
				$this->insert($data);		
				$mssg ="Records has been Inserted Successfully !!";
				}
				catch(Zend_Exception $e)
				{
					$mssg = $e ."Error Occured!! Record Not Inserted Properly!! Pls Try Again";
				}
			return $mssg;
			
		}
	
	
		public function edituser($sno,$pwd)
		{
			$mssg = "";
			$data = array(
				'Password'=>md5("$pwd"),
			);
			
			try{
				$where['Name =?'] = $sno ;
				$this->update($data, $where);
				$mssg = "Records has been Updated Successfully !!";
				}
				catch(Zend_Exception $e)
				{
					$mssg = $e ."Error Occurred!! Record Not Updated Properly!! Pls Try Again";
				}
			return $mssg;
			
		}
	
		public function deleteemp($sno){
			$mssg = "";				
			try{
				$data = array('status' => 1);
				$where['Name = ?'] = $sno;
				$sql = $this->update($data, $where);
				$mssg = "status changed !!";
			}
			catch(Zend_Exception $e)
			{
					$mssg = " Error";
			}
			
				// $data = array('status' => 1);
				// $where['Name = ?'] = $sno;
				// $sql = $this->update($data, $where);
				// $mssg = "status changed !!";
			
			return $mssg;
	}
		
}

