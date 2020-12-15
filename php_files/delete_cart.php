
<?php

require('config.php');

$cartid = $_POST['cartid'];

$delete = $conn->query("DELETE FROM cart WHERE cartid = '$cartid' ");
if ($delete) {
    echo "Success";
}
$conn->close();
return;

?>