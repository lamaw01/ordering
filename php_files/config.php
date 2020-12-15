<?php

$hostname = 'localhost';
$username = 'root';
$pass = '';
$dbname = 'ordering';

$conn = new mysqli($hostname, $username, $pass, $dbname);

if ($conn->connect_errno) {

    die("Connection Failed: " . $conn->connect_errno);
    return;
}
