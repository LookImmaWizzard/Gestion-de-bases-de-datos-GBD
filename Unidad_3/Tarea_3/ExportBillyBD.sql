/*
ISMAEL CARRASCO CUBERO

NOTA IMPORTANTE: MYSQL WORKBENCH EN WINDOWS, NO RESPETA EL CASE SENSITIVE DE MI BASE DE DATOS, POR LO QUE AL INTENTAR IMPORTAR LOS DATOS DEL SCRIPT GENERADO CON WORKBENCH EN WINDOWS, A MI BASE DE DATOS MYSQL EN LINUX, EL SCRIPT
DA ERRORES, DICIENDO QUE LAS TABLAS NO EXISTEN. EN TEORIA EN WORKBENCH DE WINDOWS DEBERIA DE FUNCIONAR.
*/

-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: billy
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Dumping data for table `adorno`
--

LOCK TABLES `adorno` WRITE;
/*!40000 ALTER TABLE `adorno` DISABLE KEYS */;
INSERT INTO `adorno` VALUES (5,'70kg'),(6,'3kg'),(7,'1kg'),(8,'2kg');
/*!40000 ALTER TABLE `adorno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `articulo`
--

LOCK TABLES `articulo` WRITE;
/*!40000 ALTER TABLE `articulo` DISABLE KEYS */;
INSERT INTO `articulo` VALUES (1,'42156365L','Rosa roja','2021-05-03',5.50),(2,'39886487F','Clavel blanco','2021-07-12',2.20),(3,'42156365L','Bugambilla para reja','2022-05-13',24.60),(4,'47886542T','Adelfa color salmon','2021-04-12',36.45),(5,'41569385F','Mesa de jardin de herraje','2022-06-19',287.36),(6,'41569385F','Gnome de jardin','2021-06-12',43.98),(7,'42156365L','Lampara led solar','2021-03-18',7.26),(8,'42156365L','Maceta floral rustica','2022-12-18',5.87),(9,'41569385F','Cesped natural','2021-04-23',10.00),(10,'42156365L','Aloe vera pequeño','2021-07-12',6.36),(11,'39886487F','Cactus redondeado','2022-09-30',5.94),(12,'47886542T','Drosera blanca','2021-08-09',7.87);
/*!40000 ALTER TABLE `articulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `color`
--

LOCK TABLES `color` WRITE;
/*!40000 ALTER TABLE `color` DISABLE KEYS */;
INSERT INTO `color` VALUES (660033,'Rosa oscuro'),(660066,'Violeta oscuro'),(990000,'Rojo sangre'),(999900,'Color caqui');
/*!40000 ALTER TABLE `color` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `compuesta`
--

LOCK TABLES `compuesta` WRITE;
/*!40000 ALTER TABLE `compuesta` DISABLE KEYS */;
INSERT INTO `compuesta` VALUES (1,660033),(3,660066),(4,990000),(2,999900);
/*!40000 ALTER TABLE `compuesta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `constituido`
--

LOCK TABLES `constituido` WRITE;
/*!40000 ALTER TABLE `constituido` DISABLE KEYS */;
INSERT INTO `constituido` VALUES (5,1),(6,4),(7,3),(8,4);
/*!40000 ALTER TABLE `constituido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `flor`
--

LOCK TABLES `flor` WRITE;
/*!40000 ALTER TABLE `flor` DISABLE KEYS */;
INSERT INTO `flor` VALUES (1,3),(2,60),(3,365),(4,1500);
/*!40000 ALTER TABLE `flor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `material`
--

LOCK TABLES `material` WRITE;
/*!40000 ALTER TABLE `material` DISABLE KEYS */;
INSERT INTO `material` VALUES (1,10,'Gris','No'),(2,6,'Marron','Si'),(3,3,'Blanco','Si'),(4,2,'Marron','No');
/*!40000 ALTER TABLE `material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `planta`
--

LOCK TABLES `planta` WRITE;
/*!40000 ALTER TABLE `planta` DISABLE KEYS */;
INSERT INTO `planta` VALUES (9,'Agrostis. stolinifera','FueraSombra',NULL),(10,'Aloe. vera','DentroSoleado',NULL),(11,'Echinopsis. subdenudata','DentroSoleado','grisaceo'),(12,'Drosera. capensis var Alba','FueraSombra','albina');
/*!40000 ALTER TABLE `planta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES ('A11964875',689315784,'Metalursa'),('A14748569',618992423,'Plastisur'),('A41975458',725465189,'Hispamad'),('B00739458',927485371,'Arcilar');
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `suministra`
--

LOCK TABLES `suministra` WRITE;
/*!40000 ALTER TABLE `suministra` DISABLE KEYS */;
INSERT INTO `suministra` VALUES (1,'A11964875'),(3,'A14748569'),(2,'A41975458'),(4,'B00739458');
/*!40000 ALTER TABLE `suministra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `telefono`
--

LOCK TABLES `telefono` WRITE;
/*!40000 ALTER TABLE `telefono` DISABLE KEYS */;
INSERT INTO `telefono` VALUES (618992423,'España','NO'),(689315784,'España','NO'),(725465189,'España','NO'),(927485371,'Portugal','SI');
/*!40000 ALTER TABLE `telefono` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `vendedor`
--

LOCK TABLES `vendedor` WRITE;
/*!40000 ALTER TABLE `vendedor` DISABLE KEYS */;
INSERT INTO `vendedor` VALUES ('39886487F','Hermenegildo','Matabuena','Gutierrez','ciaspyme@guerrillamail.com','47886542T'),('41569385F','Manuel','Carmona','Garcia','reshulako@nofakemail.com','47886542T'),('42156365L','Antonio','Carrasco','Heredia','shemorenoloko@gmail.com','47886542T'),('47886542T','Pedro','Perez','Hernandez','pedroperez@hotmail.com',NULL);
/*!40000 ALTER TABLE `vendedor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-29 12:16:40
