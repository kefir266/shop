<?php

/**
 * Created by PhpStorm.
 * User: dmitrij
 * Date: 11.11.2016
 * Time: 17:28
 */
require_once("model/Goods.php");


class CartControler
{

    public $page;
    public $cartContent;
    private $modelGoods;

    public function __construct()
    {
        session_start();
        $this->modelGoods = new Goods();
    }

    public function index()
    {
        //$this->cartContent = $_SESSION['cartGoods'];
        $this->page = "cart.html";


    }

    public function getCartContent(){
        $goods =[];
        foreach($_SESSION['cartGoods'] as $id => $item ){
            $goods[$id] = $this->modelGoods->getProductById($id);

            $goods[$id]['count'] = $item;
            $goods[$id]['sum'] = $item * (int) $goods[$id]['price'];

        }
        return $goods;
    }
}

?>