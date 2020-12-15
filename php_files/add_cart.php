
<?php

require('config.php');

$menuid = $_POST['menuid'];
$menuname = $_POST['menuname'];
$menuprice = $_POST['menuprice'];

$insert = $conn->query("INSERT INTO cart(menuid, menuname, menuprice) VALUES('$menuid','$menuname','$menuprice')");
if ($insert) {
    echo "Success";
}
$conn->close();
return;

?>