<?php

class Default_Model_DbTable_Deletedemp extends Zend_Db_Table_Abstract
{
    protected $_name = 'tbl_temp_employe';
	
		public function addemp($emp_id,$emp_card_no,$emp_name,$emp_email, $emp_ph_no, $dob, $gender, $maritalstatus, $address, $pan_number, $adhar_number, $department,$designation, $salary, $worktype, $joiningdate, $leavingdate, $p_name, $p_number,  $p_relation, $p_address,$bankname, $bank_branch, $accnumber, $accname, $ifscno, $acctype, $emp_image)
		{
			$mssg = "";
			$data = array(
				'emp_id'		=>		$emp_id,
				'emp_card_no'	=>		$emp_card_no,
				'emp_name'		=>		$emp_name,
				'emp_email'		=>		$emp_email, 
				'emp_ph_no'		=>		$emp_ph_no,
				'dob'			=>		$dob,
				'gender'		=>		$gender, 
				'maritalstatus'	=>		$maritalstatus,
				'address'		=>		$address, 
				'pan_number'	=>		$pan_number,
				'adhar_number'	=>		$adhar_number,
				'department'	=>		$department,
				'designation'	=>		$designation,
				'salary'		=>		$salary,
				'worktype'		=>		$worktype,
				'joiningdate'	=>		$joiningdate,
				'leavingdate'	=>		$leavingdate,
				'p_name'		=>		$p_name,
				'p_number'		=>		$p_number, 				 
				'p_relation'	=>		$p_relation, 
				'p_address'		=>		$p_address,
				'bankname'		=>		$bankname, 
				'bank_branch'	=>		$bank_branch, 
				'accnumber'		=>		$accnumber, 
				'accname'		=>		$accname,
				'ifscno'		=>		$ifscno,
				'acctype'		=>		$acctype,
				'emp_image'		=>		$emp_image
			);
			
			try{
				$this->insert($data);		
				$mssg ="Records has been Inserted Successfully !!";
				}
				catch(Zend_Exception $e)
				{
					// $mssg = $data;
					$mssg = "Error Occured!! Record Not Inserted Properly!! Pls Try Again";
				}
			return $mssg;
			
		}
	
	
		public function editemp($sno,$cardno,$name,$email, $mobileNo, $dob, $gender, $maritalstatus, $address,  $panNumber, $adharnumber, $department,$designation, $salary, $worktype, $joiningdate, $leavingdate, $pname, $pnumber, $prelation, $paddress,$bankname, $bankaddress, $accnumber, $accname, $ifscno, $acctype)
		{
			$mssg = "";
			$data = array(
				'emp_card_no'	=>		$cardno,
				'emp_name'		=>		$name,
				'emp_email'		=>		$email, 
				'emp_ph_no'		=>		$mobileNo,
				'dob'			=>		$dob,
				'gender'		=>		$gender, 
				'maritalstatus'	=>		$maritalstatus,
				'address'		=>		$address,
				'pan_number'	=>		$panNumber,
				'adhar_number'	=>		$adharnumber, 
				'department'	=>		$department,
				'designation'	=>		$designation,
				'salary'		=>		$salary,
				'worktype'		=>		$worktype,
				'joiningdate'	=>		$joiningdate,
				'leavingdate'	=>		$leavingdate,
				'p_number'		=>		$pnumber, 
				'p_name'		=>		$pname, 
				'p_relation'	=>		$prelation, 
				'p_address'		=>		$paddress,
				'bankname'		=>		$bankname, 
				'bankaddress'	=>		$bankaddress, 
				'accnumber'		=>		$accnumber, 
				'accname'		=>		$accname,
				'ifscno'		=>		$ifscno,
				'acctype'		=>		$acctype
			);
			
			try{
				$this->update($data, 'id = '.$sno);
				$mssg = "Records has been Updated Successfully !!";
				}
				catch(Zend_Exception $e)
				{
					$mssg = "Error Occured!! Record Not Inserted Properly!! Pls Try Again";
				}
			return $mssg;
			
		}
	
		public function deleteemp($sno, $status){
				$mssg = "";				
				// try{
				// 		$where['emp_id = ?'] = $sno;
				// 		$sql = $this->delete($where);
				// 		$mssg = "Employee Record Has Been Deleted !!";
				// }
				// catch(Zend_Exception $e)
				// {
				// 		$mssg = "Deleting Error, May be this Records is Used in another Table.";
				// }
				if ($status == 'active') {
					$data = array('emp_status' => 'left');
					$where['emp_id = ?'] = $sno;
					$sql = $this->update($data, $where);
					$mssg = "Employee Record Has Been Deleted !!";
				} // if status is Deactive(status=1) then update into Active (status=0).
				else if ($status == 'left') {
					$data = array('emp_status' => 'active');
					$where['emp_id = ?'] = $sno;
					$sql = $this->update($data, $where);
					$mssg = "Employee Record Has Been Changed !!";
				}

				return $mssg;
		}

		
}

