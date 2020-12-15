
<?php

require('config.php');

$delete = $conn->query("TRUNCATE TABLE cart");
if ($delete) {
    echo "Success delete";
}
$conn->close();
return;

?>