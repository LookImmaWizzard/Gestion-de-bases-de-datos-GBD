-- ISMAEL CARRASCO CUBERO
-- MySQL dump 10.13  Distrib 8.0.3-rc, for Win64 (x86_64)
--
-- Host: localhost    Database: billy_viajes_InnoDB
-- ------------------------------------------------------
-- Server version	8.0.3-rc-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `billy_viajes_InnoDB`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `billy_viajes_InnoDB` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `billy_viajes_InnoDB`;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `categoria` (
  `codcate` char(5) NOT NULL,
  `nombre` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`codcate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES ('ASIA','Asia'),('CRUC','Crucero'),('EURO','Europa'),('LATI','Latinoamérica'),('SAFA','Safari');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `cliente` (
  `nif` char(9) NOT NULL,
  `nombre` varchar(35) NOT NULL,
  `email` varchar(30) NOT NULL,
  `fecha_alta` date DEFAULT NULL,
  `puntos` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`nif`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES ('10101010X','pruebasX','pruebasx@gmail.com','2016-01-20',0),('20202020y','pruebasY','pruebasy@gmail.com','2017-11-10',0),('23727319S','Belén Sánchez Pardo','bsp@gmail.com','2020-02-24',100),('43229482E','Ana Moreno López','aml@gmail.com','2019-03-15',50),('62877137F','Eva Luque Martínez','elm@gmail.com','2010-04-20',20),('74381725T','Francisco Ojeda Rodríguez','for@gmail.com','2022-06-24',30);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mayorista`
--

DROP TABLE IF EXISTS `mayorista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `mayorista` (
  `codmay` char(4) NOT NULL,
  `nombre` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`codmay`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mayorista`
--

LOCK TABLES `mayorista` WRITE;
/*!40000 ALTER TABLE `mayorista` DISABLE KEYS */;
INSERT INTO `mayorista` VALUES ('CLA','Claratours'),('MEN','Mentetours'),('PIK','Piki Cruceros'),('SAK','Saki Cruceros'),('SOL','Soltours');
/*!40000 ALTER TABLE `mayorista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserva`
--

DROP TABLE IF EXISTS `reserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `reserva` (
  `id` int(11) NOT NULL,
  `nif` char(9) NOT NULL,
  `cod_viaje` int(11) NOT NULL,
  `fecha_reserva` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserva`
--

LOCK TABLES `reserva` WRITE;
/*!40000 ALTER TABLE `reserva` DISABLE KEYS */;
INSERT INTO `reserva` VALUES (1,'62877137F',4,'2023-02-02'),(2,'23727319S',7,'2023-03-03'),(3,'74381725T',10,'2023-03-05'),(4,'62877137F',13,'2023-03-05');
/*!40000 ALTER TABLE `reserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `viaje`
--

DROP TABLE IF EXISTS `viaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `viaje` (
  `codvia` int(11) NOT NULL,
  `nombre` varchar(60) NOT NULL,
  `mayori` char(4) NOT NULL,
  `catego` char(5) NOT NULL,
  `fecha_salida` date NOT NULL,
  `plazas` smallint(6) DEFAULT '0',
  `ocupadas` smallint(6) DEFAULT '0',
  PRIMARY KEY (`codvia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `viaje`
--

LOCK TABLES `viaje` WRITE;
/*!40000 ALTER TABLE `viaje` DISABLE KEYS */;
INSERT INTO `viaje` VALUES (1,'Islas Baleares','CLA','EURO','2023-07-03',2,0),(2,'China','CLA','ASIA','2023-07-13',1,0),(3,'Vietnam ','MEN','ASIA','2023-08-05',3,0),(4,'Islas griegas','SAK','CRUC','2023-07-05',2,1),(5,'Fiordos Noruegos','PIK','CRUC','2023-07-01',2,0),(6,'Cataratas Iguazu','SOL','LATI','2023-08-15',2,0),(7,'Patagonia','CLA','LATI','2023-12-15',1,1),(8,'Yucatán','SOL','LATI','2023-07-16',1,0),(9,'Italia','CLA','EURO','2023-07-25',1,0),(10,'Inglaterra','CLA','EURO','2023-08-03',2,1),(11,'Costa Rica','CLA','LATI','2023-08-10',1,0),(12,'Francia','MEN','EURO','2023-08-01',2,0),(13,'Alemania','CLA','EURO','2023-08-10',1,1);
/*!40000 ALTER TABLE `viaje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'billy_viajes_InnoDB'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-03 13:17:06
