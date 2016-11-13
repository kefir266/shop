<?php
/**
 * Created by PhpStorm.
 * User: dmitrij
 * Date: 12.11.2016
 * Time: 15:24
 */

require_once($_SERVER['DOCUMENT_ROOT']."/model/Order.php");

if ($itemId = $_POST['order']) {
    if (session_status() == PHP_SESSION_NONE) {
        session_start();
    }

    //print_r ("200");
    $order = $_POST['order'];

    $appOrder = new Order();

    if ($appOrder->insertOrder($order)) {

        $_SESSION['cartGoods'] = [];
        echo "1";
    } else {
        echo "0";
    }
    exit;
}