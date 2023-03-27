<?php

class Default_EmployeeController extends Zend_Controller_Action
{
	public function sanitize($str){
        if(gettype($str) == 'string'){
            return trim(preg_replace("/[^ \w+\.,-]/", "", strip_tags($this->getRequest()->getParam($str))));
        }
        return trim(preg_replace("/[^0-9]/", "", (int)$this->getRequest()->getParam($str)));
    }


   public function init()
    	{			
			$this->view->assign('pageheader','Employees');
			// $this->view->headTitle()->append('Dashboard - ');
			$this->view->headMeta()->appendHttpEquiv('Content-Type','text/html; charset=utf-8');
			$this->_helper->layout()->setLayout('adminlayout');
			$Session = new Zend_Session_Namespace("ZSN");
			$this->view->menuActive = 'Employee';
	
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
                unset($Session->department);
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
            // Department query
            $menu_sql = $db->query("SELECT * FROM `tbl_department` Where status = 0");
            $department_query = $menu_sql->fetchAll();
            $this->view->department = $department_query;
            // print_r($sidemenu_query);

            // Query for genrate Employee ID card
            $sql_max_No = $db->select()->from('tbl_employee', array('max(id) As empId'));
            $empId = $db->fetchRow($sql_max_No);
            $emp_no =($empId['empId'] == NULL )? 1001 : ($empId['empId'] + 1);//genrate Emp_no
            $emp_id = 'TREE'.''.$emp_no;
            $this->view->EmpId = $emp_id;  

            // Query for genrate Employee card No
            $sql_cardno = $db->select()->from('tbl_employee', array('max(emp_card_no) As emp_cardno'));
            $empcard = $db->fetchRow($sql_cardno);
            $emp_cardno =($empcard['emp_cardno'] == NULL )? 100 : ($empcard['emp_cardno'] + 1);//genrate Emp_no
            $this->view->cardno = $emp_cardno; 
            // print_r($emp_cardno);

            // Query for  Employee Data
            $emp_sql = $db->select()->from('tbl_employee')->joinLeft('tbl_department', 'tbl_department.depatment_id = tbl_employee.department',array('tbl_department.department_name as depart_name'))->where("emp_status = 'active'");
            $emp_query = $db->fetchAll($emp_sql);
            $this->view->emplist = $emp_query; 

            // Department query
            // $autodelete = $db->query("SELECT * FROM `tbl_employee` Where emp_id = $emp_id and  leavingdate = '' ");
            // $autodelete_query = $autodelete->fetchAll();
            // $this->view->department = $department_query;
            // print_r($sidemenu_query);



        } //END index

