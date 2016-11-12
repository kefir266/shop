<?php
/**
 * Created by PhpStorm.
 * User: dmitrij
 * Date: 08.11.2016
 * Time: 19:46
 */

session_start();

require 'controler/Main.php';

$setings = ['title' => 'Интернет магазин',
            'host' => 'localhost',
            'database' => 'shop',
            'db_user' => 'kefir',
            'db_password' => 'kefir266'
            ];
$_SESSION['setings'] = $setings;

if (!$_GET['controler']) {

    $mainApp = new Main();
    $mainApp->index();
    }
else {

    switch ($_GET['controler']){
        case 'Cart':{
            require_once('controler/CartControler.php');
            $app = new CartControler();
            break;
        }

    }
    $mainApp = new Main();
    $mainApp->index($app);

}

?>