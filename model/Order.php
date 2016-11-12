<?php

/**
 * Created by PhpStorm.
 * User: dmitrij
 * Date: 12.11.2016
 * Time: 18:13
 */

require_once($_SERVER['DOCUMENT_ROOT']."/model/DB_Connector.php");

class Order extends DB_Conector
{

    public function doQuery($query){
        return parent::query($query);
    }

    public function insertOrder($order){

        $query = "";

        foreach( $order as $id => $item) {
            //$this->writeLog(print_r($id,true)." ".print_r($item,true));
            $query = "INSERT INTO Orders (product_id, count, price, sum, user_id) VALUES (
                ".$item['id'].",
                ".$item['count'].",
                ".$item['price'].",
                ".$item['sum'].",
                1
                )
                ";

            //$this->writeLog(print_r($query,true));
            $this->doQuery($query);
        }

        return true;
    }

}