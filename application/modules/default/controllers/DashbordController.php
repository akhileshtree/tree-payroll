<?php
error_reporting(0);
class Default_DashbordController extends Zend_Controller_Action
{
    public function init()
    {
        // $this->view->assign('pageheader','Genrate Bill ');
			// $this->view->headTitle()->append('Bill - ');
			$this->view->headMeta()->appendHttpEquiv('Content-Type','text/html; charset=utf-8');
			 $this->_helper->layout()->setLayout('adminlayout');
			$Session = new Zend_Session_Namespace("ZSN");
			$this->view->menuActive = 'Bill';
            
			if(!isset($Session->LoginName) && !isset($Session->LoginPassword))
			{
				$Session->ErrorMessage = "No activity within 20 Minute; please log in again!!";	
				$route = array('module'=>'default');						
				$this->_helper->redirector->gotoRoute($route,null,true);
			}
            	
            $db = Zend_Db_Table::getDefaultAdapter();
            $sql_user = $db->select()->from('tbl_register', array('companyName','photo', 'Name','sesion_id', 'Role'))->where('Sno=?', (int)$Session->cID);
            $this->view->login_user = $db->fetchRow($sql_user);
            $sid =  $db->fetchRow($sql_user);
          

            if ($Session->sess_id != $sid['sesion_id'] ) {

                $updt=$db->query("call proupdatesessionmanagement(now(),'$Session->RandNo')");
                $db->closeConnection();
    
                $Session->ErrorMessage = "You have sucessfully Logout!!";
                unset($Session->UName);
                unset($Session->LoginName);
                unset($Session->LoginPassword);            
                unset($Session->IpAddress);
                unset($Session->LoginId);
                unset($Session->LoginType);
                unset($Session->LoginCountry);
				unset($Session->role);
                unset($Session->RandNo);

                $route = array('module'=>'default');
                $this->_helper->redirector->gotoRoute($route,null,true);
            }   	        
    }  

    public function indexAction()
    {
        $db = Zend_Db_Table::getDefaultAdapter();
        $Session = new Zend_Session_Namespace("ZSN");
        $id = (int)$Session->cID; 
        $checkquery = $db->select()->from("tbl_employee", array("num"=>"COUNT(*)"));
        $checkrequest = $db->fetchRow($checkquery);
        $this->view->user = $checkrequest["num"];		
    } //END index

    public function notificationAction()
	{ 
		$db=Zend_Db_Table::getDefaultAdapter();
		$Session = new Zend_Session_Namespace("ZSN");
	}

    public function profileAction()
    {
        $db = Zend_Db_Table::getDefaultAdapter();
        $Session = new Zend_Session_Namespace("ZSN");
        $this->view->assign('pageheader', 'Profile Update');
        $id = (int)$Session->cID;
        $role = $Session->role;
        $sql = $db->select()->from('tbl_register')->where('Sno=?', $id);
        $this->view->user = $db->fetchRow($sql);
       
    }//end profileAction

    public function profilesaveAction()
    {
        $Session = new Zend_Session_Namespace('ZSN');
        $db = Zend_Db_Table::getDefaultAdapter();
        $id = (int)$Session->cID;
        $userName = strip_tags($this->getRequest()->getParam('UserName'));
        $Name = strip_tags($this->getRequest()->getParam('Name'));
        $Password = $this->getRequest()->getParam('Password');
        $Address = strip_tags($this->getRequest()->getParam('Address'));
        $mobile = strip_tags($this->getRequest()->getParam('mobileNo'));
        $emailID = strip_tags($this->getRequest()->getParam('emailId'));
        $mProfile = new Default_Model_DbTable_Dashbord();
        $res = $mProfile->manageProfile($id, $Name, $Password, $userName, $Address, $mobile, $emailID);
        die(json_encode(array('mobileNo' =>$mobile , 'result' => $res)));
        die;
    }

    public function profileimgAction()
    {
        $db = Zend_Db_Table::getDefaultAdapter();
        $Session = new Zend_Session_Namespace("ZSN");
        $id = (int)$Session->cID;

        $efiles = $this->getRequest()->getParam('employee_img');
        $unlinkFiles = $this->getRequest()->getParam('u');
        $photo = date('Ymdhis');

        //delete old file
        if (file_exists(APPLICATION_PATH . '/../images/cImage/' . $unlinkFiles)) {
            unlink(APPLICATION_PATH . '/../images/cImage/' . $unlinkFiles);
        }

        //die(APPLICATION_PATH.'../application/images/cImage/');

        if ($_FILES["employee_img"]['size'] > 0 && $_FILES["employee_img"]['size'] <= 1048576 * 2) {

            //$res = $db->fetchAll($sql);

            /******************uploading profile image ***************************/

            $adapter = new Zend_File_Transfer_Adapter_Http();
            $image_path = APPLICATION_PATH . '/../images/cImage/';

            if (!file_exists($image_path)) mkdir($image_path);

            $adapter->setDestination($image_path . $efiles);
            $adapter->addValidator('Extension', false, 'jpg,png,jpeg');

            $files = $adapter->getFileInfo();

            foreach ($files as $file => $info) {
                $name = $adapter->getFileName($file);
                //find the file extension
                $ext = pathinfo($name, PATHINFO_EXTENSION);
                // Set a new destination path and overwrites existing files
                $adapter->addFilter("Rename", array('target' => $image_path . $photo . '.' . $ext, 'overwrite' => true));
                //resize uploaded image
                $adapter->addFilter(new Skoch_Filter_File_Resize(array('width' => 149, 'height' => 139, 'keepRatio' => false)));
                // file uploaded & is valid
                if (!$adapter->isUploaded($file)) continue;
                if (!$adapter->isValid($file)) continue;
                // receive the files into the user directory
                $adapter->receive($file); // this has to be on top
                //insert image into database
                $iPhoto = new Default_Model_DbTable_Dashbord();
                $iPhoto->updatePhoto($id, $photo . '.' . $ext);
                //end image into database
            }
            /******************end uploading profile image ***************************/
        } else {
            die('Uploaded Image too large! Please upload image less than of 2MB of size!!');
        }
        die($photo . '.' . $ext);
       
    }//end ajaxuploadimageAction

