<?php

class Default_Model_DbTable_Dashbord extends Zend_Db_Table_Abstract
{
    protected $_name = 'tbl_register';

    public function manageProfile($id, $Name, $Password, $userName, $Address, $mobile, $emailID)
    {        
        $mssg = "";
       
            $data = array(
                'UserName' => "$userName",
                'Address'  => "$Address",
                'Name'     => "$Name",
                'mobileNo' => "$mobile",
                'emailID'  => "$emailID",
                // 'website'  => "$website",
            );
        try {
            $this->update($data, 'Sno = ' . (int)$id);
            // $x = implode(',',$data);
            $mssg ="Records has been Updated Successfully !!";
        } catch (Zend_Exception $e) {
            $mssg = $e . " - Error Occurred!! Record Not Updated Properly!! Pls Try Again";
        }
        return $mssg;
    }

    public function updatePhoto($id, $photo)
    {
        $data = array(

            'photo' => "$photo",
        );
        try {
            $this->update($data, "Sno = '" . $id . "'");
            $mssg = "Records has been Updated Successfully !!";
        } catch (Zend_Exception $e) {
            $mssg = "Error Occurred!! Record Not Updated Properly!! Pls Try Again";
        }
        return $mssg;
    }
   

}

