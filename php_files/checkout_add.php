
<?php

require('config.php');

$summary = $_POST['summary'];


$insert = $conn->query("INSERT INTO checkout(summary) VALUES('$summary')");
if ($insert) {
    echo "Success";
}
$conn->close();
return;

?>