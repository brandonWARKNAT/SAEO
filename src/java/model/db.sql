-- MySQL dump 10.16  Distrib 10.1.22-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: saeo
-- ------------------------------------------------------
-- Server version	10.1.22-MariaDB-1~trusty

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Consulta`
--

DROP TABLE IF EXISTS `Consulta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Consulta` (
  `idConsulta` int(11) NOT NULL,
  `Fecha` varchar(45) DEFAULT NULL,
  `Paciente_idPaciente` int(11) NOT NULL,
  `Recibo_idRecibo` int(11) NOT NULL,
  `Estado` varchar(10) NOT NULL,
  `Odontologo_idOdontologo` int(11) NOT NULL,
  `Mensaje` varchar(45) DEFAULT NULL,
  `Servicio_idServicio` int(11) NOT NULL,
  PRIMARY KEY (`idConsulta`),
  KEY `fk_Consulta_Paciente_idx` (`Paciente_idPaciente`),
  KEY `fk_Consulta_Recibo1_idx` (`Recibo_idRecibo`),
  KEY `fk_Consulta_Odontologo1_idx` (`Odontologo_idOdontologo`),
  KEY `fk_Consulta_Servicio1_idx` (`Servicio_idServicio`),
  CONSTRAINT `fk_Consulta_Odontologo1` FOREIGN KEY (`Odontologo_idOdontologo`) REFERENCES `Odontologo` (`idOdontologo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consulta_Paciente` FOREIGN KEY (`Paciente_idPaciente`) REFERENCES `Paciente` (`idPaciente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consulta_Recibo1` FOREIGN KEY (`Recibo_idRecibo`) REFERENCES `Recibo` (`idRecibo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consulta_Servicio1` FOREIGN KEY (`Servicio_idServicio`) REFERENCES `Servicio` (`idServicio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Consulta`
--

LOCK TABLES `Consulta` WRITE;
/*!40000 ALTER TABLE `Consulta` DISABLE KEYS */;
INSERT INTO `Consulta` VALUES (1,'12-03-17',1,1,'pendiente',1,'ffdd',1);
/*!40000 ALTER TABLE `Consulta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Odontologo`
--

DROP TABLE IF EXISTS `Odontologo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Odontologo` (
  `idOdontologo` int(11) NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `Cedula` varchar(45) NOT NULL,
  PRIMARY KEY (`idOdontologo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Odontologo`
--

LOCK TABLES `Odontologo` WRITE;
/*!40000 ALTER TABLE `Odontologo` DISABLE KEYS */;
INSERT INTO `Odontologo` VALUES (1,'Arturo Esteban','12345');
/*!40000 ALTER TABLE `Odontologo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Paciente`
--

DROP TABLE IF EXISTS `Paciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Paciente` (
  `idPaciente` int(11) NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `Descripcion` varchar(90) NOT NULL,
  `Sexo` varchar(45) NOT NULL,
  `Edad` varchar(45) NOT NULL,
  PRIMARY KEY (`idPaciente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Paciente`
--

LOCK TABLES `Paciente` WRITE;
/*!40000 ALTER TABLE `Paciente` DISABLE KEYS */;
INSERT INTO `Paciente` VALUES (1,'Brandon Uriel','Joven delgado','Masculino','21'),(3,'Esteba ','dfg','dfgdfgdfgdfgdf','30'),(12,'Arturo','sf','sd','34'),(23,'dfdgd','dgdf','dfgd','32'),(24,'Ar','dssd','sdf','35');
/*!40000 ALTER TABLE `Paciente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Recibo`
--

DROP TABLE IF EXISTS `Recibo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Recibo` (
  `idRecibo` int(11) NOT NULL,
  `Costo` double DEFAULT NULL,
  PRIMARY KEY (`idRecibo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Recibo`
--

LOCK TABLES `Recibo` WRITE;
/*!40000 ALTER TABLE `Recibo` DISABLE KEYS */;
INSERT INTO `Recibo` VALUES (1,90);
/*!40000 ALTER TABLE `Recibo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Servicio`
--

DROP TABLE IF EXISTS `Servicio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Servicio` (
  `idServicio` int(11) NOT NULL,
  `Nombre_Servicio` varchar(45) DEFAULT NULL,
  `Duracion` varchar(45) DEFAULT NULL,
  `Costo` double DEFAULT NULL,
  PRIMARY KEY (`idServicio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Servicio`
--

LOCK TABLES `Servicio` WRITE;
/*!40000 ALTER TABLE `Servicio` DISABLE KEYS */;
INSERT INTO `Servicio` VALUES (1,'Endodoncia','1:00',900),(2,'Limpieza','0:30',50);
/*!40000 ALTER TABLE `Servicio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tratamiento`
--

DROP TABLE IF EXISTS `Tratamiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Tratamiento` (
  `idTratamiento` int(11) NOT NULL,
  `Nombre_Tratamiento` varchar(45) DEFAULT NULL,
  `Costo` double DEFAULT NULL,
  `Consulta_idConsulta` int(11) NOT NULL,
  PRIMARY KEY (`idTratamiento`),
  KEY `fk_Tratamiento_Consulta1_idx` (`Consulta_idConsulta`),
  CONSTRAINT `fk_Tratamiento_Consulta1` FOREIGN KEY (`Consulta_idConsulta`) REFERENCES `Consulta` (`idConsulta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tratamiento`
--

LOCK TABLES `Tratamiento` WRITE;
/*!40000 ALTER TABLE `Tratamiento` DISABLE KEYS */;
/*!40000 ALTER TABLE `Tratamiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Usuario`
--

DROP TABLE IF EXISTS `Usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Usuario` (
 `idUsuario` int(11) NOT NULL,
  `correo` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `idPaciente` int(11) NOT NULL,
  `idOdontologo` int(11) NOT NULL,
  PRIMARY KEY (`correo`),
  KEY `fk_Usuario_Paciente1_idx` (`idPaciente`),
  KEY `fk_Usuario_Odontologo1_idx` (`idOdontologo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Usuario`
--

LOCK TABLES `Usuario` WRITE;
/*!40000 ALTER TABLE `Usuario` DISABLE KEYS */;
INSERT INTO `Usuario` VALUES (1,'brandon@mailinator.com','password',1,0),(2,'esteban@hotmail.com','password',0,1);
/*!40000 ALTER TABLE `Usuario` ENABLE KEYS */;
UNLOCK TABLES;

INSERT INTO SERVICIO VALUES (1, "Limpieza Dental", "30:00", 120.80);

INSERT INTO Paciente VALUES(1, "Brandon Uriel", "Joven delgado", "Masculino", "21");
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-06-12 10:18:56