        public function saveAction()
        {
            $db = Zend_Db_Table::getDefaultAdapter();
                $Session = new Zend_Session_Namespace("ZSN");
                           
                // $sno = $this->getRequest()->getParam('editemp_id');         
                $cardno = $this->getRequest()->getParam('cardno');
                $emp_name = $this->getRequest()->getParam('name');
                $email = $this->getRequest()->getParam('email');
                $mobileNo = $this->getRequest()->getParam('mobileNo');
                $dob = $this->getRequest()->getParam('dob');
                $gender = $this->getRequest()->getParam('gender');
                $maritalstatus = $this->getRequest()->getParam('maritalstatus'); 
                $address = $this->getRequest()->getParam('address'); 
                $department = $this->getRequest()->getParam('department');
                $designation = $this->getRequest()->getParam('designation');
                $salary = $this->getRequest()->getParam('salary');
                $worktype = $this->getRequest()->getParam('worktype');
                $joiningdate = $this->getRequest()->getParam('joiningdate');
                $leavingdate = $this->getRequest()->getParam('leavingdate');
                $pnumber = $this->getRequest()->getParam('pnumber'); 
                $pname = $this->getRequest()->getParam('pname');  
                $prelation = $this->getRequest()->getParam('prelation'); 
                $paddress = $this->getRequest()->getParam('paddress'); 
                $bankname = $this->getRequest()->getParam('bankname');
                $bankaddress = $this->getRequest()->getParam('bankaddress');
                $accnumber = $this->getRequest()->getParam('accnumber');
                $accname = $this->getRequest()->getParam('accname');
                $ifscno = $this->getRequest()->getParam('ifscno');
                $acctype = $this->getRequest()->getParam('acctype');
                $emp_id = $this->getRequest()->getParam('emp_id'); 
                $panNumber = $this->getRequest()->getParam('panNumber');
                $adharnumber = $this->getRequest()->getParam('adharnumber');
                $blood_group = $this->getRequest()->getParam('bloodgroup');
                $file = $this->sanitize('employee_img');
                $randomid = rand(1000,10000);
                $photo = date('Ymdhis');

                if ($_FILES["employee_img"]['size'] > 0 && $_FILES["employee_img"]['size'] <= 1048576 * 2)
                {
                    // /*************uploading solution file***************************/
                    $adapter = new Zend_File_Transfer_Adapter_Http();
                    $image_path = APPLICATION_PATH . '/../images/cImage/';
                    if (!file_exists($image_path)) mkdir($image_path);
                    $adapter->setDestination($image_path . $file);
                    $adapter->addValidator('Extension', false, 'jpg,png,jpeg');
        
                    $files = $adapter->getFileInfo();        
                    foreach ($files as $file => $info) {
                        $name = $adapter->getFileName($file);
                        //find the file extension
                        $ext = pathinfo($name, PATHINFO_EXTENSION);
                        // Set a new destination path and overwrites existing files
                        $adapter->addFilter("Rename", array('target' => $image_path . $photo . '.' . $ext, 'overwrite' => true));
                        //resize uploaded image
                        $adapter->addFilter(new Skoch_Filter_File_Resize(array('width' => 121, 'height' => 130, 'keepRatio' => false)));
                        // file uploaded & is valid
                        if (!$adapter->isUploaded($file)) continue;
                        if (!$adapter->isValid($file)) continue;
                        // receive the files into the user directory
                        $adapter->receive($file); // this has to be on top
                    }
                }               
                    $sqlvalidation = $db->query("SELECT * FROM tbl_employee  WHERE emp_card_no = '$cardno' AND emp_name = '$emp_name' AND emp_ph_no = '$mobileNo' ");
                    $res = $sqlvalidation->fetchAll();
                    $row = $res;
                    $total_data = count($row);
                    if ( $total_data > 0) { 
                        die(json_encode(array('Error' => 'This Employee Already Exists.. Please Try Other One')));
                    } else {             
                                                                
                        $save = new Default_Model_DbTable_Employee(); 
                        $res = $save->addemp($emp_id,$cardno,$emp_name,$email, $mobileNo, $dob, $gender, $maritalstatus, $address, $panNumber, $adharnumber, $blood_group, $department,$designation, $salary, $worktype, $joiningdate, $leavingdate, $pname, $pnumber,  $prelation, $paddress,$bankname, $bankaddress, $accnumber, $accname, $ifscno, $acctype, $photo . '.' . $ext);
                        $lastInsertId = $db->lastInsertId();   

                        die(json_encode(array('result'=>$res, 'cID' => $lastInsertId, 'email' =>$email,'name'=>$emp_name,'mobileNo' => $mobileNo, 'dob' =>$dob,'Address'=>$address,'gender' =>$gender,'department'=>$department, 'designation' => $designation)));
                    }//add client 

        }//save data

        public function editformviewAction()
        {   
            $db = Zend_Db_Table::getDefaultAdapter();
            $Session = new Zend_Session_Namespace("ZSN");

            $employee_id = $this->getRequest()->getParam('emp_id'); 
            $empedit_sql = $db->select()->from('tbl_employee')->joinLeft('tbl_department', 'tbl_department.depatment_id = tbl_employee.department',array('tbl_department.department_name as depart_name'))->where('emp_id=?',$employee_id);
            $empedit_query = $db->fetchRow($empedit_sql);
                         
            die(json_encode(array('id' => $empedit_query['id'],
                'emp_id' => $empedit_query['emp_id'],
                'emp_card_no' => $empedit_query['emp_card_no'],
                'emp_name' => $empedit_query['emp_name'],
                'emp_email'=>$empedit_query['emp_email'],
                'emp_ph_no'=> $empedit_query['emp_ph_no'],
                'dob'=> $empedit_query['dob'],
                'gender'=> $empedit_query['gender'],
                'maritalstatus'=> $empedit_query['maritalstatus'], 
                'address' => $empedit_query['address'],
                'department' => $empedit_query['department'],
                'designation' => $empedit_query['designation'],
                'salary' => $empedit_query['salary'],
                'worktype'=>$empedit_query['worktype'],
                'joiningdate'=> $empedit_query['joiningdate'],
                'leavingdate'=> $empedit_query['leavingdate'],
                'p_name'=> $empedit_query['p_name'],
                'p_number'=> $empedit_query['p_number'], 
                'p_relation' => $empedit_query['p_relation'],
                'p_address' => $empedit_query['p_address'],
                'bankname' => $empedit_query['bankname'],
                'bankaddress' => $empedit_query['bank_branch'],
                'accnumber'=>$empedit_query['accnumber'],
                'accname'=> $empedit_query['accname'],
                'ifscno'=> $empedit_query['ifscno'],
                'acctype'=> $empedit_query['acctype'],
                'emp_status'=> $empedit_query['emp_status'],
                'pan_number'=> $empedit_query['pan_number'],
                'adhar_number'=> $empedit_query['adhar_number'],
                'blood_group'=> $empedit_query['blood_group'],
            )));               
            
        }//edit data

