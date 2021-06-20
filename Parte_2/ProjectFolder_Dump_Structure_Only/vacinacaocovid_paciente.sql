CREATE DATABASE  IF NOT EXISTS `vacinacaocovid` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;
USE `vacinacaocovid`;
-- MariaDB dump 10.19  Distrib 10.4.19-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: vacinacaocovid
-- ------------------------------------------------------
-- Server version	10.4.10-MariaDB

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
-- Table structure for table `paciente`
--

DROP TABLE IF EXISTS `paciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paciente` (
  `document_id` varchar(70) COLLATE utf8_bin NOT NULL COMMENT 'Comentario document_id',
  `paciente_id` varchar(80) COLLATE utf8_bin NOT NULL COMMENT 'Comentario paciente_id',
  `paciente_idade` tinyint(3) DEFAULT NULL COMMENT 'Comentario paciente_idade',
  `paciente_datanascimento` date NOT NULL COMMENT 'Comentario paciente_nascimento',
  `paciente_enumsexobiologico` varchar(2) COLLATE utf8_bin DEFAULT NULL,
  `paciente_racacor_codigo` tinyint(2) DEFAULT NULL,
  `paciente_racacor_valor` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `paciente_endereco_coibgemunicipio` int(11) DEFAULT NULL,
  `paciente_endereco_copais` tinyint(4) DEFAULT NULL COMMENT 'Comentario paciente_endereco_copais',
  `paciente_endereco_nmmunicipio` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `paciente_endereco_nmpais` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `paciente_endereco_uf` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `paciente_endereco_cep` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `paciente_nacionalidade_enumnacionalidade` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `estabelecimento_estabelecimento_valor` int(11) NOT NULL,
  PRIMARY KEY (`document_id`),
  KEY `fk_paciente_estabelecimento1` (`estabelecimento_estabelecimento_valor`),
  CONSTRAINT `fk_paciente_estabelecimento1` FOREIGN KEY (`estabelecimento_estabelecimento_valor`) REFERENCES `estabelecimento` (`estabelecimento_valor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-06-20 16:08:32
