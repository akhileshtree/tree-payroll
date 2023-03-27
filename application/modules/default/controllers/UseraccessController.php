<?php

class Default_UseraccessController extends Zend_Controller_Action
{
	public function sanitize($str){
        if(gettype($str) == 'string'){
            return trim(preg_replace("/[^ \w+\.,-]/", "", strip_tags($this->getRequest()->getParam($str))));
        }
        return trim(preg_replace("/[^0-9]/", "", (int)$this->getRequest()->getParam($str)));
    }


   public function init()
    	{			
			$this->view->assign('pageheader','User Access ');
			$this->view->headTitle()->append('Dashboard - ');
			$this->view->headMeta()->appendHttpEquiv('Content-Type','text/html; charset=utf-8');
			$this->_helper->layout()->setLayout('adminlayout');
			$Session = new Zend_Session_Namespace("ZSN");
			$this->view->menuActive = 'useraccess';
	
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

            $menu_sql = $db->query("SELECT * FROM `tbl_sidebar` Where category !=0  AND  status = 0");
            $sidemenu_query = $menu_sql->fetchAll();
            $this->view->sidemenu = $sidemenu_query;
            // print_r($sidemenu_query);

            $master_sql = $db->query("SELECT  *, GROUP_CONCAT(sidebar_id)as sidebar_name FROM `tbl_sidebar` WHERE category= 0 AND  status = 0 group by category");
            $master_res = $master_sql->fetchAll();
            $this->view->mastervalue = $master_res;

            $user_sql = $db->query("SELECT * FROM `tbl_register` WHERE Role != 'admin' ");
            $user_query = $user_sql->fetchAll();
            $this->view->userlist = $user_query; 

            $username_sql = $db->query("SELECT * FROM `tbl_employee` where emp_status = 'active' ");
            $user_name = $username_sql->fetchAll();
            $this->view->uname = $user_name;
            // echo "<pre>";print_r($user_name);

        } //END index

        public function saveAction()
        {
            $db = Zend_Db_Table::getDefaultAdapter();
                $Session = new Zend_Session_Namespace("ZSN");
                           
                $sno = $this->sanitize('editForm_id');         
                $user = $this->getRequest()->getParam('name');
                $email = $this->getRequest()->getParam('email');
                $pwd = $this->getRequest()->getParam('pwd');
                $UserName = $this->getRequest()->getParam('username');
                $Address = $this->getRequest()->getParam('address');
                $Role = $this->getRequest()->getParam('role');
                $mobileNo = $this->getRequest()->getParam('mobileNo'); 
                $sidebar = $this->getRequest()->getParam('sidebarmenu');   
                  
                $sidemenu=[];
                $sidebar_menu = implode(",", $sidebar);
                foreach($sidebar as $value){
                    array_push($sidemenu, $value);
                }
                $sidebarname = implode(",", $sidemenu); 
                $password = md5($pwd);
                // print_r($password); die;

                $sqlvalidation = $db->query("SELECT * FROM tbl_register  WHERE UserName = '$UserName' AND Password = '$password' AND Role = '$Role' ");
                    $res = $sqlvalidation->fetchAll();
                    $row = $res;
                    // print_r($res);
                    $total_data = count($row);
                    // print_r($total_data);
                if ( $total_data > 0) { 
                    die(json_encode(array('result'=>'This User Already Have Access')));

                }else{

                $empdel_sql = $db->select()->from('tbl_employee')->where('emp_name=?',$user);
                $empdel_query = $db->fetchRow($empdel_sql);
                $img = $empdel_query['emp_image'];


                if ($sno == 0 && isset($sno))  {				                   
                    $save = new Default_Model_DbTable_Adduser(); 
                    $res = $save->adduser($UserName,$user,$pwd, $Address, $mobileNo, $email, $sidebarname, $img, $Role);
                    $lastInsertId = $db->lastInsertId();   
                    die(json_encode(array('result'=>$res, 'cID' => $lastInsertId, 'email' =>$email,'pwd'=>$pwd,'user' => $user, 'UserName' =>$UserName,'Address'=>$Address,'Role' =>$Role,'mobileNo'=>$mobileNo, 'sidebar' => $sidebarname)));
                }//add client  
                
                }   
                die;


            
        }//save data

        public function editformAction()
        {
            $db = Zend_Db_Table::getDefaultAdapter();
            $Session = new Zend_Session_Namespace("ZSN");
            $employee_id = $this->getRequest()->getParam('emp_id'); 

            $empedit_sql = $db->select()->from('tbl_register')->where('Sno=?',$employee_id);
            $empedit_query = $db->fetchRow($empedit_sql);

                         
            die(json_encode(array('id' => $empedit_query['Sno'],
                'UserName' => $empedit_query['UserName'],
                'Name' => $empedit_query['Name'],
                'Address' => $empedit_query['Address'],
                'mobileNo'=> $empedit_query['mobileNo'],
                'emailId'=> $empedit_query['emailId'],
                'Role'=> $empedit_query['Role'], 
                'sideBar'=> $empedit_query['sideBar'],              
            )));               
          
            
        }//edit data

            public function submiteditedformAction()
            {
                $sno = $this->sanitize('editid');         
                $user = $this->getRequest()->getParam('name');
                $UserName = $this->getRequest()->getParam('username');
                $Role = $this->getRequest()->getParam('role');
                $sidebar = $this->getRequest()->getParam('sidebarmenu');   
                  
                $sidemenu=[];
                $sidebar_menu = implode(",", $sidebar);
                foreach($sidebar as $value){
                    array_push($sidemenu, $value);
                }
                $sidebarname = implode(",", $sidemenu); 

                $save = new Default_Model_DbTable_Adduser(); 
                $res = $save->edituser($sno,$UserName,$user, $sidebarname, $Role);
                die(json_encode(array('result'=>$res, 'name' => $user, 'UserName' =>$UserName,'Role' =>$Role, 'sidebar' => $sidebarname)));

            }//save edit data

            public function deleteAction()
            {
                $db = Zend_Db_Table::getDefaultAdapter();
                $Session = new Zend_Session_Namespace("ZSN");
    
                $sno = $this->getRequest()->getParam('emp_id');

                 //delete data from employee table
                 $employee = new Default_Model_DbTable_Adduser();
                 echo $employee->deleteAdmin($sno);
                 die;
               
            }//delete

           
    
        public function empdataAction()
        {		
            $db = Zend_Db_Table::getDefaultAdapter();
            $Session = new Zend_Session_Namespace("ZSN");
            $emp_name = $this->getRequest()->getParam('emp_name');

            $empdel_sql = $db->select()->from('tbl_employee')->where('emp_name=?',$emp_name);
            $empdel_query = $db->fetchRow($empdel_sql);
                       
            die(json_encode(array('email'=>$empdel_query['emp_email'],'phone'=>$empdel_query['emp_ph_no'], 'address'=>$empdel_query['address'])));

            
        }


} //END CLASS