        public function saveeditformAction()
        {
            $db = Zend_Db_Table::getDefaultAdapter();
            $Session = new Zend_Session_Namespace("ZSN");
                           
                $sno = $this->getRequest()->getParam('editid');         
                $cardno = $this->getRequest()->getParam('cardno');
                $name = $this->getRequest()->getParam('name');
                $email = $this->getRequest()->getParam('email');
                $mobileNo = $this->getRequest()->getParam('mobileNo');
                $dob = $this->getRequest()->getParam('dob');
                $gender = $this->getRequest()->getParam('gender');
                $maritalstatus = $this->getRequest()->getParam('maritalstatus'); 
                $address = $this->getRequest()->getParam('address'); 
                $department = $this->getRequest()->getParam('department');
                $designation = $this->getRequest()->getParam('designation');
                $salary = $this->getRequest()->getParam('salary');
                $worktype = $this->getRequest()->getParam('worktype');
                $joiningdate = $this->getRequest()->getParam('joiningdate');
                $leavingdate = $this->getRequest()->getParam('leavingdate');
                $pnumber = $this->getRequest()->getParam('pnumber'); 
                $pname = $this->getRequest()->getParam('pname');  
                $prelation = $this->getRequest()->getParam('prelation'); 
                $paddress = $this->getRequest()->getParam('paddress'); 
                $bankname = $this->getRequest()->getParam('bankname');
                $bankaddress = $this->getRequest()->getParam('bankaddress');
                $accnumber = $this->getRequest()->getParam('accnumber');
                $accname = $this->getRequest()->getParam('accname');
                $ifscno = $this->getRequest()->getParam('ifscno');
                $acctype = $this->getRequest()->getParam('acctype');
                $emp_id = $this->getRequest()->getParam('emp_id');
                $panNumber = $this->getRequest()->getParam('panNumber');
                $adharnumber = $this->getRequest()->getParam('adharnumber');  
                $blood_group  = $this->getRequest()->getParam('bloodgroup');        
                                 
                    $editDetails = new Default_Model_DbTable_Employee();
                    $result = $editDetails->editemp($sno,$cardno,$name,$email, $mobileNo, $dob, $gender, $maritalstatus, $address, $panNumber, $adharnumber, $blood_group, $department,$designation, $salary, $worktype, $joiningdate, $leavingdate, $pname, $pnumber, $prelation, $paddress,$bankname, $bankaddress, $accnumber, $accname, $ifscno, $acctype); 
                       
            die(json_encode(array('result'=>$result, 'emp_id'=>$sno, 'email' =>$email,'name'=>$name,'mobileNo' => $mobileNo, 'dob' =>$dob,'Address'=>$address,'gender' =>$gender,'department'=>$department, 'designation' => $designation)));             
                       
        }//save data

