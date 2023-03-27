<?php

class Default_EmployeedetailsController extends Zend_Controller_Action
{
	public function sanitize($str){
        if(gettype($str) == 'string'){
            return trim(preg_replace("/[^ \w+\.,-]/", "", strip_tags($this->getRequest()->getParam($str))));
        }
        return trim(preg_replace("/[^0-9]/", "", (int)$this->getRequest()->getParam($str)));
    }

   public function init()
    	{			
			$this->view->assign('pageheader','Employees Details');
			// $this->view->headTitle()->append('Dashboard - ');
			$this->view->headMeta()->appendHttpEquiv('Content-Type','text/html; charset=utf-8');
			$this->_helper->layout()->setLayout('adminlayout');
			$Session = new Zend_Session_Namespace("ZSN");
			// $this->view->menuActive = 'service';
	
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
            $empId = $this->getRequest()->getParam('id');
            
            // die;
            
            // Department query
            $menu_sql = $db->query("SELECT * FROM `tbl_department` Where status = 0");
            $department_query = $menu_sql->fetchAll();
            $this->view->department = $department_query;
            // print_r($sidemenu_query);
          
            // Query for  Employee Data
            $emp_sql = $db->select()->from('tbl_employee')->joinLeft('tbl_department', 'tbl_department.depatment_id = tbl_employee.department',array('tbl_department.department_name as depart_name'))->where('emp_id =?',$empId);
            $emp_query = $db->fetchRow($emp_sql);
            $this->view->emplist = $emp_query; 
       
            $empsql = $db->select()->from('tbl_register')->where('Name=?',$empId);
            $empsql_query = $db->fetchRow($empsql);
            $this->view->access = $empsql_query;
    // echo "<pre>"; print_r($empsql_query);

        } //END index

        public function saveAction()
        {
            $db = Zend_Db_Table::getDefaultAdapter();
                $Session = new Zend_Session_Namespace("ZSN");
                           
                $sno = $this->sanitize('userid'); 
                $pwd = $this->getRequest()->getParam('pwd');        
                
                $empdel_sql = $db->select()->from('tbl_employee')->where('emp_id=?',$sno);
                $empdel_query = $db->fetchRow($empdel_sql);
                
                $user =  $sno;
                $UserName = $empdel_query['emp_email'];
                $mobileNo = $empdel_query['emp_ph_no'];
                $Address =  $empdel_query['address'];
                $img = $empdel_query['emp_image'];           
                $Role = 'user';
                            
                $sqlvalidation = $db->query("SELECT * FROM tbl_register  WHERE Name = '$sno' ");
                    $res = $sqlvalidation->fetchAll();
                    $row = $res;
                    $total_data = count($row);
                if ( $total_data > 0) { 
                    die(json_encode(array('result'=>'This User Already Have Access')));

                }else{         

                if ($sno == 0 && isset($sno))  {

                    $save = new Default_Model_DbTable_Adduser(); 
                    $res = $save->adduser($UserName,$user,$pwd, $Address, $mobileNo, $UserName, $img, $Role);
                    $lastInsertId = $db->lastInsertId();   
                    die(json_encode(array('result'=>$res, 'cID' => $lastInsertId, 'email' =>$UserName,'pwd'=>$pwd,'user' => $user, 'UserName' =>$UserName,'Address'=>$Address,'Role' =>$Role,'mobileNo'=>$mobileNo, 'department_type_id' =>$sno )));
                }//add client  
                
                }   
                die; 
               
        }//save data

       

        public function editformAction()
        {

            
        }//edit data

            public function submiteditedformAction()
            {

                $db = Zend_Db_Table::getDefaultAdapter();
                $Session = new Zend_Session_Namespace("ZSN");
                           
                $sno = $this->getRequest()->getParam('userid'); 
                $pwd = $this->getRequest()->getParam('pwd');
                // $password = md5($pwd); 

                $save = new Default_Model_DbTable_Adduser(); 
                $res = $save->edituser($sno,$pwd);
                $lastInsertId = $db->lastInsertId();   
                die(json_encode(array('result'=>$res, 'cID' => $lastInsertId, 'email' =>$sno,'pwd'=>$pwd)));


            }//save edit data

            public function deleteAction()
            {
               
            }//delete

          

} //END CLASS

