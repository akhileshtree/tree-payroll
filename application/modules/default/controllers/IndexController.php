<?php
error_reporting(0);
use LDAP\Result;

class Default_IndexController extends Zend_Controller_Action
{
	public function init()
	{		
		$this->_helper->layout()->setLayout('admin_login_layout');		
		$this->view->assign('title', 'Administrative Panel - Traffic Vioaltion');
		$this->view->assign('CompanyName','Developed by : Tree Multisoft Services');
		// $this->view->headMeta()->appendHttpEquiv('Content-Type','text/html; charset=utf-8');
		$this->view->assign('path', $this->getRequest()->getBaseURL()."/");
		
	}
	public function indexAction()
	{
		
		$db=Zend_Db_Table::getDefaultAdapter();
		$Session = new Zend_Session_Namespace("ZSN");
		
		if(isset($Session->LoginName) && isset($Session->LoginPassword))
		{
			$route = array('module'=>'default','controller'=>'dashbord');
			$this->_helper->redirector->gotoRoute($route,null,true);
		}
		
	} //end index
	
	
	/**
	 * @throws Zend_Session_Exception
     */
	public function loginAction()
	{
		$db=Zend_Db_Table::getDefaultAdapter();
		$Session = new Zend_Session_Namespace("ZSN");
       
            $uname = strip_tags($this->getRequest()->getParam('Db_Un',''));
            $paswd = strip_tags($this->getRequest()->getParam('Db_Pw',''));
            // $captcha = $this->getRequest()->getParam('captcha');
            $cID = (int) strip_tags(0);
			// print_r($uname);
			// die;
						
            if(isset($uname) && isset($paswd) && isset($cID))
            {
                $element = array("$uname","$paswd",$cID);
                $result=$db->query("call prouserlogin(?,?,?)",$element);
                $res=$result->fetch();

				//********************************* Admin login ************************************ */
				// if($res['Role'] == "admin")
                // {    
				if(count($res['UserName'])>0 && count($res['Password'])>0)
				{             	
                	$Session->sess_id = session_id();
                    //find the sever ipaddress
                    $Session->IpAddress = $this->getRequest()->getServer('REMOTE_ADDR');
                    $Session->LoginName = $this->getRequest()->getParam('Db_Un');
                    $Session->LoginPassword = $this->getRequest()->getParam('Db_Pw');

                    $Session->cID = $res['Sno'];
                    $Session->companyName = $res['companyName'];
                    $Session->RandNo = rand();
                    $Session->UserName = $res['UserName'];
                    $Session->UserEmailId = $res['EMail'];
                    $Session->department = $res['department_type_id']; 
					$Session->role = $res['Role'];                   
                    $Session->setExpirationSeconds(10,'UserName');
                    $db->closeConnection();
                    //close result  			
					try{	
						$updt=$db->query("update tbl_register set sesion_id = '".$Session->sess_id."' 
                    	where UserName='".$res['UserName']."' AND Password='".$res['Password']."' AND department_type_id='".$res['department_type_id']."'");
						$updt2=$db->query("call prosavesessionmanagement('$Session->cID','$Session->companyName','$Session->IpAddress','$Session->LoginCountry',now(),'','SuperAdmin','$Session->RandNo' )");
						$db->closeConnection();
					}
					catch (Zend_Exception $e) {
						echo $e ;
					}

                    $route = array('module'=>'default','controller'=>'dashbord');
                    $this->_helper->redirector->gotoRoute($route,null,true);						
				}
				// -------------------------------end user login-------------------->
                else
                {
                    $Session->ErrorMessage = "<span style='color:red;'>The User Name or password you entered is incorrect !!</span>";
                    $Session->UName=$this->getRequest()->getParam('Db_Un');
                    $route = array('module'=>'default');
                    $this->_helper->redirector->gotoRoute($route,null,true);
                }

				//*********************************end login **************************** */
            }
            else
            {
                $Session->ErrorMessage = "Please Login First !!";
                $route = array('module'=>'default');
                $this->_helper->redirector->gotoRoute($route,null,true);
            }
        	
	} //END LOGIN


	
	public function logoutAction()
	{
	
		$db = Zend_Db_Table::getDefaultAdapter();
		$Session = new Zend_Session_Namespace("ZSN");
		
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
		unset($Session->department);		
		
		$route = array('module'=>'default');
		$this->_helper->redirector->gotoRoute($route,null,true);
		
	} //end logout
	
	
	

} //end class

