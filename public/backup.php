<?php

function backup_db(){
	include("connection.php");
/* Store All Table name in an Array */
$allTables = array();
$return = "";
$result = mysqli_query($connection,'SHOW TABLES');
while($row = mysqli_fetch_row($result)){
     $allTables[] = $row[0];
}

foreach($allTables as $table){
$result = mysqli_query($connection,'SELECT * FROM '.$table);
$num_fields = mysqli_num_fields($result);

$return.= 'DROP TABLE IF EXISTS '.$table.';';
$row2 = mysqli_fetch_row(mysqli_query($connection,'SHOW CREATE TABLE '.$table));
$return.= "\n\n".$row2[1].";\n\n";

for ($i = 0; $i < $num_fields; $i++) {
while($row = mysqli_fetch_row($result)){
   $return.= 'INSERT INTO '.$table.' VALUES(';
     for($j=0; $j<$num_fields; $j++){
       $row[$j] = addslashes($row[$j]);
       $row[$j] = str_replace("\n","\\n",$row[$j]);
       if (isset($row[$j])) { $return.= '"'.$row[$j].'"' ; } 
       else { $return.= '""'; }
       if ($j<($num_fields-1)) { $return.= ','; }
     }
   $return.= ");\n";
}
}
$return.="\n\n";
}

// Create Backup Folder
$folder = APPLICATION_PATH."/data/backup/";
if (!is_dir($folder))
mkdir($folder, 0777, true);
chmod($folder, 0777);

$date = date('m-d-Y-H-i-s', time()); 
$filename = "db-backup-".$date.'.sql'; 

$handle = fopen($folder.$filename,'w+');
fwrite($handle,$return);

header("Content-type: application/octet-stream");
header('Content-Disposition: attachment; filename="'.$filename);
readfile($folder.$filename);
fclose($handle);
unlink($folder.$filename);
}

// Call the function
backup_db();
?>