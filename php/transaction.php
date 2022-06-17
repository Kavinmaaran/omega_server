<?php

global $__site_config;
$__site_config = file_get_contents("/home/CEO/php".'/omegaconfig.json');

$user = $argv[1];
$amount = $argv[2];

function get_config($key, $default=null)
{
    global $__site_config;
    $array = json_decode($__site_config, true);
    if (isset($array[$key])) {
        return $array[$key];
    } else {
        return $default;
    }
}

class Database
{
    public static $conn=null;
    public static function getConnection()
    {
        if (Database::$conn==null) {
            $servername = get_config("db_server");
            $username = get_config("db_username");
            $password = get_config("db_password");
            $dbname = get_config("db_name");

            // Create connection
            $connection = new mysqli($servername, $username, $password, $dbname);
            // Check connection
            if ($connection->connect_error) {
                die("Connection failed: " . $connection->connect_error);
            } else {
                Database::$conn=$connection;
                return Database::$conn;
            }
        } else {
            return Database::$conn;
        }
    }
}

$sql = "INSERT INTO `Transaction_details` (`Account-number`, `Amount`, `Date`, `Time`) VALUES ('$user', '$amount', now(), now());";
$conn = Database::getConnection();
$error=false;
if ($conn->query($sql) === true) {
    $error=false;
} else {
    $error=$conn->connect_error;
}

