
<?php

require('config.php');

$query = $conn->query("SELECT SUM(menuprice) as total FROM cart");
$data = array();

while ($row = $query->fetch_assoc()) {
    $data[] = $row;
}

echo json_encode($data);
$conn->close();
return;

?>