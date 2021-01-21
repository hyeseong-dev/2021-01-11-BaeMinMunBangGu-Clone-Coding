-- MySQL dump 10.13  Distrib 8.0.22, for Linux (x86_64)
--
-- Host: localhost    Database: baemin_store
-- ------------------------------------------------------
-- Server version	8.0.22-0ubuntu0.20.04.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addresses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `receiver` varchar(45) NOT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `addresses_user_id_d930d1dc_fk_users_id` (`user_id`),
  CONSTRAINT `addresses_user_id_d930d1dc_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
INSERT INTO `addresses` VALUES (1,'서울 성북구','한동근',1),(2,'서울 성북구','한동근',1);
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'문구'),(2,'태형 리빙'),(3,'병진 책'),(4,'을지로에디션'),(5,'혜성 에디션'),(6,'지원이 친구들'),(7,'동하 세트'),(8,'싸닥코라보레이션');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupons`
--

DROP TABLE IF EXISTS `coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `min_ammount` decimal(18,2) NOT NULL,
  `coupon_rate` decimal(3,2) NOT NULL,
  `name` varchar(45) NOT NULL,
  `create_at` date NOT NULL,
  `update_at` date NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `coupons_user_id_bee5d0f0_fk_users_id` (`user_id`),
  CONSTRAINT `coupons_user_id_bee5d0f0_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupons`
--

LOCK TABLES `coupons` WRITE;
/*!40000 ALTER TABLE `coupons` DISABLE KEYS */;
/*!40000 ALTER TABLE `coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detail_images`
--

DROP TABLE IF EXISTS `detail_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detail_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `detail_url` varchar(45) NOT NULL,
  `image_flow` int NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `detail_images_product_id_53152187_fk_products_id` (`product_id`),
  CONSTRAINT `detail_images_product_id_53152187_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detail_images`
--

