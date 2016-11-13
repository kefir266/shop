<?php

/**
 * Created by PhpStorm.
 * User: dmitrij
 * Date: 09.11.2016
 * Time: 20:17
 */
class DB_Conector
{
    static private $log_file;
    static private $fd;
    static private $_db_connector;

    public function __construct()
    {
        if (session_status() == PHP_SESSION_NONE) {
            session_start();
        }
        self::$log_file = $_SERVER['DOCUMENT_ROOT']."/log/db.log";

        self::$_db_connector = mysqli_connect(
                $_SESSION['setings']['host'],
                $_SESSION['setings']['db_user'],
                $_SESSION['setings']['db_password'],
                $_SESSION['setings']['database']
        );
        if (self::$_db_connector->errno){
            $err = 'Connection refused '.self::$_db_connector->connect_error;
            echo $err;
            $this->writeLog($err);
        }
	self::$_db_connector->query("SET NAMES 'utf8");
	self::$_db_connector->query("SET CHARACTER SET 'utf8'");

    }

    public function __destruct()
    {
        //self::$_db_connector->close();
        //fclose(self::fd);
    }

    public function query($query){
        $result = null;
        if (!($result = self::$_db_connector->query($query)))
            echo 'Query error! '.$query;
        return $result;
    }

    public function writeLog($log){
        self::$fd =fopen(self::$log_file,"a+");
        fprintf(self::$fd,'%s\n',$log);


    }
}
