<?php

/**
 * Created by PhpStorm.
 * User: dmitrij
 * Date: 08.11.2016
 * Time: 20:17
 */

require ("model/Goods.php");
require ("model/Categories.php");

class Main
{

    public $page;
    public $cartContent;

    public function __construct()
    {
        session_start();

    }

    public function countCart(){

        return array_sum($_SESSION['cartGoods']);
    }

    public function initSession(){

        session_set_cookie_params(3600,'/',$_SERVER['HTTP_HOST']);



        $_SESSION['cartGoods']=[];
    }

    public function index ($app = null){

        if (!isset($_SESSION['cartGoods'])) {
            $this->initSession();
        }

        $model = new Goods();
        $modelMenu = new Categories();

        $category_id = htmlspecialchars($_GET['categoryid']);
        $goods = $model->getGoods($category_id);
        //var_dump($goods);

        $goods = ($goods)?  $goods: [];
        $menu = $modelMenu->getMenu(/*$category_id*/);///ouput all menu
        $this->page = "showcase.html";
        $categoryTitle = $modelMenu->getTitle($category_id);

        if (is_null($_GET['controler']))
        {
            include("views/main.html");
        }
        else
        {
            $this->cartContent = $app->getCartContent();
            $this->page = $_GET['controler'].".html";
            include("views/main.html");
        }

    }

}