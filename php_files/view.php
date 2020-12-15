<?php

require('config.php');

$query = $conn->query("SELECT * FROM menu ORDER BY menuid ASC");
$data = array();

while ($row = $query->fetch_assoc()) {
    $data[] = $row;
}

echo json_encode($data);
$conn->close();
return;
