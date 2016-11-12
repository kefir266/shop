<?php

/**
 * Created by PhpStorm.
 * User: dmitrij
 * Date: 09.11.2016
 * Time: 20:16
 */
class Categories extends DB_Conector
{

    private function _getTree($allElements = null) {

        if ($allElements == null) return [];
        $tree = [];
        $references = [];
        $firstLevel = true;
        foreach ( $allElements as $id => $item ){

            $node[$id] = $item;

            $references[$node[$id]['id']] = &$node[$id];
            $node['items'] = [];//items equal children
            $node['label'] = $node[$id]['title'];
            if (is_null($node[$id]['parent_id']) || $firstLevel)
            {
                $tree[$node[$id]['id']] = &$node[$id];
                $firstLevel = false;
//                $node[$id]['url'] = 'controler/';
            }
            else
            {

                $references[$node[$id]['parent_id']]['items'][$node[$id]['id']] = &$node[$id];

            }
            $node[$id]['url'] = '?categoryid=' . $node[$id]['id'];
        }

        return $tree;
    }

    public function doQuery($query){
        return parent::query($query);
    }

    public function getMenu($category_id = null){

        $query = 'select id, title, parent_id, level FROM categories ';

        if (!$category_id == null) {
            $query .= ' WHERE id = '.$category_id.
                    ' OR parent_id = '.$category_id;
        }
        $query .= ' ORDER BY level';

        $tree = $this->_getTree( $this->doQuery($query));
        return $tree;
    }

    public function getTitle($category_id = null){

        if ($category_id == null) return "Все товары";

        $query = 'select title FROM categories where id = '.$category_id;

        return $this->doQuery($query)->fetch_assoc()['title'];

    }

}