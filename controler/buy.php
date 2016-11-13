<?php
/**
 * Created by PhpStorm.
 * User: dmitrij
 * Date: 11.11.2016
 * Time: 16:05
 */
//require ("model/Buy.php");

if ($itemId = $_POST['id']){

	if (session_status() == PHP_SESSION_NONE) {
        	session_start();
    	}	

    ++$_SESSION['cartGoods'][$itemId];

    echo array_sum($_SESSION['cartGoods']);
}
