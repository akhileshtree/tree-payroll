<?php

class Default_Model_DbTable_Department extends Zend_Db_Table_Abstract
{
    protected $_name = 'tbl_department';

		public function editBatch($sno,$departmentname, $note)
		{
			$mssg = "";
			$data = array(
				'department_name'=>"$departmentname",
				'note'=>"$note"
			);

			try{
				$this->update($data, 'depatment_id = '. (int) $sno);
				$mssg = "Records has been Updated Successfully !!";
				}
				catch(Zend_Exception $e)
				{
					$mssg = $e."Error Occurred!! Record Not Updated Properly!! Pls Try Again";
				}
			return $mssg;
			
		} //end editPayment
	
		public function adduser($departmentname,$departmentnote)
		{
			$mssg = "";
			$data = array(
				'department_name'=>"$departmentname",
				'note'=>"$departmentnote"
			);
			
			try{
				$this->insert($data);		
				$mssg ="Records has been Inserted Successfully !!";
				}
				catch(Zend_Exception $e)
				{
					$mssg = "Error Occured!! Record Not Inserted Properly!! Pls Try Again";
				}
			return $mssg;
			
		}
	
	
		public function deletedepartment($sno){
				$mssg = "";
				
				try{
						$where['depatment_id = ?'] = $sno;
						$sql = $this->delete($where);
						$mssg = "Done";
				}
				catch(Zend_Exception $e)
				{
						$mssg = $e."Deleting Error, May be this Records is Used in another Table.";
				}
				return $mssg;
		}
		public function editstatusAdmin($sts, $sno)
		{
			$mssg = "";
			if ($sts == '0') {
				$data = array('status' => 1);
				$where['depatment_id = ?'] = $sno;
				$sql = $this->update($data, $where);
				$Mssg = "red,1";
			} // if status is Deactive(status=1) then update into Active (status=0).
			else if ($sts == '1') {
				$data = array('status' => 0);
				$where['depatment_id = ?'] = $sno;
				$sql = $this->update($data, $where);
				$Mssg = "green,0";
			}
			return $Mssg;
		}
		
}