        public function deleteAction()
        {
            $db = Zend_Db_Table::getDefaultAdapter();
            $Session = new Zend_Session_Namespace("ZSN");

            $sno = $this->getRequest()->getParam('emp_id');
            $status = $this->getRequest()->getParam('status');

            $empdel_sql = $db->select()->from('tbl_employee')->where('emp_id=?',$sno);
            $empdel_query = $db->fetchRow($empdel_sql);

                $emp_id             = $empdel_query['emp_id'];
                $emp_card_no        = $empdel_query['emp_card_no'];
                $emp_name           = $empdel_query['emp_name'];
                $emp_email          = $empdel_query['emp_email'];
                $emp_ph_no          = $empdel_query['emp_ph_no'];
                $dob                = $empdel_query['dob'];
                $gender             = $empdel_query['gender'];
                $maritalstatus      = $empdel_query['maritalstatus']; 
                $address            = $empdel_query['address'];
                $pan_number         = $empdel_query['pan_number'];
                $adhar_number       = $empdel_query['adhar_number'];
                $department         = $empdel_query['department'];
                $designation        = $empdel_query['designation'];
                $salary             = $empdel_query['salary'];
                $worktype           = $empdel_query['worktype'];
                $joiningdate        = $empdel_query['joiningdate'];
                $leavingdate        = $empdel_query['leavingdate'];
                $p_name             = $empdel_query['p_name'];
                $p_number           = $empdel_query['p_number']; 
                $p_relation         = $empdel_query['p_relation'];
                $p_address          = $empdel_query['p_address'];
                $bankname           = $empdel_query['bankname'];
                $bank_branch        = $empdel_query['bank_branch'];
                $accnumber          = $empdel_query['accnumber'];
                $accname            = $empdel_query['accname'];
                $ifscno             = $empdel_query['ifscno'];
                $acctype            = $empdel_query['acctype'];
                $emp_image          = $empdel_query['emp_image'];
            
                //save data into temp tabl 
                $save = new Default_Model_DbTable_Deletedemp(); 
                $res = $save->addemp($emp_id,$emp_card_no,$emp_name,$emp_email, $emp_ph_no, $dob, $gender, $maritalstatus, $address, $pan_number, $adhar_number, $department,$designation, $salary, $worktype, $joiningdate, $leavingdate, $p_name, $p_number,  $p_relation, $p_address,$bankname, $bank_branch, $accnumber, $accname, $ifscno, $acctype, $emp_image);
                $lastInsertId = $db->lastInsertId();
            
                //delete data from employee table
                 $employee = new Default_Model_DbTable_Employee();
                 echo $employee->deleteemp($sno);

                //delete data from employee table
                $access = new Default_Model_DbTable_Adduser();
                echo $access->deleteemp($emp_id);

                die(json_encode(array('result'=>$res, $emp_id,$emp_card_no,$emp_name,$emp_email, $emp_ph_no, $dob, $gender, $maritalstatus, $address, $pan_number, $adhar_number, $department,$designation, $salary, $worktype, $joiningdate, $leavingdate, $p_name, $p_number,  $p_relation, $p_address,$bankname, $bank_branch, $accnumber, $accname, $ifscno, $acctype, $emp_image)));

// print_r( $res);

            // $employee = new Default_Model_DbTable_Employee();
            // echo $employee->deleteemp($sno, $status);
            // die; 
        }//delete
        
        public function empevalidationAction()
        {
            $db = Zend_Db_Table::getDefaultAdapter();
            $Session = new Zend_Session_Namespace("ZSN");
            $Emp_email = $this->getRequest()->getParam('emp_email');  
            // print_r($Emp_name); die;
            
            $sql_emp = $db->select()->from('tbl_employee', array('emp_email'))->where('emp_email =?',$Emp_email);
            $empemail = $db->fetchRow($sql_emp);
            // print_r($empemail);

            if ( $empemail['emp_email'] ==  $Emp_email) { 
                die(json_encode(array('Error' => 'This Employee Email Id Already Exists.. Please Try Other One')));
            }else{
                die(json_encode(array('Done' => 'Done')));
            }       
              
        }

        
        public function empevalidationnoAction()
        {
            $db = Zend_Db_Table::getDefaultAdapter();
            $Session = new Zend_Session_Namespace("ZSN");
            $Emp_no = $this->getRequest()->getParam('emp_no');  

            $sql_empno = $db->select()->from('tbl_employee', array('emp_ph_no'))->where('emp_ph_no =?',$Emp_no);
            $empno = $db->fetchRow($sql_empno);
            // print_r($empemail);

            if ( $empno['emp_ph_no'] ==  $Emp_no) { 
                die(json_encode(array('Error' => 'This Employee Number Already Exists.. Please Try Other One')));
            }else{
                die(json_encode(array('Done' => 'Done')));
            }       
              
        }

        public function validationdobAction()
        {
            $db = Zend_Db_Table::getDefaultAdapter();
            $Session = new Zend_Session_Namespace("ZSN");
                           
            $dob = $this->getRequest()->getParam('dateofbirth');
                $date2=date("d-m-Y");//today's date
                $date1=new DateTime($dob);
                $date2=new DateTime($date2);    
                $interval = $date1->diff($date2);
                $myage= $interval->y; 
                if ($myage >= 18){ 
                    die(json_encode(array('Done' => 'allowd')));
                }else{ 
                    die(json_encode(array('Error' => 'error')));
                }
        }
        public function banckinfoAction()
        {
            $db = Zend_Db_Table::getDefaultAdapter();
            $Session = new Zend_Session_Namespace("ZSN");
            $ifsccode = $this->getRequest()->getParam('ifsccode');                    
            
            // $json = file_get_contents('https://ifsc.razorpay.com/'.$ifsccode);
            // $arr = json_decode($json);  
            $curl = curl_init();
            $url = 'https://ifsc.razorpay.com/'.$ifsccode ;
            curl_setopt_array($curl, array(
            CURLOPT_URL => $url,
            ));
                $response = curl_exec($curl);
                $err = curl_error($curl);
                curl_close($curl);

                    // if ($err) {
                    //     die(json_encode('Error' => $err));
                    // } else {
                    //     die( $response);
                    // }        
          
                    // echo "<pre>"; print_r($response);
            die;      
        }

       

          

} //END CLASS

