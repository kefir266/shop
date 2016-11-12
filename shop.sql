-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               5.5.48 - MySQL Community Server (GPL)
-- ОС Сервера:                   Win32
-- HeidiSQL Версия:              9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Дамп структуры базы данных shop
CREATE DATABASE IF NOT EXISTS `shop` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `shop`;


-- Дамп структуры для таблица shop.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `level` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_categories_categories` (`parent_id`),
  CONSTRAINT `FK_categories_categories` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы shop.categories: ~5 rows (приблизительно)
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` (`id`, `title`, `parent_id`, `level`) VALUES
	(1, 'Электроника', NULL, 0),
	(2, 'Смартфоны', 1, 1),
	(3, 'Одежда', NULL, 0),
	(4, 'Рубашки', 3, 1),
	(5, 'Гаджеты', 1, 1);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;


-- Дамп структуры для таблица shop.goods
CREATE TABLE IF NOT EXISTS `goods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `category_id` int(10) unsigned NOT NULL DEFAULT '0',
  `description` text,
  `image` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_goods_categories` (`category_id`),
  CONSTRAINT `FK_goods_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы shop.goods: ~2 rows (приблизительно)
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
INSERT INTO `goods` (`id`, `title`, `category_id`, `description`, `image`) VALUES
	(1, 'Samsung galaxy s3', 2, 'Самый супер-пупер телефон', '2.jpg'),
	(2, 'Samsung galaxy s4', 2, 'Ниче так телефончик', '3.jpg');
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;


-- Дамп структуры для таблица shop.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `count` int(10) unsigned NOT NULL,
  `price` decimal(10,2) unsigned NOT NULL,
  `sum` decimal(12,2) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_orders_goods` (`product_id`),
  KEY `FK_orders_users` (`user_id`),
  CONSTRAINT `FK_orders_goods` FOREIGN KEY (`product_id`) REFERENCES `goods` (`id`),
  CONSTRAINT `FK_orders_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы shop.orders: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` (`id`, `product_id`, `count`, `price`, `sum`, `user_id`) VALUES
	(3, 2, 3, 20000.00, 60000.00, 1),
	(4, 2, 3, 20000.00, 60000.00, 1),
	(5, 2, 3, 20000.00, 60000.00, 1),
	(6, 2, 1, 20000.00, 20000.00, 1),
	(7, 2, 10, 20000.00, 200000.00, 1),
	(8, 2, 2, 20000.00, 40000.00, 1),
	(9, 1, 3, 10000.00, 30000.00, 1),
	(10, 2, 4, 20000.00, 80000.00, 1),
	(11, 1, 5, 10000.00, 50000.00, 1),
	(12, 2, 3, 20000.00, 60000.00, 1),
	(13, 1, 5, 10000.00, 50000.00, 1),
	(14, 2, 6, 20000.00, 120000.00, 1),
	(15, 1, 4, 10000.00, 40000.00, 1),
	(16, 2, 1, 20000.00, 20000.00, 1);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;


-- Дамп структуры для таблица shop.price
CREATE TABLE IF NOT EXISTS `price` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `type_price_id` int(10) unsigned NOT NULL,
  `price` decimal(10,2) unsigned NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_price_type_price` (`type_price_id`),
  KEY `FK_price_goods` (`product_id`),
  CONSTRAINT `FK_price_goods` FOREIGN KEY (`product_id`) REFERENCES `goods` (`id`),
  CONSTRAINT `FK_price_type_price` FOREIGN KEY (`type_price_id`) REFERENCES `type_price` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы shop.price: ~2 rows (приблизительно)
/*!40000 ALTER TABLE `price` DISABLE KEYS */;
INSERT INTO `price` (`id`, `product_id`, `type_price_id`, `price`, `date`) VALUES
	(1, 1, 1, 10000.00, '2016-01-11'),
	(2, 2, 1, 20000.00, '2016-01-11');
/*!40000 ALTER TABLE `price` ENABLE KEYS */;


-- Дамп структуры для таблица shop.specs
CREATE TABLE IF NOT EXISTS `specs` (
  `product_id` int(10) unsigned NOT NULL,
  `long` int(10) unsigned NOT NULL,
  `width` int(10) unsigned NOT NULL,
  `high` int(10) unsigned NOT NULL,
  `color` varchar(50) NOT NULL,
  `wight` int(10) NOT NULL,
  KEY `FK__goods` (`product_id`),
  CONSTRAINT `FK__goods` FOREIGN KEY (`product_id`) REFERENCES `goods` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Дамп данных таблицы shop.specs: ~1 rows (приблизительно)
/*!40000 ALTER TABLE `specs` DISABLE KEYS */;
INSERT INTO `specs` (`product_id`, `long`, `width`, `high`, `color`, `wight`) VALUES
	(1, 200, 80, 6, 'blue', 100);
/*!40000 ALTER TABLE `specs` ENABLE KEYS */;


-- Дамп структуры для таблица shop.type_price
CREATE TABLE IF NOT EXISTS `type_price` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы shop.type_price: ~1 rows (приблизительно)
/*!40000 ALTER TABLE `type_price` DISABLE KEYS */;
INSERT INTO `type_price` (`id`, `title`) VALUES
	(1, 'Retail');
/*!40000 ALTER TABLE `type_price` ENABLE KEYS */;


-- Дамп структуры для таблица shop.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы shop.users: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `email`, `phone`) VALUES
	(1, 'kefir', 'kefir266@yahoo.com', '0996407622');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
