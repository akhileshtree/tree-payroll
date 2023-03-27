<?php

class Default_Model_DbTable_Employee extends Zend_Db_Table_Abstract
{
    protected $_name = 'tbl_employee';
	
		public function addemp($emp_id,$cardno,$emp_name,$email, $mobileNo, $dob, $gender, $maritalstatus, $address,$panNumber, $adharnumber, $blood_group, $department,$designation, $salary, $worktype, $joiningdate, $leavingdate, $pname, $pnumber, $prelation, $paddress,$bankname, $bankaddress, $accnumber, $accname, $ifscno, $acctype, $img)
		{
			$mssg = "";
			$data = array(
				'emp_id'		=>		$emp_id,
				'emp_card_no'	=>		$cardno,
				'emp_name'		=>		ucwords($emp_name),
				'emp_email'		=>		$email, 
				'emp_ph_no'		=>		$mobileNo,
				'dob'			=>		$dob,
				'gender'		=>		$gender, 
				'maritalstatus'	=>		$maritalstatus,
				'address'		=>		ucwords($address), 
				'pan_number'	=>		strtoupper($panNumber),
				'adhar_number'	=>		$adharnumber,
				'blood_group'  	=>		$blood_group,
				'department'	=>		$department,
				'designation'	=>		$designation,
				'salary'		=>		$salary,
				'worktype'		=>		$worktype,
				'joiningdate'	=>		$joiningdate,
				'leavingdate'	=>		$leavingdate,
				'p_number'		=>		$pnumber, 
				'p_name'		=>		ucwords($pname), 
				'p_relation'	=>		$prelation, 
				'p_address'		=>		ucwords($paddress),
				'bankname'		=>		ucwords($bankname), 
				'bank_branch'	=>		ucwords($bankaddress), 
				'accnumber'		=>		$accnumber, 
				'accname'		=>		ucwords($accname),
				'ifscno'		=>		strtoupper($ifscno),
				'acctype'		=>		ucwords($acctype),
				'emp_image'		=>		$img
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
	
	
		public function editemp($sno,$cardno,$name,$email, $mobileNo, $dob, $gender, $maritalstatus, $address,  $panNumber, $adharnumber, $blood_group, $department,$designation, $salary, $worktype, $joiningdate, $leavingdate, $pname, $pnumber, $prelation, $paddress,$bankname, $bankaddress, $accnumber, $accname, $ifscno, $acctype)
		{
			$mssg = "";
			$data = array(
				'emp_card_no'	=>		$cardno,
				'emp_name'		=>		ucwords($name),
				'emp_email'		=>		$email, 
				'emp_ph_no'		=>		$mobileNo,
				'dob'			=>		$dob,
				'gender'		=>		$gender, 
				'maritalstatus'	=>		$maritalstatus,
				'address'		=>		ucwords($address),
				'pan_number'	=>		$panNumber,
				'adhar_number'	=>		$adharnumber,
				'blood_group' 	=>		$blood_group, 
				'department'	=>		$department,
				'designation'	=>		$designation,
				'salary'		=>		$salary,
				'worktype'		=>		$worktype,
				'joiningdate'	=>		$joiningdate,
				'leavingdate'	=>		$leavingdate,
				'p_number'		=>		$pnumber, 
				'p_name'		=>		ucwords($pname), 
				'p_relation'	=>		$prelation, 
				'p_address'		=>		ucwords($paddress),
				'bankname'		=>		$bankname, 
				'bank_branch'	=>		$bankaddress, 
				'accnumber'		=>		$accnumber, 
				'accname'		=>		ucwords($accname),
				'ifscno'		=>		$ifscno,
				'acctype'		=>		ucwords($acctype)
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
	
		public function deleteemp($sno){
				$mssg = "";				
				try{
						$where['emp_id = ?'] = $sno;
						$sql = $this->delete($where);
						$mssg = "Employee Record Has Been Deleted !!";
				}
				catch(Zend_Exception $e)
				{
						$mssg = "Deleting Error, May be this Records is Used in another Table.";
				}
				// if ($status == 'active') {
				// 	$data = array('emp_status' => 'left');
				// 	$where['emp_id = ?'] = $sno;
				// 	$sql = $this->update($data, $where);
				// 	$mssg = "Employee Record Has Been Deleted !!";
				// } // if status is Deactive(status=1) then update into Active (status=0).
				// else if ($status == 'left') {
				// 	$data = array('emp_status' => 'active');
				// 	$where['emp_id = ?'] = $sno;
				// 	$sql = $this->update($data, $where);
				// 	$mssg = "Employee Record Has Been Changed !!";
				// }

				return $mssg;
		}

		
}

