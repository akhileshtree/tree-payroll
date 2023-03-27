public function savesigAction()
    {
        $db = Zend_Db_Table::getDefaultAdapter();
        $Session = new Zend_Session_Namespace("ZSN");

        $bankId = ($this->getRequest()->getParam('bank'));
        
		
		$file = $this->getRequest()->getParam('file');
        $logo = $this->getRequest()->getParam('logo');
		$randomid = rand(1000,10000); 
       
		 if($bankId == '' ){
            die(json_encode(array('error'=>'All Fields(*) Are Required!!')));
        }
		else {
			 if ($_FILES["file"]['size'] > 0 && $_FILES["file"]['size'] <= 1048576 * 2) {
                   $name3 = $_FILES["file"]['name'];
					// $extension=end(explode(".", $name3));
					$newfilename=   $name3;
                    $name4 = $_FILES["logo"]['name'];
					// $extension1=end(explode(".", $name4));
					$newfile =  $name4;
					
            /******************uploading solution file***************************/

            $adapter = new Zend_File_Transfer_Adapter_Http();
            $image_path = APPLICATION_PATH . '/../images/cImage/';

            if (!file_exists($image_path)) mkdir($image_path);

            $adapter->setDestination($image_path . $file);
            $adapter->addValidator('Extension', false, 'jpg,png,gif,jpeg,pdf,doc,docx');

            $files = $adapter->getFileInfo();
            // print_r($files);
            foreach ($files as $file => $info) {
                // $name = $adapter->getFileName($file);
                // $name1 = $adapter->getFileName($logo);
            // //     //find the file extension
                // $ext = pathinfo($name, PATHINFO_EXTENSION);             
              
				// $adapter->addFilter('Rename', $image_path. $newfilename, true);
            // print_r($adapter->addFilter('Rename', $image_path. $newfilename, $image_path. $newfile, true));
            //     // file uploaded & is valid
                // if (!$adapter->isUploaded($file)) continue;
                // if (!$adapter->isValid($file)) continue;

                // if (!$adapter->isUploaded($logo)) continue;
                // if (!$adapter->isValid($logo)) continue;

            //     // receive the files into the user directory
                     $adapter->receive($info['name1']); // this has to be on top
					 $adapter->receive($info['name']);
			}
		 }

            $save = new Default_Model_DbTable_Companyaccount();
            $res = $save->addSig($bankId,$newfilename, $newfile);
        //    print_r($res);

            die(json_encode(array('logo' => $newfile, 'sig' => $newfilename)));
        }
    }