            // --------------bank details ----------
            public function editbankAction(){		
                $Session = new Zend_Session_Namespace('ZSN');
                $db = Zend_Db_Table::getDefaultAdapter();
                        
                $sno        = (int) $this->getRequest()->getParam('sno');
                $bank       = $this->getRequest()->getParam('bankName');
                $name       = $this->getRequest()->getParam('accName');
                $accno      = $this->getRequest()->getParam('accNo');
                $ifscNo     = $this->getRequest()->getParam('ifscNo');
                $branch     = $this->getRequest()->getParam('bankBranch');
                $address    = $this->getRequest()->getParam('bankAddress');
                $gst_no      = $this->getRequest()->getParam('gstNo');
				if($gst_no == ""){
					$gstno = "0" ;
				}else{
					$gstno = $gst_no ; 
				}
                // $cID        = $Session->cID;
                    
                //validation
                if($bank == '' || $accno == ''){
                    die(json_encode(array('error' => false,  'm'=>'All fields are required!')));
                }
                if($sno == 0 && isset($sno)){
                    //call model
                    $addAdmin = new Default_Model_DbTable_Companyaccount(); 
                    $result = $addAdmin->addAdmin($bank,$name,$accno,$ifscNo,$branch,$address,$gstno);
                    $lastInsertId = $db->lastInsertId();			
                    die(json_encode(array( 'cID' => $lastInsertId, 't' => $result, 'm' => 'Records has been successfully added!')));
                }else{
                    //call model
                    $editAdmin = new Default_Model_DbTable_Companyaccount();
                    $res = $editAdmin->editAdmin($sno,$bank,$name,$accno,$ifscNo,$branch,$address,$gstno);
                    die(json_encode(array('t' => $res, 'error' => true, 'gst' => $gstno)));
                }		
                die;
            }	
		
                public function deleteAction(){	
                    
                    $sno = (int) $this->getRequest()->getParam('sno');
                    //call model
                    $fee = new Default_Model_DbTable_Companyaccount(); 
                    echo $fee->deleteAdmin($sno);
                    die;
                }
		/*
			 * Name of action: editstatus
			 * Description:Edit the status of admin user in the  database.
		*/
            public function editstatusAction(){		
                
                $sts = (int) $this->getRequest()->getParam('sts');
                $sno = (int) $this->getRequest()->getParam('sno');
                //call model		
                $fee = new Default_Model_DbTable_Companyaccount(); 
                echo $fee->editstatusAdmin($sts,$sno);
                die;
            }
    // --------------bank details ----------
    public function savesigAction()
    {
        $db = Zend_Db_Table::getDefaultAdapter();
        $Session = new Zend_Session_Namespace("ZSN");

        $bankId = ($this->getRequest()->getParam('bank'));
        $sno = $this->getRequest()->getParam('editForm_id');
		
		$file = $this->getRequest()->getParam('file');
        $file2 = $this->getRequest()->getParam('editimage');

        $logo = $this->getRequest()->getParam('logo');
        $logo1 = $this->getRequest()->getParam('editimagelogo');
		$randomid = rand(1000,10000); 
        $randomidno = rand(10000,1000000);               
       
            if($bankId == '' ){
                die(json_encode(array('error'=>'All Fields(*) Are Required!!')));
            }
            else {
                    if ($_FILES["file"]['size'] > 0 && $_FILES["file"]['size'] <= 1048576 * 2) {
                        $name3 = $_FILES["file"]['name'];
                            // $extension=end(explode(".", $name3));
                            // $newfilename=$randomid .".".$extension;
                            $newfilename=   $name3;

                            $name4 = $_FILES["logo"]['name'];
                            // $extension1=end(explode(".", $name4));
                            // $newfile = $randomidno .".".$extension1;
                            $newfile =  $name4;
                            
                    /******************uploading solution file***************************/

                    $adapter = new Zend_File_Transfer_Adapter_Http();
                    $image_path = APPLICATION_PATH . '/../images/cImage/';

                    if (!file_exists($image_path)) mkdir($image_path);

                    $adapter->setDestination($image_path . $file);
                    // print_r($adapter->setDestination($image_path . $file));die;
                    $adapter->addValidator('Extension', false, 'jpg,png,gif,jpeg,pdf,doc,docx');

                    $files = $adapter->getFileInfo();
                    // print_r($files);
                    foreach ($files as $file => $info) {
                        $name = $adapter->getFileName($file);
                            $adapter->receive($info['name']);
                    }
                }
                        $save = new Default_Model_DbTable_Companyaccount();
                        $res = $save->addSig($bankId,$newfilename, $newfile);
                        die(json_encode(array('logo' => $newfile, 'sig' => $newfilename)));                             
                }
        
}











} //END CLASS

