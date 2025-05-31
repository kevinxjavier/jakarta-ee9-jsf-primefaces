-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: kevin.cx    Database: enterprise
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Deporte'),(2,'Tecnologia'),(3,'Computacion');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `date` date DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `sku` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sku_unique` (`sku`),
  KEY `product_category_idx` (`category_id`),
  CONSTRAINT `product_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'TV Samsung TH581',668.99,'2023-05-28',2,'abcde12345'),(2,'Raspberry Pi 4 8GB',89.56,'2023-05-28',2,'abcdf12345'),(3,'gloves',12,'2024-10-06',1,'2345523422'),(4,'table tennis',147,'2024-10-06',1,'14154123'),(5,'socker ball',34,'2024-11-26',1,'39887689'),(6,'CPU Intel',345,'2024-10-12',3,'23521243'),(8,'Test1',234,'2025-06-04',3,'234sad'),(9,'Java Course',65,'2025-05-05',3,'125dd');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_test`
--

DROP TABLE IF EXISTS `product_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_test` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `date` date DEFAULT NULL,
  `sku` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sku_unique` (`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_test`
--

LOCK TABLES `product_test` WRITE;
/*!40000 ALTER TABLE `product_test` DISABLE KEYS */;
INSERT INTO `product_test` VALUES (5,'gulf stick',12,'2038-12-15','2342asda'),(8,'Cachopo',13.43,'2025-05-01','9000comi'),(9,'halisko',13.2,'2025-05-01','2342');
/*!40000 ALTER TABLE `product_test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(36) DEFAULT NULL,
  `password` varchar(36) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'kevin','123456','kevin@gmail.com'),(2,'javier','456783','javier@gmail.com'),(3,'pina','098765','pina@gmail.com');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK6dotkott2kjsp8vw4d0m25fb7` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'2024-10-14 17:31:01.929000','kpina@gmail.com','Kevin Piña','$2a$10$qE93UdTsZI97PKb8n/jUUO3jLg7m5ZeO2OLCyjcKHHGbCdG244BFG','2024-10-14 17:31:01.929000'),(252,'2024-10-14 20:38:45.585000','kpina1@gmail.com','Kevin Piña','$2a$10$BYdHjfZP7VDhZMeRphyHWuMXvGm1ZUN7cljgglkNClrwsdMZGVsCq','2024-10-14 20:38:45.585000'),(255,'2024-10-14 20:41:23.852000','kpina2@gmail.com','Kevin Piña','$2a$10$pAKiXVmE0sXO1qEiKSx2uOUWexXt.8OsRmLHioZe9ZLJNbFa/lIWu','2024-10-14 20:41:23.852000'),(257,'2024-10-14 20:41:46.739000','kpina3@gmail.com','Kevin Piña','$2a$10$E.CkEIKMrKfkBnkUQMC7u.uwNJnjMvVpU9dAXQX7gcujAtuiD6aVq','2024-10-14 20:41:46.739000'),(265,'2024-10-14 20:48:02.681000','kpina4@gmail.com','Kevin Piña','$2a$10$V6rPB.WdYf/GtJVxW78r2.w3P1WgLLYTtBS31tROl25agoHt96ENi','2024-10-14 20:48:02.681000'),(267,'2024-10-14 20:52:56.965000','kpina5@gmail.com','Kevin Piña','$2a$10$oXQ.NXYvx/fI0xQ.Vw0EwO4hxxXVzmgh/xWOPUBGQIgV8bPLqByUi','2024-10-14 20:52:56.965000');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_seq`
--

DROP TABLE IF EXISTS `users_seq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_seq` (
  `next_val` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_seq`
--

LOCK TABLES `users_seq` WRITE;
/*!40000 ALTER TABLE `users_seq` DISABLE KEYS */;
INSERT INTO `users_seq` VALUES (351);
/*!40000 ALTER TABLE `users_seq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'enterprise'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-06 23:09:20