LOCK TABLES `detail_images` WRITE;
/*!40000 ALTER TABLE `detail_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `detail_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'contenttypes','contenttype'),(19,'order','order'),(20,'order','orderitem'),(21,'order','orderstatus'),(6,'product','category'),(7,'product','detailimage'),(8,'product','hashtag'),(9,'product','like'),(10,'product','product'),(11,'product','producthashtag'),(12,'product','productsale'),(13,'product','producttag'),(14,'product','review'),(18,'product','reviewimage'),(15,'product','sale'),(17,'product','stock'),(16,'product','tag'),(2,'sessions','session'),(5,'user','address'),(4,'user','coupon'),(3,'user','user');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2021-01-20 11:50:15.561854'),(2,'contenttypes','0002_remove_content_type_name','2021-01-20 11:50:15.715302'),(3,'product','0001_initial','2021-01-20 11:50:16.377278'),(4,'user','0001_initial','2021-01-20 11:50:16.825800'),(5,'order','0001_initial','2021-01-20 11:50:17.150933'),(6,'order','0002_auto_20210120_2050','2021-01-20 11:50:17.918843'),(7,'product','0002_auto_20210120_2050','2021-01-20 11:50:19.334946'),(8,'sessions','0001_initial','2021-01-20 11:50:19.390959'),(9,'order','0003_auto_20210121_0939','2021-01-21 00:39:53.519656'),(10,'order','0004_order_order_number','2021-01-21 01:05:35.099395'),(11,'order','0005_remove_order_order_number','2021-01-21 01:09:13.084359'),(12,'order','0006_auto_20210121_1026','2021-01-21 01:26:22.055071');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hash_tags`
--

DROP TABLE IF EXISTS `hash_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hash_tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hash_tags`
--

LOCK TABLES `hash_tags` WRITE;
/*!40000 ALTER TABLE `hash_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `hash_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `liked` tinyint(1) NOT NULL,
  `product_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `likes_product_id_7f73cfa5_fk_products_id` (`product_id`),
  KEY `likes_user_id_0899754c_fk_users_id` (`user_id`),
  CONSTRAINT `likes_product_id_7f73cfa5_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `likes_user_id_0899754c_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quantity` int NOT NULL,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_items_order_id_412ad78b_fk_orders_id` (`order_id`),
  KEY `order_items_product_id_dd557d5a_fk_products_id` (`product_id`),
  CONSTRAINT `order_items_order_id_412ad78b_fk_orders_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `order_items_product_id_dd557d5a_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_status`
--

DROP TABLE IF EXISTS `order_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_status`
--

LOCK TABLES `order_status` WRITE;
/*!40000 ALTER TABLE `order_status` DISABLE KEYS */;
INSERT INTO `order_status` VALUES (1,'입금대기'),(2,'결제완료'),(3,'상품준비중'),(4,'배송중'),(5,'배송완료'),(6,'구매확정');
/*!40000 ALTER TABLE `order_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_at` date NOT NULL,
  `order_status` tinyint(1) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_user_id_7e2523fb_fk_users_id` (`user_id`),
  CONSTRAINT `orders_user_id_7e2523fb_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_hash_tags`
--

DROP TABLE IF EXISTS `product_hash_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_hash_tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `hashtag_id` int NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_hash_tags_hashtag_id_3bc15453_fk_hash_tags_id` (`hashtag_id`),
  KEY `product_hash_tags_product_id_b398775c_fk_products_id` (`product_id`),
  CONSTRAINT `product_hash_tags_hashtag_id_3bc15453_fk_hash_tags_id` FOREIGN KEY (`hashtag_id`) REFERENCES `hash_tags` (`id`),
  CONSTRAINT `product_hash_tags_product_id_b398775c_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_hash_tags`
--

LOCK TABLES `product_hash_tags` WRITE;
/*!40000 ALTER TABLE `product_hash_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_hash_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_sales`
--

DROP TABLE IF EXISTS `product_sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_sales` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_sale` tinyint(1) NOT NULL,
  `product_id` int NOT NULL,
  `sale_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_sales_product_id_2f5d7c0e_fk_products_id` (`product_id`),
  KEY `product_sales_sale_id_5091f5d1_fk_sales_id` (`sale_id`),
  CONSTRAINT `product_sales_product_id_2f5d7c0e_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `product_sales_sale_id_5091f5d1_fk_sales_id` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_sales`
--

LOCK TABLES `product_sales` WRITE;
/*!40000 ALTER TABLE `product_sales` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_tags`
--

DROP TABLE IF EXISTS `product_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_tags_product_id_138ace6f_fk_products_id` (`product_id`),
  KEY `product_tags_tag_id_dd3a8625_fk_tags_id` (`tag_id`),
  CONSTRAINT `product_tags_product_id_138ace6f_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `product_tags_tag_id_dd3a8625_fk_tags_id` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_tags`
--

LOCK TABLES `product_tags` WRITE;
/*!40000 ALTER TABLE `product_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `main_image` varchar(2000) NOT NULL,
  `price` decimal(18,2) NOT NULL,
  `money_replace` varchar(45) NOT NULL,
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `products_category_id_a7a3a156_fk_categories_id` (`category_id`),
  CONSTRAINT `products_category_id_a7a3a156_fk_categories_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'종이 노트','https://images.unsplash.com/photo-1518226203301-8e7f833c6a94?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8bm90ZSUyMHBhZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',3500.00,'이번껀 다써보자','2021-01-16 02:51:25.456315','2021-01-16 02:51:25.457294',1),(2,'2021 다이어리','https://images.unsplash.com/photo-1568150279679-d16bc9eb9eb1?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NXx8ZGlhcnl8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',20000.00,'이번년껀 다써보자','2021-01-16 03:07:13.860622','2021-01-16 03:07:13.860713',1),(3,'2021 agenda. 연휴일 파악용','https://images.unsplash.com/photo-1529651737248-dad5e287768e?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8NHwzNDgzMDQ1fHxlbnwwfHx8&auto=format&fit=crop&w=500&q=60',13860.00,'연휴일 파악용','2021-01-16 03:07:14.860622','2021-01-16 03:07:14.860713',1),(4,'롤 스티커. 저 투표했습니다.','https://images.unsplash.com/photo-1540908187087-eeabb5040af5?ixid=MXwxMjA3fDB8MHxzZWFyY2h8N3x8cGFwZXIlMjB0YXBlfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',4500.00,'두근두근','2021-01-16 03:07:15.860622','2021-01-16 03:07:15.860713',1),(5,'무소유 키보드','https://images.unsplash.com/photo-1541140532154-b024d705b90a?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8a2V5Ym9hcmR8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',23000.00,'무소음...','2021-01-16 03:07:43.860622','2021-01-16 03:07:44.860622',1),(6,'뻬이빠 파일','https://images.unsplash.com/photo-1547320945-78d7e6eb7f21?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',1500.00,'아 보람차다','2021-01-16 03:07:17.860622','2021-01-16 03:07:22.860713',1),(7,'빨간 저가 핸드백','https://images.unsplash.com/photo-1581067721837-e4809b29692d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8c2hvcHBpbmclMjBiYWd8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',2300.00,'종이뷔똥','2021-01-16 03:07:18.860622','2021-01-16 03:07:21.860713',1),(8,'세련된 볼펜','https://images.unsplash.com/photo-1583485088034-697b5bc54ccd?ixid=MXwxMjA3fDB8MHxzZWFyY2h8OHx8cGVufGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',3500.00,'이번껀 잃어버리지 말자','2021-01-16 03:07:19.860622','2021-01-16 03:07:20.860713',1),(9,'뭐가 들었을지 기대되는 봉투','https://images.unsplash.com/photo-1567794636765-5e4869f627e1?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTd8fGVudmVsb3BlfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',2500.00,'두둑히 넣었어요','2021-01-16 03:07:20.860622','2021-01-16 03:07:23.860713',1),(10,'데이터 넣으면 사라지는 USB','https://images.unsplash.com/photo-1587145820098-23e484e69816?ixid=MXwxMjA3fDB8MHxzZWFyY2h8M3x8dXNifGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',8900.00,'분명히 넣었는데?','2021-01-16 03:07:21.860622','2021-01-16 03:07:24.860713',1),(11,'쓰는 것보다 깎는게 재밌는 연필','https://images.unsplash.com/photo-1516962215378-7fa2e137ae93?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxzZWFyY2h8NXx8cGVuY2lsfGVufDB8fDB8&auto=format&fit=crop&w=500&q=60',800.00,'뾰족해야 마음편한','2021-01-16 03:07:22.860622','2021-01-16 03:07:25.860713',1),(12,'\'전화 오셨다고 전해드릴께요~\' 때 쓰는 포스트잇','https://images.unsplash.com/photo-1587145820137-a9dbc8c5ed99?ixid=MXwxMjA3fDB8MHxzZWFyY2h8OHx8cG9zdCUyMGl0fGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',1400.00,'자리에 메모 남겨드렸어요~','2021-01-16 03:07:23.860622','2021-01-16 03:07:26.860713',1),(13,'호치케스','https://images.unsplash.com/photo-1541690161184-75cbc0386cd6?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Nnx8c3RhcGxlcnxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',9500.00,'스테이플러말고 호치케스 없어?','2021-01-16 03:07:24.860622','2021-01-16 03:07:27.860713',1),(14,'많으면 마음 편한 페이퍼 클립','https://images.unsplash.com/photo-1512278753435-c834ff8a597a?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTN8fHN0YXRpb25lcnl8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',6000.00,'책상 이곳저곳','2021-01-16 03:07:25.860622','2021-01-16 03:07:28.860713',1),(15,'인생은 실전이야 연간 플래너','https://images.unsplash.com/photo-1541140911322-98afe66ea6da?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxzZWFyY2h8NjF8fHN0YXRpb25lcnl8ZW58MHx8MHw%3D&auto=format&fit=crop&w=500&q=60',20000.00,'계획대로 되고 있어','2021-01-16 03:07:26.860622','2021-01-16 03:07:28.860713',1),(16,'소맥 몰래 마시기 좋은 텀블러','https://images.unsplash.com/photo-1596947210006-502f0b24b74c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',18000.00,'알코올 없이 버티기 힘들어','2021-01-16 03:07:27.860622','2021-01-16 03:07:29.860713',2),(17,'맥주 디이어트용 맥주','https://images.unsplash.com/photo-1558642891-54be180ea339?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NXx8YmVlcnxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',8000.00,'맥주는 살안쪄','2021-01-16 03:07:28.860622','2021-01-16 03:07:30.860713',2),(18,'뽀송뽀송 타올','https://images.unsplash.com/photo-1496890185067-72d7d9af66b1?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTEyfHx0b3dlbHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',7800.00,'쉰내 안나게 잘 빨기','2021-01-16 03:07:29.860622','2021-01-16 03:07:31.860713',2),(19,'감기 조심하세요 꽉 티슈','https://images.unsplash.com/photo-1607516531499-9e57ef94a9d9?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTB8fHRpc3N1ZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',3900.00,'훌쩍 훌쩍','2021-01-16 03:07:30.860622','2021-01-16 03:07:32.860713',2),(20,'소개팅용 양말','https://images.unsplash.com/photo-1597843797221-e34b4a320b97?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8c29ja3xlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',7800.00,'패완양','2021-01-16 03:07:31.860622','2021-01-16 03:07:33.860713',2),(21,'2번 세탁하면 꽉끼는 티셔츠','https://images.unsplash.com/photo-1600744372870-ef7e77be6857?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NDR8fHdoaXRlJTIwdHNoaXJ0fGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',4000.00,'넉넉한 사이즈로 사세요','2021-01-16 03:07:32.860622','2021-01-16 03:07:34.860713',2),(22,'정글 에코 백','https://images.unsplash.com/photo-1572196284554-4e321b0e7e0b?ixid=MXwxMjA3fDB8MHxzZWFyY2h8OXx8YmFnfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',8000.00,'시공간 붕괴','2021-01-16 03:07:32.860622','2021-01-16 03:07:34.860713',2),(23,'치카치카 칫솔','https://images.unsplash.com/photo-1593240829601-4ee2567bb205?ixid=MXwxMjA3fDB8MHxzZWFyY2h8M3x8dG9vdGhicnVzaHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',2900.00,'이빨 닦고 자세요','2021-01-16 03:07:33.860622','2021-01-16 03:07:35.860713',2),(24,'민초 맛 치약','https://images.unsplash.com/photo-1582320896315-927ea1abda8d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NDR8fHRvb3RocGFzdGV8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',4900.00,'치약맛 민초?','2021-01-16 03:07:34.860622','2021-01-16 03:07:36.860713',2),(25,'너무나 비싼 면도기','https://images.unsplash.com/photo-1559715544-33be62554de3?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTd8fHNoYXZlfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',7900.00,'면도날 3~4만원 ㅜㅜ','2021-01-16 03:07:36.860622','2021-01-16 03:07:37.860713',2),(26,'로션','https://images.unsplash.com/photo-1585232350744-974fc9804d65?ixid=MXwxMjA3fDB8MHxzZWFyY2h8M3x8bG90aW9ufGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',8000.00,'부드럽다','2021-01-16 03:07:35.860622','2021-01-16 03:07:36.860713',2),(27,'A4용지','https://images.unsplash.com/photo-1573978828027-e830975e272c?ixid=MXwxMjA3fDB8MHxzZWFyY2h8M3x8YTQlMjBwYXBlcnxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',14000.00,'복사용지','2021-01-16 03:07:37.860622','2021-01-16 03:07:38.860713',1),(28,'폰케이스 iphone','https://images.unsplash.com/photo-1581003989504-3e6ba26df4a2?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8cGhvbmUlMjBjYXNlfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',12000.00,'아이폰 케이스','2021-01-16 03:07:38.860622','2021-01-16 03:07:39.860713',2),(29,'폰케이스 galaxy','https://images.unsplash.com/photo-1583039965214-222f9f1f32f6?ixid=MXwxMjA3fDB8MHxzZWFyY2h8M3x8Z2FsYXh5JTIwY2FzZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',12000.00,'갤럭시 케이스','2021-01-16 03:07:39.860622','2021-01-16 03:07:40.860713',2),(30,'커플 머그 컵','https://images.unsplash.com/photo-1542556398-95fb5b9f9b48?ixid=MXwxMjA3fDB8MHxzZWFyY2h8M3x8Y3VwfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',9000.00,'커피 머그','2021-01-16 03:07:40.860622','2021-01-16 03:07:41.860713',2),(31,'도자기 밥그릇','https://images.unsplash.com/photo-1600676626897-eb2fb18a21e0?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MjN8fHJpY2UlMjBib3dsfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',15000.00,'청색 밥그릇','2021-01-16 03:07:41.860622','2021-01-16 03:07:42.860713',2),(32,'나무 젓가락','https://images.unsplash.com/photo-1599569958048-2051d3f9a3e9?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MjF8fGNob3BzdGlja3N8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',7900.00,'밥잘먹나요','2021-01-16 03:07:42.860622','2021-01-16 03:07:43.860713',2);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_images`
--

DROP TABLE IF EXISTS `review_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `image_url` varchar(2048) NOT NULL,
  `review_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `review_images_review_id_9c7a1455_fk_reviews_id` (`review_id`),
  CONSTRAINT `review_images_review_id_9c7a1455_fk_reviews_id` FOREIGN KEY (`review_id`) REFERENCES `reviews` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_images`
--

LOCK TABLES `review_images` WRITE;
/*!40000 ALTER TABLE `review_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` longtext NOT NULL,
  `create_at` date NOT NULL,
  `update_at` date NOT NULL,
  `product_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `reviews_product_id_d4b78cfe_fk_products_id` (`product_id`),
  KEY `reviews_user_id_c23b0903_fk_users_id` (`user_id`),
  CONSTRAINT `reviews_product_id_d4b78cfe_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `reviews_user_id_c23b0903_fk_users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sales_rate` decimal(3,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stocks`
--

DROP TABLE IF EXISTS `stocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stocks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quantity` int NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `stocks_product_id_f5a06e7d_fk_products_id` (`product_id`),
  CONSTRAINT `stocks_product_id_f5a06e7d_fk_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stocks`
--

LOCK TABLES `stocks` WRITE;
/*!40000 ALTER TABLE `stocks` DISABLE KEYS */;
INSERT INTO `stocks` VALUES (1,30,1),(2,31,2),(3,50,3),(4,20,4),(5,10,5),(6,15,6),(7,25,7),(8,99,8),(9,11,9),(10,201,10),(11,0,11),(12,0,12),(13,1,13),(14,111,14),(15,334,15),(16,23,16),(17,17,17),(18,29,18),(19,33,19),(20,41,20),(21,59,21),(22,47,22),(23,52,23),(24,43,24),(25,16,25),(26,64,26),(27,0,27),(28,12,28),(29,198,29),(30,93,30),(31,72,31),(32,7,32);
/*!40000 ALTER TABLE `stocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'HOT'),(2,'NEW'),(3,'SALE');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account` varchar(45) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(45) NOT NULL,
  `phone` varchar(11) NOT NULL,
  `create_at` date NOT NULL,
  `update_at` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'baemin','$2b$12$VbBe4WSs4R0d50d1CNw0UOyz.aig/HchGkHwx4c2KGLJfZT0U318S','배민구','sssss@naver.com','01011111111','2021-01-15','2021-01-15'),(2,'incred1ble','$2b$12$3vqI6BhJyYcAvSAhKY1DAO0kpyhJErWxLqe8qq8zzCfqMn62SQZ4K','김태형','zxho25@naver.com','01041368349','2021-01-15','2021-01-15'),(3,'ssadak','$2b$12$eF/nboMsrsrnRJC1bE0j3.pqed.u/uAp/z5ahAjqgwaaiRhhV/.jG','싸닥코','ssadak@naver.com','01099561994','2021-01-15','2021-01-15'),(4,'dyrkd7273','$2b$12$6LwbRUL6RJAIUeta.hY5S.STR638YJCnIIz5pOV5M6nfdHVPkEOFy','김태진','meco35@naver.com','01050901380','2021-01-17','2021-01-17'),(5,'dyek72731','$2b$12$TQ.rxIJkuMTkxeBzvwChmOfVZMmsyT4TY7y3IHRZ86/zc1CfyiP..','김태환','zxho25@hanmail.net','01032932823','2021-01-17','2021-01-17'),(6,'zxho222','$2b$12$WpBQ50f150eQls1Apk3sz.ioJsjGgwilZaN/u4J5LB8bzhIN2.HYm','김태애형','zxh22o25@naver.com','01041468349','2021-01-17','2021-01-17');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-21 14:49:15
