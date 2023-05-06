-- ISMAEL CARRASCO CUBERO
-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: billy_viajes_myisam
-- ------------------------------------------------------
-- Server version	8.0.3-rc-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `viaje`
--

DROP TABLE IF EXISTS `viaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `viaje` (
  `codvia` int(11) NOT NULL,
  `nombre` varchar(60) NOT NULL,
  `mayori` char(4) NOT NULL,
  `catego` char(5) NOT NULL,
  `fecha_salida` date NOT NULL,
  `plazas` smallint(6) DEFAULT '0',
  `ocupadas` smallint(6) DEFAULT '0',
  PRIMARY KEY (`codvia`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `viaje`
--

LOCK TABLES `viaje` WRITE;
/*!40000 ALTER TABLE `viaje` DISABLE KEYS */;
INSERT INTO `viaje` VALUES (1,'Islas Baleares','CLA','EURO','2023-07-03',2,0),(2,'China','CLA','ASIA','2023-07-13',1,0),(3,'Vietnam ','MEN','ASIA','2023-08-05',3,0),(4,'Islas griegas','SAK','CRUC','2023-07-05',2,1),(5,'Fiordos Noruegos','PIK','CRUC','2023-07-01',2,0),(6,'Cataratas Iguazu','SOL','LATI','2023-08-15',2,0),(7,'Patagonia','CLA','LATI','2023-12-15',1,1),(8,'Yucatán','SOL','LATI','2023-07-16',1,0),(9,'Italia','CLA','EURO','2023-07-25',1,0),(10,'Inglaterra','CLA','EURO','2023-08-03',2,1),(11,'Costa Rica','CLA','LATI','2023-08-10',1,0),(12,'Francia','MEN','EURO','2023-08-01',2,0),(13,'Alemania','CLA','EURO','2023-08-10',1,1);
/*!40000 ALTER TABLE `viaje` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-03 12:21:41
