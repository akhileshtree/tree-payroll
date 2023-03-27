<?php

class Default_DepartmentController extends Zend_Controller_Action
{
	public function sanitize($str){
        if(gettype($str) == 'string'){
            return trim(preg_replace("/[^ \w+\.,-]/", "", strip_tags($this->getRequest()->getParam($str))));
        }
        return trim(preg_replace("/[^0-9]/", "", (int)$this->getRequest()->getParam($str)));
    }


   public function init()
    	{			
			$this->view->assign('pageheader','Depatments');
			// $this->view->headTitle()->append('Dashboard - ');
			$this->view->headMeta()->appendHttpEquiv('Content-Type','text/html; charset=utf-8');
			$this->_helper->layout()->setLayout('adminlayout');
			$Session = new Zend_Session_Namespace("ZSN");
			$this->view->menuActive = 'Department';
	
			if(!isset($Session->LoginName) && !isset($Session->LoginPassword))
			{
				$Session->ErrorMessage = "No activity within 20 Minute; please log in again!!";	
				$route = array('module'=>'default');						
				$this->_helper->redirector->gotoRoute($route,null,true);
			}
			
			$db = Zend_Db_Table::getDefaultAdapter();
            $sql_user = $db->select()->from('tbl_register', array('companyName', 'photo','Name','sesion_id', 'Role'))->where('Sno=?', (int)$Session->cID);
            $this->view->login_user = $db->fetchRow($sql_user);
            $sid =  $db->fetchRow($sql_user);
            
                // $this->_helper->layout()->setLayout('adminlayout');
           

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
                unset($Session->RandNo);

                $route = array('module'=>'default');
                $this->_helper->redirector->gotoRoute($route,null,true);
            }
   		}

        public function indexAction()
        {
            $db = Zend_Db_Table::getDefaultAdapter();

            $department = $db->query("SELECT * FROM `tbl_department`");
            $department_query = $department->fetchAll();
            $this->view->department = $department_query;
        } //END index

        public function saveAction()
        {
            $db = Zend_Db_Table::getDefaultAdapter();
                $Session = new Zend_Session_Namespace("ZSN");   
                $departmentname = $this->getRequest()->getParam('departmentname');
                $departmentnote = $this->getRequest()->getParam('departmentnote');
                 
                if($departmentname == '' ){
                    die(json_encode(array('error'=>'All Fields(*) Are Required!!')));
                }            
                    $save = new Default_Model_DbTable_Department(); 
                    $res = $save->adduser($departmentname,$departmentnote);
                    $lastInsertId = $db->lastInsertId();   
                    die(json_encode(array('result'=>$res, 'cID' => $lastInsertId, 'departmentname' =>$departmentname, 'departmentnote' => $departmentnote)));               
        }//save data

        public function editformAction()
        {
            $db = Zend_Db_Table::getDefaultAdapter();
            $Session = new Zend_Session_Namespace("ZSN");
            $depatment_id = $this->getRequest()->getParam('department_id');
           
            $depatmentedit_sql = $db->select()->from('tbl_department')->where('depatment_id=?',$depatment_id);
            $depatmentedit_query = $db->fetchRow($depatmentedit_sql);
            die(json_encode(array('depatment_id' => $depatmentedit_query['depatment_id'],
                'department_name' => $depatmentedit_query['department_name'],
                'note' => $depatmentedit_query['note'],
            ))); 
              
            // $where['depatment_id = ?'] = $sno;
            // $sql = $this->update($data, $where);
            // $mssg = $sql."Records has been Updated Successfully !!";          
        }//edit data

        public function submiteditedformAction()
        {
            $db = Zend_Db_Table::getDefaultAdapter();
            $Session = new Zend_Session_Namespace("ZSN");

            $sno = $this->sanitize('department_id');
            $departmentname = $this->sanitize('departmentname');
            $note = $this->sanitize('departmentnote');

            $editDetails = new Default_Model_DbTable_Department();
            $res = $editDetails->editBatch($sno, $departmentname, $note);

            $sql_class = $db->select()->from('tbl_department')->where('depatment_id=?', $sno);
            $outp = $db->fetchRow($sql_class);
                                                                        //batch
            die(json_encode(array('result'=>$res, 'id'=>$outp['depatment_id'], 'departmentname'=> $outp['department_name'], 'note' => $outp['note'])));
        }//save edit data

            public function deleteAction()
            {
                $db = Zend_Db_Table::getDefaultAdapter();
                $Session = new Zend_Session_Namespace("ZSN");
    
                $sno = $this->getRequest()->getParam('id');    
                    //delete data from employee table
                     $employee = new Default_Model_DbTable_Department();
                     echo $employee->deletedepartment($sno);
                    die;
    
            }//delete

            public function editstatusAction()
            {
                $sts = $this->getRequest()->getParam('sts');
                $sno = (int)$this->getRequest()->getParam('department_id');
                $fee = new Default_Model_DbTable_Department();
                echo $fee->editstatusAdmin($sts, $sno);
                die;
            }//end edit status action

    
} //END CLASS

