<?php

/**
 * Created by PhpStorm.
 * User: dmitrij
 * Date: 09.11.2016
 * Time: 16:20
 */
require ("DB_Connector.php");

class Goods extends DB_Conector
{


    public function doQuery($query){
        return parent::query($query);
    }



    public function getGoods($category_id = null){

        $query = 'select goods.id id,
                          goods.title title,
                           categories.title categoryTitle,
                            description,
                             image
                            FROM goods
                  INNER JOIN categories
                  ON goods.category_id = categories.id
                  INNER JOIN categories parent
                      ON categories.parent_id = parent.id
                  ';
        if (!$category_id == null) {
            $query .= ' WHERE category_id = '.$category_id.
            ' OR categories.parent_id = '.$category_id.
                ' OR parent.parent_id = '.$category_id;
        }
        //var_dump($query);

        return $this->doQuery($query);
    }

    public function getProductById($id){

        $query = 'select goods.id id,
                          goods.title title,
                            price.price
                            FROM goods
                  LEFT JOIN price
                  ON goods.id = price.product_id
                  AND price.type_price_id = \'1\'
                  WHERE goods.id ='.$id.'
                  ';
        return $this->doQuery($query)->fetch_assoc();
    }
}