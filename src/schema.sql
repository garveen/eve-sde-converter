-- MySQL dump 10.19  Distrib 10.3.38-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: sdeyaml
-- ------------------------------------------------------
-- Server version	10.3.38-MariaDB

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
-- Table structure for table `agtAgentTypes`
--

DROP TABLE IF EXISTS `agtAgentTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agtAgentTypes` (
  `agentTypeID` int(11) NOT NULL,
  `agentType` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`agentTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agtAgentTypes`
--

LOCK TABLES `agtAgentTypes` WRITE;
/*!40000 ALTER TABLE `agtAgentTypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `agtAgentTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agtAgents`
--

DROP TABLE IF EXISTS `agtAgents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agtAgents` (
  `agentID` int(11) NOT NULL,
  `divisionID` int(11) DEFAULT NULL,
  `corporationID` int(11) DEFAULT NULL,
  `locationID` int(11) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `agentTypeID` int(11) DEFAULT NULL,
  `isLocator` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`agentID`),
  KEY `ix_agtAgents_corporationID` (`corporationID`),
  KEY `ix_agtAgents_locationID` (`locationID`),
  CONSTRAINT `aa_isloc` CHECK (`isLocator` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agtAgents`
--

LOCK TABLES `agtAgents` WRITE;
/*!40000 ALTER TABLE `agtAgents` DISABLE KEYS */;
/*!40000 ALTER TABLE `agtAgents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agtAgentsInSpace`
--

DROP TABLE IF EXISTS `agtAgentsInSpace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agtAgentsInSpace` (
  `agentID` int(11) NOT NULL,
  `dungeonID` int(11) DEFAULT NULL,
  `solarSystemID` int(11) DEFAULT NULL,
  `spawnPointID` int(11) DEFAULT NULL,
  `typeID` int(11) DEFAULT NULL,
  PRIMARY KEY (`agentID`),
  KEY `ix_agtAgentsInSpace_solarSystemID` (`solarSystemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agtAgentsInSpace`
--

LOCK TABLES `agtAgentsInSpace` WRITE;
/*!40000 ALTER TABLE `agtAgentsInSpace` DISABLE KEYS */;
/*!40000 ALTER TABLE `agtAgentsInSpace` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agtResearchAgents`
--

DROP TABLE IF EXISTS `agtResearchAgents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agtResearchAgents` (
  `agentID` int(11) NOT NULL,
  `typeID` int(11) NOT NULL,
  PRIMARY KEY (`agentID`,`typeID`),
  KEY `ix_agtResearchAgents_typeID` (`typeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agtResearchAgents`
--

LOCK TABLES `agtResearchAgents` WRITE;
/*!40000 ALTER TABLE `agtResearchAgents` DISABLE KEYS */;
/*!40000 ALTER TABLE `agtResearchAgents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certCerts`
--

DROP TABLE IF EXISTS `certCerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certCerts` (
  `certID` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  `groupID` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`certID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certCerts`
--

LOCK TABLES `certCerts` WRITE;
/*!40000 ALTER TABLE `certCerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `certCerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certMasteries`
--

DROP TABLE IF EXISTS `certMasteries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certMasteries` (
  `typeID` int(11) DEFAULT NULL,
  `masteryLevel` int(11) DEFAULT NULL,
  `certID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certMasteries`
--

LOCK TABLES `certMasteries` WRITE;
/*!40000 ALTER TABLE `certMasteries` DISABLE KEYS */;
/*!40000 ALTER TABLE `certMasteries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certSkills`
--

DROP TABLE IF EXISTS `certSkills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certSkills` (
  `certID` int(11) DEFAULT NULL,
  `skillID` int(11) DEFAULT NULL,
  `certLevelInt` int(11) DEFAULT NULL,
  `skillLevel` int(11) DEFAULT NULL,
  `certLevelText` varchar(8) DEFAULT NULL,
  KEY `ix_certSkills_skillID` (`skillID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certSkills`
--

LOCK TABLES `certSkills` WRITE;
/*!40000 ALTER TABLE `certSkills` DISABLE KEYS */;
/*!40000 ALTER TABLE `certSkills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `charFactions`
--
-- 
-- DROP TABLE IF EXISTS `charFactions`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `charFactions` (
--   `factionID` int(11) NOT NULL,
--   `factionName` varchar(100) DEFAULT NULL,
--   `description` varchar(1000) DEFAULT NULL,
--   `raceIDs` int(11) DEFAULT NULL,
--   `solarSystemID` int(11) DEFAULT NULL,
--   `corporationID` int(11) DEFAULT NULL,
--   `sizeFactor` float DEFAULT NULL,
--   `stationCount` int(11) DEFAULT NULL,
--   `stationSystemCount` int(11) DEFAULT NULL,
--   `militiaCorporationID` int(11) DEFAULT NULL,
--   `iconID` int(11) DEFAULT NULL
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `charFactions`
--
-- 
-- LOCK TABLES `charFactions` WRITE;
-- /*!40000 ALTER TABLE `charFactions` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `charFactions` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `chrAncestries`
--

DROP TABLE IF EXISTS `chrAncestries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chrAncestries` (
  `ancestryID` int(11) NOT NULL,
  `ancestryName` varchar(100) DEFAULT NULL,
  `bloodlineID` int(11) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `perception` int(11) DEFAULT NULL,
  `willpower` int(11) DEFAULT NULL,
  `charisma` int(11) DEFAULT NULL,
  `memory` int(11) DEFAULT NULL,
  `intelligence` int(11) DEFAULT NULL,
  `iconID` int(11) DEFAULT NULL,
  `shortDescription` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`ancestryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chrAncestries`
--

LOCK TABLES `chrAncestries` WRITE;
/*!40000 ALTER TABLE `chrAncestries` DISABLE KEYS */;
/*!40000 ALTER TABLE `chrAncestries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chrAttributes`
--

DROP TABLE IF EXISTS `chrAttributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chrAttributes` (
  `attributeID` int(11) NOT NULL,
  `attributeName` varchar(100) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `iconID` int(11) DEFAULT NULL,
  `shortDescription` varchar(500) DEFAULT NULL,
  `notes` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`attributeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chrAttributes`
--

LOCK TABLES `chrAttributes` WRITE;
/*!40000 ALTER TABLE `chrAttributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `chrAttributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chrBloodlines`
--

DROP TABLE IF EXISTS `chrBloodlines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chrBloodlines` (
  `bloodlineID` int(11) NOT NULL,
  `bloodlineName` varchar(100) DEFAULT NULL,
  `raceID` int(11) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `maleDescription` varchar(1000) DEFAULT NULL,
  `femaleDescription` varchar(1000) DEFAULT NULL,
  `shipTypeID` int(11) DEFAULT NULL,
  `corporationID` int(11) DEFAULT NULL,
  `perception` int(11) DEFAULT NULL,
  `willpower` int(11) DEFAULT NULL,
  `charisma` int(11) DEFAULT NULL,
  `memory` int(11) DEFAULT NULL,
  `intelligence` int(11) DEFAULT NULL,
  `iconID` int(11) DEFAULT NULL,
  `shortDescription` varchar(500) DEFAULT NULL,
  `shortMaleDescription` varchar(500) DEFAULT NULL,
  `shortFemaleDescription` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`bloodlineID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chrBloodlines`
--

LOCK TABLES `chrBloodlines` WRITE;
/*!40000 ALTER TABLE `chrBloodlines` DISABLE KEYS */;
/*!40000 ALTER TABLE `chrBloodlines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chrFactions`
--

DROP TABLE IF EXISTS `chrFactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chrFactions` (
  `factionID` int(11) NOT NULL,
  `factionName` varchar(100) DEFAULT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `raceIDs` int(11) DEFAULT NULL,
  `solarSystemID` int(11) DEFAULT NULL,
  `corporationID` int(11) DEFAULT NULL,
  `sizeFactor` float DEFAULT NULL,
  `stationCount` int(11) DEFAULT NULL,
  `stationSystemCount` int(11) DEFAULT NULL,
  `militiaCorporationID` int(11) DEFAULT NULL,
  `iconID` int(11) DEFAULT NULL,
  PRIMARY KEY (`factionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chrFactions`
--

LOCK TABLES `chrFactions` WRITE;
/*!40000 ALTER TABLE `chrFactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `chrFactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chrRaces`
--

DROP TABLE IF EXISTS `chrRaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chrRaces` (
  `raceID` int(11) NOT NULL,
  `raceName` varchar(100) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `iconID` int(11) DEFAULT NULL,
  `shortDescription` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`raceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chrRaces`
--

LOCK TABLES `chrRaces` WRITE;
/*!40000 ALTER TABLE `chrRaces` DISABLE KEYS */;
/*!40000 ALTER TABLE `chrRaces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crpActivities`
--

DROP TABLE IF EXISTS `crpActivities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crpActivities` (
  `activityID` int(11) NOT NULL,
  `activityName` varchar(100) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`activityID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crpActivities`
--

LOCK TABLES `crpActivities` WRITE;
/*!40000 ALTER TABLE `crpActivities` DISABLE KEYS */;
/*!40000 ALTER TABLE `crpActivities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crpNPCCorporationDivisions`
--
-- 
-- DROP TABLE IF EXISTS `crpNPCCorporationDivisions`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `crpNPCCorporationDivisions` (
--   `corporationID` int(11) NOT NULL,
--   `divisionID` int(11) NOT NULL,
--   `size` int(11) DEFAULT NULL,
--   PRIMARY KEY (`corporationID`,`divisionID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `crpNPCCorporationDivisions`
--
-- 
-- LOCK TABLES `crpNPCCorporationDivisions` WRITE;
-- /*!40000 ALTER TABLE `crpNPCCorporationDivisions` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `crpNPCCorporationDivisions` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `crpNPCCorporationResearchFields`
--
-- 
-- DROP TABLE IF EXISTS `crpNPCCorporationResearchFields`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `crpNPCCorporationResearchFields` (
--   `skillID` int(11) NOT NULL,
--   `corporationID` int(11) NOT NULL,
--   PRIMARY KEY (`skillID`,`corporationID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `crpNPCCorporationResearchFields`
--
-- 
-- LOCK TABLES `crpNPCCorporationResearchFields` WRITE;
-- /*!40000 ALTER TABLE `crpNPCCorporationResearchFields` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `crpNPCCorporationResearchFields` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `crpNPCCorporationTrades`
--
-- 
-- DROP TABLE IF EXISTS `crpNPCCorporationTrades`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `crpNPCCorporationTrades` (
--   `corporationID` int(11) NOT NULL,
--   `typeID` int(11) NOT NULL,
--   PRIMARY KEY (`corporationID`,`typeID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `crpNPCCorporationTrades`
--
-- 
-- LOCK TABLES `crpNPCCorporationTrades` WRITE;
-- /*!40000 ALTER TABLE `crpNPCCorporationTrades` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `crpNPCCorporationTrades` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `crpNPCCorporations`
--

DROP TABLE IF EXISTS `crpNPCCorporations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `crpNPCCorporations` (
  `corporationID` int(11) NOT NULL,
  `size` char(1) DEFAULT NULL,
  `extent` char(1) DEFAULT NULL,
  `solarSystemID` int(11) DEFAULT NULL,
  `investorID1` int(11) DEFAULT NULL,
  `investorShares1` int(11) DEFAULT NULL,
  `investorID2` int(11) DEFAULT NULL,
  `investorShares2` int(11) DEFAULT NULL,
  `investorID3` int(11) DEFAULT NULL,
  `investorShares3` int(11) DEFAULT NULL,
  `investorID4` int(11) DEFAULT NULL,
  `investorShares4` int(11) DEFAULT NULL,
  `friendID` int(11) DEFAULT NULL,
  `enemyID` int(11) DEFAULT NULL,
  `publicShares` int(11) DEFAULT NULL,
  `initialPrice` int(11) DEFAULT NULL,
  `minSecurity` float DEFAULT NULL,
  `scattered` tinyint(1) DEFAULT NULL,
  `fringe` int(11) DEFAULT NULL,
  `corridor` int(11) DEFAULT NULL,
  `hub` int(11) DEFAULT NULL,
  `border` int(11) DEFAULT NULL,
  `factionID` int(11) DEFAULT NULL,
  `sizeFactor` float DEFAULT NULL,
  `stationCount` int(11) DEFAULT NULL,
  `stationSystemCount` int(11) DEFAULT NULL,
  `description` varchar(4000) DEFAULT NULL,
  `iconID` int(11) DEFAULT NULL,
  PRIMARY KEY (`corporationID`),
  CONSTRAINT `cnpcc_scatt` CHECK (`scattered` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crpNPCCorporations`
--

LOCK TABLES `crpNPCCorporations` WRITE;
/*!40000 ALTER TABLE `crpNPCCorporations` DISABLE KEYS */;
/*!40000 ALTER TABLE `crpNPCCorporations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crpNPCDivisions`
--
-- 
-- DROP TABLE IF EXISTS `crpNPCDivisions`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `crpNPCDivisions` (
--   `divisionID` int(11) NOT NULL,
--   `divisionName` varchar(100) DEFAULT NULL,
--   `description` varchar(1000) DEFAULT NULL,
--   `leaderType` varchar(100) DEFAULT NULL,
--   PRIMARY KEY (`divisionID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `crpNPCDivisions`
--
-- 
-- LOCK TABLES `crpNPCDivisions` WRITE;
-- /*!40000 ALTER TABLE `crpNPCDivisions` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `crpNPCDivisions` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `dgmAttributeCategories`
--

DROP TABLE IF EXISTS `dgmAttributeCategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dgmAttributeCategories` (
  `categoryID` int(11) NOT NULL,
  `categoryName` varchar(50) DEFAULT NULL,
  `categoryDescription` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`categoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dgmAttributeCategories`
--

LOCK TABLES `dgmAttributeCategories` WRITE;
/*!40000 ALTER TABLE `dgmAttributeCategories` DISABLE KEYS */;
/*!40000 ALTER TABLE `dgmAttributeCategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dgmAttributeTypes`
--

DROP TABLE IF EXISTS `dgmAttributeTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dgmAttributeTypes` (
  `attributeID` int(11) NOT NULL,
  `attributeName` varchar(100) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `iconID` int(11) DEFAULT NULL,
  `defaultValue` float DEFAULT NULL,
  `published` tinyint(1) DEFAULT NULL,
  `displayName` varchar(150) DEFAULT NULL,
  `unitID` int(11) DEFAULT NULL,
  `stackable` tinyint(1) DEFAULT NULL,
  `highIsGood` tinyint(1) DEFAULT NULL,
  `categoryID` int(11) DEFAULT NULL,
  PRIMARY KEY (`attributeID`),
  CONSTRAINT `dat_pub` CHECK (`published` in (0,1)),
  CONSTRAINT `dat_stack` CHECK (`stackable` in (0,1)),
  CONSTRAINT `dat_hig` CHECK (`highIsGood` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dgmAttributeTypes`
--

LOCK TABLES `dgmAttributeTypes` WRITE;
/*!40000 ALTER TABLE `dgmAttributeTypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `dgmAttributeTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dgmEffects`
--

DROP TABLE IF EXISTS `dgmEffects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dgmEffects` (
  `effectID` int(11) NOT NULL,
  `effectName` varchar(400) DEFAULT NULL,
  `effectCategory` int(11) DEFAULT NULL,
  `preExpression` int(11) DEFAULT NULL,
  `postExpression` int(11) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `guid` varchar(60) DEFAULT NULL,
  `iconID` int(11) DEFAULT NULL,
  `isOffensive` tinyint(1) DEFAULT NULL,
  `isAssistance` tinyint(1) DEFAULT NULL,
  `durationAttributeID` int(11) DEFAULT NULL,
  `trackingSpeedAttributeID` int(11) DEFAULT NULL,
  `dischargeAttributeID` int(11) DEFAULT NULL,
  `rangeAttributeID` int(11) DEFAULT NULL,
  `falloffAttributeID` int(11) DEFAULT NULL,
  `disallowAutoRepeat` tinyint(1) DEFAULT NULL,
  `published` tinyint(1) DEFAULT NULL,
  `displayName` varchar(100) DEFAULT NULL,
  `isWarpSafe` tinyint(1) DEFAULT NULL,
  `rangeChance` tinyint(1) DEFAULT NULL,
  `electronicChance` tinyint(1) DEFAULT NULL,
  `propulsionChance` tinyint(1) DEFAULT NULL,
  `distribution` int(11) DEFAULT NULL,
  `sfxName` varchar(20) DEFAULT NULL,
  `npcUsageChanceAttributeID` int(11) DEFAULT NULL,
  `npcActivationChanceAttributeID` int(11) DEFAULT NULL,
  `fittingUsageChanceAttributeID` int(11) DEFAULT NULL,
  `modifierInfo` text DEFAULT NULL,
  PRIMARY KEY (`effectID`),
  CONSTRAINT `de_offense` CHECK (`isOffensive` in (0,1)),
  CONSTRAINT `de_assist` CHECK (`isAssistance` in (0,1)),
  CONSTRAINT `de_disallowar` CHECK (`disallowAutoRepeat` in (0,1)),
  CONSTRAINT `de_published` CHECK (`published` in (0,1)),
  CONSTRAINT `de_warpsafe` CHECK (`isWarpSafe` in (0,1)),
  CONSTRAINT `de_rangechance` CHECK (`rangeChance` in (0,1)),
  CONSTRAINT `de_elecchance` CHECK (`electronicChance` in (0,1)),
  CONSTRAINT `de_propchance` CHECK (`propulsionChance` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dgmEffects`
--

LOCK TABLES `dgmEffects` WRITE;
/*!40000 ALTER TABLE `dgmEffects` DISABLE KEYS */;
/*!40000 ALTER TABLE `dgmEffects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dgmExpressions`
--
-- 
-- DROP TABLE IF EXISTS `dgmExpressions`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `dgmExpressions` (
--   `expressionID` int(11) NOT NULL,
--   `operandID` int(11) DEFAULT NULL,
--   `arg1` int(11) DEFAULT NULL,
--   `arg2` int(11) DEFAULT NULL,
--   `expressionValue` varchar(100) DEFAULT NULL,
--   `description` varchar(1000) DEFAULT NULL,
--   `expressionName` varchar(500) DEFAULT NULL,
--   `expressionTypeID` int(11) DEFAULT NULL,
--   `expressionGroupID` int(11) DEFAULT NULL,
--   `expressionAttributeID` int(11) DEFAULT NULL,
--   PRIMARY KEY (`expressionID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `dgmExpressions`
--
-- 
-- LOCK TABLES `dgmExpressions` WRITE;
-- /*!40000 ALTER TABLE `dgmExpressions` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `dgmExpressions` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `dgmTypeAttributes`
--

DROP TABLE IF EXISTS `dgmTypeAttributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dgmTypeAttributes` (
  `typeID` int(11) NOT NULL,
  `attributeID` int(11) NOT NULL,
  `valueInt` int(11) DEFAULT NULL,
  `valueFloat` float DEFAULT NULL,
  PRIMARY KEY (`typeID`,`attributeID`),
  KEY `ix_dgmTypeAttributes_attributeID` (`attributeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dgmTypeAttributes`
--

LOCK TABLES `dgmTypeAttributes` WRITE;
/*!40000 ALTER TABLE `dgmTypeAttributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `dgmTypeAttributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dgmTypeEffects`
--

DROP TABLE IF EXISTS `dgmTypeEffects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dgmTypeEffects` (
  `typeID` int(11) NOT NULL,
  `effectID` int(11) NOT NULL,
  `isDefault` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`typeID`,`effectID`),
  CONSTRAINT `dte_default` CHECK (`isDefault` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dgmTypeEffects`
--

LOCK TABLES `dgmTypeEffects` WRITE;
/*!40000 ALTER TABLE `dgmTypeEffects` DISABLE KEYS */;
/*!40000 ALTER TABLE `dgmTypeEffects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eveGraphics`
--

DROP TABLE IF EXISTS `eveGraphics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eveGraphics` (
  `graphicID` int(11) NOT NULL,
  `sofFactionName` varchar(100) DEFAULT NULL,
  `graphicFile` varchar(256) DEFAULT NULL,
  `sofHullName` varchar(100) DEFAULT NULL,
  `sofRaceName` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`graphicID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eveGraphics`
--

LOCK TABLES `eveGraphics` WRITE;
/*!40000 ALTER TABLE `eveGraphics` DISABLE KEYS */;
/*!40000 ALTER TABLE `eveGraphics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eveIcons`
--

DROP TABLE IF EXISTS `eveIcons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eveIcons` (
  `iconID` int(11) NOT NULL,
  `iconFile` varchar(500) DEFAULT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`iconID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eveIcons`
--

LOCK TABLES `eveIcons` WRITE;
/*!40000 ALTER TABLE `eveIcons` DISABLE KEYS */;
/*!40000 ALTER TABLE `eveIcons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eveUnits`
--

DROP TABLE IF EXISTS `eveUnits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eveUnits` (
  `unitID` int(11) NOT NULL,
  `unitName` varchar(100) DEFAULT NULL,
  `displayName` varchar(50) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`unitID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eveUnits`
--

LOCK TABLES `eveUnits` WRITE;
/*!40000 ALTER TABLE `eveUnits` DISABLE KEYS */;
/*!40000 ALTER TABLE `eveUnits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `industryActivity`
--
-- 
-- DROP TABLE IF EXISTS `industryActivity`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `industryActivity` (
--   `typeID` int(11) NOT NULL,
--   `activityID` int(11) NOT NULL,
--   `time` int(11) DEFAULT NULL,
--   PRIMARY KEY (`typeID`,`activityID`),
--   KEY `ix_industryActivity_activityID` (`activityID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `industryActivity`
--
-- 
-- LOCK TABLES `industryActivity` WRITE;
-- /*!40000 ALTER TABLE `industryActivity` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `industryActivity` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `industryActivityMaterials`
--
-- 
-- DROP TABLE IF EXISTS `industryActivityMaterials`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `industryActivityMaterials` (
--   `typeID` int(11) DEFAULT NULL,
--   `activityID` int(11) DEFAULT NULL,
--   `materialTypeID` int(11) DEFAULT NULL,
--   `quantity` int(11) DEFAULT NULL,
--   KEY `industryActivityMaterials_idx1` (`typeID`,`activityID`),
--   KEY `ix_industryActivityMaterials_typeID` (`typeID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `industryActivityMaterials`
--
-- 
-- LOCK TABLES `industryActivityMaterials` WRITE;
-- /*!40000 ALTER TABLE `industryActivityMaterials` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `industryActivityMaterials` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `industryActivityProbabilities`
--
-- 
-- DROP TABLE IF EXISTS `industryActivityProbabilities`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `industryActivityProbabilities` (
--   `typeID` int(11) DEFAULT NULL,
--   `activityID` int(11) DEFAULT NULL,
--   `productTypeID` int(11) DEFAULT NULL,
--   `probability` decimal(3,2) DEFAULT NULL,
--   KEY `ix_industryActivityProbabilities_typeID` (`typeID`),
--   KEY `ix_industryActivityProbabilities_productTypeID` (`productTypeID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `industryActivityProbabilities`
--
-- 
-- LOCK TABLES `industryActivityProbabilities` WRITE;
-- /*!40000 ALTER TABLE `industryActivityProbabilities` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `industryActivityProbabilities` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `industryActivityProducts`
--
-- 
-- DROP TABLE IF EXISTS `industryActivityProducts`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `industryActivityProducts` (
--   `typeID` int(11) DEFAULT NULL,
--   `activityID` int(11) DEFAULT NULL,
--   `productTypeID` int(11) DEFAULT NULL,
--   `quantity` int(11) DEFAULT NULL,
--   KEY `ix_industryActivityProducts_typeID` (`typeID`),
--   KEY `ix_industryActivityProducts_productTypeID` (`productTypeID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `industryActivityProducts`
--
-- 
-- LOCK TABLES `industryActivityProducts` WRITE;
-- /*!40000 ALTER TABLE `industryActivityProducts` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `industryActivityProducts` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `industryActivityRaces`
--
-- 
-- DROP TABLE IF EXISTS `industryActivityRaces`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `industryActivityRaces` (
--   `typeID` int(11) DEFAULT NULL,
--   `activityID` int(11) DEFAULT NULL,
--   `productTypeID` int(11) DEFAULT NULL,
--   `raceID` int(11) DEFAULT NULL,
--   KEY `ix_industryActivityRaces_productTypeID` (`productTypeID`),
--   KEY `ix_industryActivityRaces_typeID` (`typeID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `industryActivityRaces`
--
-- 
-- LOCK TABLES `industryActivityRaces` WRITE;
-- /*!40000 ALTER TABLE `industryActivityRaces` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `industryActivityRaces` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `industryActivitySkills`
--
-- 
-- DROP TABLE IF EXISTS `industryActivitySkills`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `industryActivitySkills` (
--   `typeID` int(11) DEFAULT NULL,
--   `activityID` int(11) DEFAULT NULL,
--   `skillID` int(11) DEFAULT NULL,
--   `level` int(11) DEFAULT NULL,
--   KEY `industryActivitySkills_idx1` (`typeID`,`activityID`),
--   KEY `ix_industryActivitySkills_typeID` (`typeID`),
--   KEY `ix_industryActivitySkills_skillID` (`skillID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `industryActivitySkills`
--
-- 
-- LOCK TABLES `industryActivitySkills` WRITE;
-- /*!40000 ALTER TABLE `industryActivitySkills` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `industryActivitySkills` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `industryBlueprints`
--

DROP TABLE IF EXISTS `industryBlueprints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `industryBlueprints` (
  `typeID` int(11) NOT NULL,
  `maxProductionLimit` int(11) DEFAULT NULL,
  PRIMARY KEY (`typeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `industryBlueprints`
--

LOCK TABLES `industryBlueprints` WRITE;
/*!40000 ALTER TABLE `industryBlueprints` DISABLE KEYS */;
/*!40000 ALTER TABLE `industryBlueprints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invCategories`
--

DROP TABLE IF EXISTS `invCategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invCategories` (
  `categoryID` int(11) NOT NULL,
  `categoryName` varchar(100) DEFAULT NULL,
  `iconID` int(11) DEFAULT NULL,
  `published` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`categoryID`),
  CONSTRAINT `invcat_published` CHECK (`published` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invCategories`
--

LOCK TABLES `invCategories` WRITE;
/*!40000 ALTER TABLE `invCategories` DISABLE KEYS */;
/*!40000 ALTER TABLE `invCategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invContrabandTypes`
--

DROP TABLE IF EXISTS `invContrabandTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invContrabandTypes` (
  `factionID` int(11) NOT NULL,
  `typeID` int(11) NOT NULL,
  `standingLoss` double DEFAULT NULL,
  `confiscateMinSec` double DEFAULT NULL,
  `fineByValue` double DEFAULT NULL,
  `attackMinSec` double DEFAULT NULL,
  PRIMARY KEY (`factionID`,`typeID`),
  KEY `ix_invContrabandTypes_typeID` (`typeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invContrabandTypes`
--

LOCK TABLES `invContrabandTypes` WRITE;
/*!40000 ALTER TABLE `invContrabandTypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `invContrabandTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invControlTowerResourcePurposes`
--
-- 
-- DROP TABLE IF EXISTS `invControlTowerResourcePurposes`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `invControlTowerResourcePurposes` (
--   `purpose` int(11) NOT NULL,
--   `purposeText` varchar(100) DEFAULT NULL,
--   PRIMARY KEY (`purpose`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `invControlTowerResourcePurposes`
--
-- 
-- LOCK TABLES `invControlTowerResourcePurposes` WRITE;
-- /*!40000 ALTER TABLE `invControlTowerResourcePurposes` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `invControlTowerResourcePurposes` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `invControlTowerResources`
--

DROP TABLE IF EXISTS `invControlTowerResources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invControlTowerResources` (
  `controlTowerTypeID` int(11) NOT NULL,
  `resourceTypeID` int(11) NOT NULL,
  `purpose` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `minSecurityLevel` double DEFAULT NULL,
  `factionID` int(11) DEFAULT NULL,
  PRIMARY KEY (`controlTowerTypeID`,`resourceTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invControlTowerResources`
--

LOCK TABLES `invControlTowerResources` WRITE;
/*!40000 ALTER TABLE `invControlTowerResources` DISABLE KEYS */;
/*!40000 ALTER TABLE `invControlTowerResources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invFlags`
--
-- 
-- DROP TABLE IF EXISTS `invFlags`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `invFlags` (
--   `flagID` int(11) NOT NULL,
--   `flagName` varchar(200) DEFAULT NULL,
--   `flagText` varchar(100) DEFAULT NULL,
--   `orderID` int(11) DEFAULT NULL,
--   PRIMARY KEY (`flagID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `invFlags`
--
-- 
-- LOCK TABLES `invFlags` WRITE;
-- /*!40000 ALTER TABLE `invFlags` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `invFlags` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `invGroups`
--

DROP TABLE IF EXISTS `invGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invGroups` (
  `groupID` int(11) NOT NULL,
  `categoryID` int(11) DEFAULT NULL,
  `groupName` varchar(100) DEFAULT NULL,
  `iconID` int(11) DEFAULT NULL,
  `useBasePrice` tinyint(1) DEFAULT NULL,
  `anchored` tinyint(1) DEFAULT NULL,
  `anchorable` tinyint(1) DEFAULT NULL,
  `fittableNonSingleton` tinyint(1) DEFAULT NULL,
  `published` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`groupID`),
  KEY `ix_invGroups_categoryID` (`categoryID`),
  CONSTRAINT `invgroup_usebaseprice` CHECK (`useBasePrice` in (0,1)),
  CONSTRAINT `invgroup_anchored` CHECK (`anchored` in (0,1)),
  CONSTRAINT `invgroup_anchorable` CHECK (`anchorable` in (0,1)),
  CONSTRAINT `invgroup_fitnonsingle` CHECK (`fittableNonSingleton` in (0,1)),
  CONSTRAINT `invgroup_published` CHECK (`published` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invGroups`
--

LOCK TABLES `invGroups` WRITE;
/*!40000 ALTER TABLE `invGroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `invGroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invItems`
--
-- 
-- DROP TABLE IF EXISTS `invItems`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `invItems` (
--   `itemID` int(11) NOT NULL,
--   `typeID` int(11) NOT NULL,
--   `ownerID` int(11) NOT NULL,
--   `locationID` int(11) NOT NULL,
--   `flagID` int(11) NOT NULL,
--   `quantity` int(11) NOT NULL,
--   PRIMARY KEY (`itemID`),
--   KEY `ix_invItems_locationID` (`locationID`),
--   KEY `items_IX_OwnerLocation` (`ownerID`,`locationID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `invItems`
--
-- 
-- LOCK TABLES `invItems` WRITE;
-- /*!40000 ALTER TABLE `invItems` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `invItems` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `invMarketGroups`
--

DROP TABLE IF EXISTS `invMarketGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invMarketGroups` (
  `marketGroupID` int(11) NOT NULL,
  `parentGroupID` int(11) DEFAULT NULL,
  `marketGroupName` varchar(100) DEFAULT NULL,
  `description` varchar(3000) DEFAULT NULL,
  `iconID` int(11) DEFAULT NULL,
  `hasTypes` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`marketGroupID`),
  CONSTRAINT `invmarketgroups_hastypes` CHECK (`hasTypes` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invMarketGroups`
--

LOCK TABLES `invMarketGroups` WRITE;
/*!40000 ALTER TABLE `invMarketGroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `invMarketGroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invMetaGroups`
--

DROP TABLE IF EXISTS `invMetaGroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invMetaGroups` (
  `metaGroupID` int(11) NOT NULL,
  `metaGroupName` varchar(100) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `iconID` int(11) DEFAULT NULL,
  PRIMARY KEY (`metaGroupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invMetaGroups`
--

LOCK TABLES `invMetaGroups` WRITE;
/*!40000 ALTER TABLE `invMetaGroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `invMetaGroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invMetaTypes`
--

DROP TABLE IF EXISTS `invMetaTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invMetaTypes` (
  `typeID` int(11) NOT NULL,
  `parentTypeID` int(11) DEFAULT NULL,
  `metaGroupID` int(11) DEFAULT NULL,
  PRIMARY KEY (`typeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invMetaTypes`
--

LOCK TABLES `invMetaTypes` WRITE;
/*!40000 ALTER TABLE `invMetaTypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `invMetaTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invNames`
--

DROP TABLE IF EXISTS `invNames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invNames` (
  `itemID` int(11) NOT NULL,
  `itemName` varchar(200) NOT NULL,
  PRIMARY KEY (`itemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invNames`
--

LOCK TABLES `invNames` WRITE;
/*!40000 ALTER TABLE `invNames` DISABLE KEYS */;
/*!40000 ALTER TABLE `invNames` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invPositions`
--
-- 
-- DROP TABLE IF EXISTS `invPositions`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `invPositions` (
--   `itemID` int(11) NOT NULL,
--   `x` float NOT NULL,
--   `y` float NOT NULL,
--   `z` float NOT NULL,
--   `yaw` float DEFAULT NULL,
--   `pitch` float DEFAULT NULL,
--   `roll` float DEFAULT NULL,
--   PRIMARY KEY (`itemID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `invPositions`
--
-- 
-- LOCK TABLES `invPositions` WRITE;
-- /*!40000 ALTER TABLE `invPositions` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `invPositions` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `invTraits`
--
-- 
-- DROP TABLE IF EXISTS `invTraits`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `invTraits` (
--   `traitID` int(11) NOT NULL AUTO_INCREMENT,
--   `typeID` int(11) DEFAULT NULL,
--   `skillID` int(11) DEFAULT NULL,
--   `bonus` float DEFAULT NULL,
--   `bonusText` text DEFAULT NULL,
--   `unitID` int(11) DEFAULT NULL,
--   PRIMARY KEY (`traitID`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=3695 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `invTraits`
--
-- 
-- LOCK TABLES `invTraits` WRITE;
-- /*!40000 ALTER TABLE `invTraits` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `invTraits` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `invTypeMaterials`
--

DROP TABLE IF EXISTS `invTypeMaterials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invTypeMaterials` (
  `typeID` int(11) NOT NULL,
  `materialTypeID` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`typeID`,`materialTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invTypeMaterials`
--

LOCK TABLES `invTypeMaterials` WRITE;
/*!40000 ALTER TABLE `invTypeMaterials` DISABLE KEYS */;
/*!40000 ALTER TABLE `invTypeMaterials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invTypeReactions`
--
-- 
-- DROP TABLE IF EXISTS `invTypeReactions`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `invTypeReactions` (
--   `reactionTypeID` int(11) NOT NULL,
--   `input` tinyint(1) NOT NULL,
--   `typeID` int(11) NOT NULL,
--   `quantity` int(11) DEFAULT NULL,
--   PRIMARY KEY (`reactionTypeID`,`input`,`typeID`),
--   CONSTRAINT `invtypereactions_input` CHECK (`input` in (0,1))
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `invTypeReactions`
--
-- 
-- LOCK TABLES `invTypeReactions` WRITE;
-- /*!40000 ALTER TABLE `invTypeReactions` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `invTypeReactions` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `invTypes`
--

DROP TABLE IF EXISTS `invTypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invTypes` (
  `typeID` int(11) NOT NULL,
  `groupID` int(11) DEFAULT NULL,
  `typeName` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `mass` double DEFAULT NULL,
  `volume` double DEFAULT NULL,
  `capacity` double DEFAULT NULL,
  `portionSize` int(11) DEFAULT NULL,
  `raceID` int(11) DEFAULT NULL,
  `basePrice` decimal(19,4) DEFAULT NULL,
  `published` tinyint(1) DEFAULT NULL,
  `marketGroupID` int(11) DEFAULT NULL,
  `iconID` int(11) DEFAULT NULL,
  `soundID` int(11) DEFAULT NULL,
  `graphicID` int(11) DEFAULT NULL,
  PRIMARY KEY (`typeID`),
  KEY `ix_invTypes_groupID` (`groupID`),
  CONSTRAINT `invtype_published` CHECK (`published` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invTypes`
--

LOCK TABLES `invTypes` WRITE;
/*!40000 ALTER TABLE `invTypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `invTypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invUniqueNames`
--

DROP TABLE IF EXISTS `invUniqueNames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invUniqueNames` (
  `itemID` int(11) NOT NULL,
  `itemName` varchar(200) NOT NULL,
  `groupID` int(11) DEFAULT NULL,
  PRIMARY KEY (`itemID`),
  UNIQUE KEY `ix_invUniqueNames_itemName` (`itemName`),
  KEY `invUniqueNames_IX_GroupName` (`groupID`,`itemName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invUniqueNames`
--

LOCK TABLES `invUniqueNames` WRITE;
/*!40000 ALTER TABLE `invUniqueNames` DISABLE KEYS */;
/*!40000 ALTER TABLE `invUniqueNames` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invVolumes`
--
-- 
-- DROP TABLE IF EXISTS `invVolumes`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `invVolumes` (
--   `typeID` int(11) NOT NULL,
--   `volume` int(11) DEFAULT NULL,
--   PRIMARY KEY (`typeID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `invVolumes`
--
-- 
-- LOCK TABLES `invVolumes` WRITE;
-- /*!40000 ALTER TABLE `invVolumes` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `invVolumes` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `mapCelestialGraphics`
--
-- 
-- DROP TABLE IF EXISTS `mapCelestialGraphics`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `mapCelestialGraphics` (
--   `celestialID` int(11) NOT NULL,
--   `heightMap1` int(11) DEFAULT NULL,
--   `heightMap2` int(11) DEFAULT NULL,
--   `shaderPreset` int(11) DEFAULT NULL,
--   `population` tinyint(1) DEFAULT NULL,
--   PRIMARY KEY (`celestialID`),
--   CONSTRAINT `CONSTRAINT_1` CHECK (`population` in (0,1))
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `mapCelestialGraphics`
--
-- 
-- LOCK TABLES `mapCelestialGraphics` WRITE;
-- /*!40000 ALTER TABLE `mapCelestialGraphics` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `mapCelestialGraphics` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `mapCelestialStatistics`
--
-- 
-- DROP TABLE IF EXISTS `mapCelestialStatistics`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `mapCelestialStatistics` (
--   `celestialID` int(11) NOT NULL,
--   `temperature` double DEFAULT NULL,
--   `spectralClass` varchar(10) DEFAULT NULL,
--   `luminosity` double DEFAULT NULL,
--   `age` double DEFAULT NULL,
--   `life` double DEFAULT NULL,
--   `orbitRadius` double DEFAULT NULL,
--   `eccentricity` double DEFAULT NULL,
--   `massDust` double DEFAULT NULL,
--   `massGas` double DEFAULT NULL,
--   `fragmented` tinyint(1) DEFAULT NULL,
--   `density` double DEFAULT NULL,
--   `surfaceGravity` double DEFAULT NULL,
--   `escapeVelocity` double DEFAULT NULL,
--   `orbitPeriod` double DEFAULT NULL,
--   `rotationRate` double DEFAULT NULL,
--   `locked` tinyint(1) DEFAULT NULL,
--   `pressure` double DEFAULT NULL,
--   `radius` double DEFAULT NULL,
--   `mass` int(11) DEFAULT NULL,
--   PRIMARY KEY (`celestialID`),
--   CONSTRAINT `mapcelestialstats_frag` CHECK (`fragmented` in (0,1)),
--   CONSTRAINT `mapcelestialstats_locked` CHECK (`locked` in (0,1))
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `mapCelestialStatistics`
--
-- 
-- LOCK TABLES `mapCelestialStatistics` WRITE;
-- /*!40000 ALTER TABLE `mapCelestialStatistics` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `mapCelestialStatistics` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `mapConstellationJumps`
--
-- 
-- DROP TABLE IF EXISTS `mapConstellationJumps`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `mapConstellationJumps` (
--   `fromRegionID` int(11) DEFAULT NULL,
--   `fromConstellationID` int(11) NOT NULL,
--   `toConstellationID` int(11) NOT NULL,
--   `toRegionID` int(11) DEFAULT NULL,
--   PRIMARY KEY (`fromConstellationID`,`toConstellationID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `mapConstellationJumps`
--
-- 
-- LOCK TABLES `mapConstellationJumps` WRITE;
-- /*!40000 ALTER TABLE `mapConstellationJumps` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `mapConstellationJumps` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `mapConstellations`
--

DROP TABLE IF EXISTS `mapConstellations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mapConstellations` (
  `regionID` int(11) DEFAULT NULL,
  `constellationID` int(11) NOT NULL,
  `constellationName` varchar(100) DEFAULT NULL,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `z` double DEFAULT NULL,
  `xMin` double DEFAULT NULL,
  `xMax` double DEFAULT NULL,
  `yMin` double DEFAULT NULL,
  `yMax` double DEFAULT NULL,
  `zMin` double DEFAULT NULL,
  `zMax` double DEFAULT NULL,
  `factionID` int(11) DEFAULT NULL,
  `radius` float DEFAULT NULL,
  PRIMARY KEY (`constellationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mapConstellations`
--

LOCK TABLES `mapConstellations` WRITE;
/*!40000 ALTER TABLE `mapConstellations` DISABLE KEYS */;
/*!40000 ALTER TABLE `mapConstellations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mapDenormalize`
--

DROP TABLE IF EXISTS `mapDenormalize`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mapDenormalize` (
  `itemID` int(11) NOT NULL,
  `typeID` int(11) DEFAULT NULL,
  `groupID` int(11) DEFAULT NULL,
  `solarSystemID` int(11) DEFAULT NULL,
  `constellationID` int(11) DEFAULT NULL,
  `regionID` int(11) DEFAULT NULL,
  `orbitID` int(11) DEFAULT NULL,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `z` double DEFAULT NULL,
  `radius` double DEFAULT NULL,
  `itemName` varchar(100) DEFAULT NULL,
  `security` double DEFAULT NULL,
  `celestialIndex` int(11) DEFAULT NULL,
  `orbitIndex` int(11) DEFAULT NULL,
  PRIMARY KEY (`itemID`),
  KEY `ix_mapDenormalize_solarSystemID` (`solarSystemID`),
  KEY `ix_mapDenormalize_orbitID` (`orbitID`),
  KEY `mapDenormalize_IX_groupConstellation` (`groupID`,`constellationID`),
  KEY `mapDenormalize_IX_groupRegion` (`groupID`,`regionID`),
  KEY `ix_mapDenormalize_regionID` (`regionID`),
  KEY `mapDenormalize_IX_groupSystem` (`groupID`,`solarSystemID`),
  KEY `ix_mapDenormalize_typeID` (`typeID`),
  KEY `ix_mapDenormalize_constellationID` (`constellationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mapDenormalize`
--

LOCK TABLES `mapDenormalize` WRITE;
/*!40000 ALTER TABLE `mapDenormalize` DISABLE KEYS */;
/*!40000 ALTER TABLE `mapDenormalize` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mapJumps`
--
-- 
-- DROP TABLE IF EXISTS `mapJumps`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `mapJumps` (
--   `stargateID` int(11) NOT NULL,
--   `destinationID` int(11) DEFAULT NULL,
--   PRIMARY KEY (`stargateID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `mapJumps`
--
-- 
-- LOCK TABLES `mapJumps` WRITE;
-- /*!40000 ALTER TABLE `mapJumps` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `mapJumps` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `mapLandmarks`
--

DROP TABLE IF EXISTS `mapLandmarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mapLandmarks` (
  `landmarkID` int(11) NOT NULL,
  `landmarkName` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `locationID` int(11) DEFAULT NULL,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `z` double DEFAULT NULL,
  `iconID` int(11) DEFAULT NULL,
  PRIMARY KEY (`landmarkID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mapLandmarks`
--

LOCK TABLES `mapLandmarks` WRITE;
/*!40000 ALTER TABLE `mapLandmarks` DISABLE KEYS */;
/*!40000 ALTER TABLE `mapLandmarks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mapLocationScenes`
--
-- 
-- DROP TABLE IF EXISTS `mapLocationScenes`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `mapLocationScenes` (
--   `locationID` int(11) NOT NULL,
--   `graphicID` int(11) DEFAULT NULL,
--   PRIMARY KEY (`locationID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `mapLocationScenes`
--
-- 
-- LOCK TABLES `mapLocationScenes` WRITE;
-- /*!40000 ALTER TABLE `mapLocationScenes` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `mapLocationScenes` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `mapLocationWormholeClasses`
--
-- 
-- DROP TABLE IF EXISTS `mapLocationWormholeClasses`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `mapLocationWormholeClasses` (
--   `locationID` int(11) NOT NULL,
--   `wormholeClassID` int(11) DEFAULT NULL,
--   PRIMARY KEY (`locationID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `mapLocationWormholeClasses`
--
-- 
-- LOCK TABLES `mapLocationWormholeClasses` WRITE;
-- /*!40000 ALTER TABLE `mapLocationWormholeClasses` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `mapLocationWormholeClasses` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `mapRegionJumps`
--
-- 
-- DROP TABLE IF EXISTS `mapRegionJumps`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `mapRegionJumps` (
--   `fromRegionID` int(11) NOT NULL,
--   `toRegionID` int(11) NOT NULL,
--   PRIMARY KEY (`fromRegionID`,`toRegionID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `mapRegionJumps`
--
-- 
-- LOCK TABLES `mapRegionJumps` WRITE;
-- /*!40000 ALTER TABLE `mapRegionJumps` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `mapRegionJumps` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `mapRegions`
--

DROP TABLE IF EXISTS `mapRegions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mapRegions` (
  `regionID` int(11) NOT NULL,
  `regionName` varchar(100) DEFAULT NULL,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `z` double DEFAULT NULL,
  `xMin` double DEFAULT NULL,
  `xMax` double DEFAULT NULL,
  `yMin` double DEFAULT NULL,
  `yMax` double DEFAULT NULL,
  `zMin` double DEFAULT NULL,
  `zMax` double DEFAULT NULL,
  `factionID` int(11) DEFAULT NULL,
  `nebula` int(11) DEFAULT NULL,
  `radius` float DEFAULT NULL,
  PRIMARY KEY (`regionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mapRegions`
--

LOCK TABLES `mapRegions` WRITE;
/*!40000 ALTER TABLE `mapRegions` DISABLE KEYS */;
/*!40000 ALTER TABLE `mapRegions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mapSolarSystemJumps`
--
-- 
-- DROP TABLE IF EXISTS `mapSolarSystemJumps`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `mapSolarSystemJumps` (
--   `fromRegionID` int(11) DEFAULT NULL,
--   `fromConstellationID` int(11) DEFAULT NULL,
--   `fromSolarSystemID` int(11) NOT NULL,
--   `toSolarSystemID` int(11) NOT NULL,
--   `toConstellationID` int(11) DEFAULT NULL,
--   `toRegionID` int(11) DEFAULT NULL,
--   PRIMARY KEY (`fromSolarSystemID`,`toSolarSystemID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `mapSolarSystemJumps`
--
-- 
-- LOCK TABLES `mapSolarSystemJumps` WRITE;
-- /*!40000 ALTER TABLE `mapSolarSystemJumps` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `mapSolarSystemJumps` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `mapSolarSystems`
--

DROP TABLE IF EXISTS `mapSolarSystems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mapSolarSystems` (
  `regionID` int(11) DEFAULT NULL,
  `constellationID` int(11) DEFAULT NULL,
  `solarSystemID` int(11) NOT NULL,
  `solarSystemName` varchar(100) DEFAULT NULL,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `z` double DEFAULT NULL,
  `xMin` double DEFAULT NULL,
  `xMax` double DEFAULT NULL,
  `yMin` double DEFAULT NULL,
  `yMax` double DEFAULT NULL,
  `zMin` double DEFAULT NULL,
  `zMax` double DEFAULT NULL,
  `luminosity` double DEFAULT NULL,
  `border` tinyint(1) DEFAULT NULL,
  `fringe` tinyint(1) DEFAULT NULL,
  `corridor` tinyint(1) DEFAULT NULL,
  `hub` tinyint(1) DEFAULT NULL,
  `international` tinyint(1) DEFAULT NULL,
  `regional` tinyint(1) DEFAULT NULL,
  `constellation` tinyint(1) DEFAULT NULL,
  `security` double DEFAULT NULL,
  `factionID` int(11) DEFAULT NULL,
  `radius` double DEFAULT NULL,
  `sunTypeID` int(11) DEFAULT NULL,
  `securityClass` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`solarSystemID`),
  KEY `ix_mapSolarSystems_regionID` (`regionID`),
  KEY `ix_mapSolarSystems_security` (`security`),
  KEY `ix_mapSolarSystems_constellationID` (`constellationID`),
  CONSTRAINT `mapss_border` CHECK (`border` in (0,1)),
  CONSTRAINT `mapss_fringe` CHECK (`fringe` in (0,1)),
  CONSTRAINT `mapss_corridor` CHECK (`corridor` in (0,1)),
  CONSTRAINT `mapss_hub` CHECK (`hub` in (0,1)),
  CONSTRAINT `mapss_internat` CHECK (`international` in (0,1)),
  CONSTRAINT `mapss_regional` CHECK (`regional` in (0,1)),
  CONSTRAINT `mapss_constel` CHECK (`constellation` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mapSolarSystems`
--

LOCK TABLES `mapSolarSystems` WRITE;
/*!40000 ALTER TABLE `mapSolarSystems` DISABLE KEYS */;
/*!40000 ALTER TABLE `mapSolarSystems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mapUniverse`
--
-- 
-- DROP TABLE IF EXISTS `mapUniverse`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `mapUniverse` (
--   `universeID` int(11) NOT NULL,
--   `universeName` varchar(100) DEFAULT NULL,
--   `x` double DEFAULT NULL,
--   `y` double DEFAULT NULL,
--   `z` double DEFAULT NULL,
--   `xMin` double DEFAULT NULL,
--   `xMax` double DEFAULT NULL,
--   `yMin` double DEFAULT NULL,
--   `yMax` double DEFAULT NULL,
--   `zMin` double DEFAULT NULL,
--   `zMax` double DEFAULT NULL,
--   `radius` double DEFAULT NULL,
--   PRIMARY KEY (`universeID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `mapUniverse`
--
-- 
-- LOCK TABLES `mapUniverse` WRITE;
-- /*!40000 ALTER TABLE `mapUniverse` DISABLE KEYS */;
-- INSERT INTO `mapUniverse` VALUES (9,'',-7.8414612025763e16,4.00068382454404e16,-1.87911133534779e16,-4.49013589606488e17,2.92184365554962e17,-3.13915018760047e16,1.11405178366885e17,-4.33602446107849e17,4.71184672814804e17,4.52393559461327e17),(9000001,'EVE Wormhole Universe',7.70416391716947e18,1.53937198079579e18,-9.51905586204134e18,7.25177035770814e18,8.1565574766308e18,1.08697842133446e18,1.99176554025711e18,9.06666230258001e18,9.97144942150266e18,4.52393559461327e17);
-- /*!40000 ALTER TABLE `mapUniverse` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `planetSchematics`
--

DROP TABLE IF EXISTS `planetSchematics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `planetSchematics` (
  `schematicID` int(11) NOT NULL,
  `schematicName` varchar(255) DEFAULT NULL,
  `cycleTime` int(11) DEFAULT NULL,
  PRIMARY KEY (`schematicID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planetSchematics`
--

LOCK TABLES `planetSchematics` WRITE;
/*!40000 ALTER TABLE `planetSchematics` DISABLE KEYS */;
/*!40000 ALTER TABLE `planetSchematics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `planetSchematicsPinMap`
--

DROP TABLE IF EXISTS `planetSchematicsPinMap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `planetSchematicsPinMap` (
  `schematicID` int(11) NOT NULL,
  `pinTypeID` int(11) NOT NULL,
  PRIMARY KEY (`schematicID`,`pinTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planetSchematicsPinMap`
--

LOCK TABLES `planetSchematicsPinMap` WRITE;
/*!40000 ALTER TABLE `planetSchematicsPinMap` DISABLE KEYS */;
/*!40000 ALTER TABLE `planetSchematicsPinMap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `planetSchematicsTypeMap`
--

DROP TABLE IF EXISTS `planetSchematicsTypeMap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `planetSchematicsTypeMap` (
  `schematicID` int(11) NOT NULL,
  `typeID` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `isInput` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`schematicID`,`typeID`),
  CONSTRAINT `pstm_input` CHECK (`isInput` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planetSchematicsTypeMap`
--

LOCK TABLES `planetSchematicsTypeMap` WRITE;
/*!40000 ALTER TABLE `planetSchematicsTypeMap` DISABLE KEYS */;
/*!40000 ALTER TABLE `planetSchematicsTypeMap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ramActivities`
--
-- 
-- DROP TABLE IF EXISTS `ramActivities`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `ramActivities` (
--   `activityID` int(11) NOT NULL,
--   `activityName` varchar(100) DEFAULT NULL,
--   `iconNo` varchar(5) DEFAULT NULL,
--   `description` varchar(1000) DEFAULT NULL,
--   `published` tinyint(1) DEFAULT NULL,
--   PRIMARY KEY (`activityID`),
--   CONSTRAINT `ra_pub` CHECK (`published` in (0,1))
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `ramActivities`
--
-- 
-- LOCK TABLES `ramActivities` WRITE;
-- /*!40000 ALTER TABLE `ramActivities` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `ramActivities` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `ramAssemblyLineStations`
--
-- 
-- DROP TABLE IF EXISTS `ramAssemblyLineStations`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `ramAssemblyLineStations` (
--   `stationID` int(11) NOT NULL,
--   `assemblyLineTypeID` int(11) NOT NULL,
--   `quantity` int(11) DEFAULT NULL,
--   `stationTypeID` int(11) DEFAULT NULL,
--   `ownerID` int(11) DEFAULT NULL,
--   `solarSystemID` int(11) DEFAULT NULL,
--   `regionID` int(11) DEFAULT NULL,
--   PRIMARY KEY (`stationID`,`assemblyLineTypeID`),
--   KEY `ix_ramAssemblyLineStations_ownerID` (`ownerID`),
--   KEY `ix_ramAssemblyLineStations_regionID` (`regionID`),
--   KEY `ix_ramAssemblyLineStations_solarSystemID` (`solarSystemID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `ramAssemblyLineStations`
--
-- 
-- LOCK TABLES `ramAssemblyLineStations` WRITE;
-- /*!40000 ALTER TABLE `ramAssemblyLineStations` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `ramAssemblyLineStations` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `ramAssemblyLineTypeDetailPerCategory`
--
-- 
-- DROP TABLE IF EXISTS `ramAssemblyLineTypeDetailPerCategory`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `ramAssemblyLineTypeDetailPerCategory` (
--   `assemblyLineTypeID` int(11) NOT NULL,
--   `categoryID` int(11) NOT NULL,
--   `timeMultiplier` double DEFAULT NULL,
--   `materialMultiplier` double DEFAULT NULL,
--   `costMultiplier` double DEFAULT NULL,
--   PRIMARY KEY (`assemblyLineTypeID`,`categoryID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `ramAssemblyLineTypeDetailPerCategory`
--
-- 
-- LOCK TABLES `ramAssemblyLineTypeDetailPerCategory` WRITE;
-- /*!40000 ALTER TABLE `ramAssemblyLineTypeDetailPerCategory` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `ramAssemblyLineTypeDetailPerCategory` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `ramAssemblyLineTypeDetailPerGroup`
--
-- 
-- DROP TABLE IF EXISTS `ramAssemblyLineTypeDetailPerGroup`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `ramAssemblyLineTypeDetailPerGroup` (
--   `assemblyLineTypeID` int(11) NOT NULL,
--   `groupID` int(11) NOT NULL,
--   `timeMultiplier` double DEFAULT NULL,
--   `materialMultiplier` double DEFAULT NULL,
--   `costMultiplier` double DEFAULT NULL,
--   PRIMARY KEY (`assemblyLineTypeID`,`groupID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `ramAssemblyLineTypeDetailPerGroup`
--
-- 
-- LOCK TABLES `ramAssemblyLineTypeDetailPerGroup` WRITE;
-- /*!40000 ALTER TABLE `ramAssemblyLineTypeDetailPerGroup` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `ramAssemblyLineTypeDetailPerGroup` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `ramAssemblyLineTypes`
--
-- 
-- DROP TABLE IF EXISTS `ramAssemblyLineTypes`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `ramAssemblyLineTypes` (
--   `assemblyLineTypeID` int(11) NOT NULL,
--   `assemblyLineTypeName` varchar(100) DEFAULT NULL,
--   `description` varchar(1000) DEFAULT NULL,
--   `baseTimeMultiplier` double DEFAULT NULL,
--   `baseMaterialMultiplier` double DEFAULT NULL,
--   `baseCostMultiplier` double DEFAULT NULL,
--   `volume` double DEFAULT NULL,
--   `activityID` int(11) DEFAULT NULL,
--   `minCostPerHour` double DEFAULT NULL,
--   PRIMARY KEY (`assemblyLineTypeID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `ramAssemblyLineTypes`
--
-- 
-- LOCK TABLES `ramAssemblyLineTypes` WRITE;
-- /*!40000 ALTER TABLE `ramAssemblyLineTypes` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `ramAssemblyLineTypes` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `ramInstallationTypeContents`
--
-- 
-- DROP TABLE IF EXISTS `ramInstallationTypeContents`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `ramInstallationTypeContents` (
--   `installationTypeID` int(11) NOT NULL,
--   `assemblyLineTypeID` int(11) NOT NULL,
--   `quantity` int(11) DEFAULT NULL,
--   PRIMARY KEY (`installationTypeID`,`assemblyLineTypeID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `ramInstallationTypeContents`
--
-- 
-- LOCK TABLES `ramInstallationTypeContents` WRITE;
-- /*!40000 ALTER TABLE `ramInstallationTypeContents` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `ramInstallationTypeContents` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `skinLicense`
--

DROP TABLE IF EXISTS `skinLicense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skinLicense` (
  `licenseTypeID` int(11) NOT NULL,
  `duration` int(11) DEFAULT NULL,
  `skinID` int(11) DEFAULT NULL,
  PRIMARY KEY (`licenseTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skinLicense`
--

LOCK TABLES `skinLicense` WRITE;
/*!40000 ALTER TABLE `skinLicense` DISABLE KEYS */;
/*!40000 ALTER TABLE `skinLicense` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skinMaterials`
--

DROP TABLE IF EXISTS `skinMaterials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skinMaterials` (
  `skinMaterialID` int(11) NOT NULL,
  `displayNameID` int(11) DEFAULT NULL,
  `materialSetID` int(11) DEFAULT NULL,
  PRIMARY KEY (`skinMaterialID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skinMaterials`
--

LOCK TABLES `skinMaterials` WRITE;
/*!40000 ALTER TABLE `skinMaterials` DISABLE KEYS */;
/*!40000 ALTER TABLE `skinMaterials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skinShip`
--

DROP TABLE IF EXISTS `skinShip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skinShip` (
  `skinID` int(11) DEFAULT NULL,
  `typeID` int(11) DEFAULT NULL,
  KEY `ix_skinShip_skinID` (`skinID`),
  KEY `ix_skinShip_typeID` (`typeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skinShip`
--

LOCK TABLES `skinShip` WRITE;
/*!40000 ALTER TABLE `skinShip` DISABLE KEYS */;
/*!40000 ALTER TABLE `skinShip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skins`
--
-- 
-- DROP TABLE IF EXISTS `skins`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `skins` (
--   `skinID` int(11) NOT NULL,
--   `internalName` varchar(70) DEFAULT NULL,
--   `skinMaterialID` int(11) DEFAULT NULL,
--   PRIMARY KEY (`skinID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `skins`
--
-- 
-- LOCK TABLES `skins` WRITE;
-- /*!40000 ALTER TABLE `skins` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `skins` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `staOperationServices`
--
-- 
-- DROP TABLE IF EXISTS `staOperationServices`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `staOperationServices` (
--   `operationID` int(11) NOT NULL,
--   `serviceID` int(11) NOT NULL,
--   PRIMARY KEY (`operationID`,`serviceID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `staOperationServices`
--
-- 
-- LOCK TABLES `staOperationServices` WRITE;
-- /*!40000 ALTER TABLE `staOperationServices` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `staOperationServices` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `staOperations`
--
-- 
-- DROP TABLE IF EXISTS `staOperations`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `staOperations` (
--   `activityID` int(11) DEFAULT NULL,
--   `operationID` int(11) NOT NULL,
--   `operationName` varchar(100) DEFAULT NULL,
--   `description` varchar(1000) DEFAULT NULL,
--   `fringe` int(11) DEFAULT NULL,
--   `corridor` int(11) DEFAULT NULL,
--   `hub` int(11) DEFAULT NULL,
--   `border` int(11) DEFAULT NULL,
--   `ratio` int(11) DEFAULT NULL,
--   `caldariStationTypeID` int(11) DEFAULT NULL,
--   `minmatarStationTypeID` int(11) DEFAULT NULL,
--   `amarrStationTypeID` int(11) DEFAULT NULL,
--   `gallenteStationTypeID` int(11) DEFAULT NULL,
--   `joveStationTypeID` int(11) DEFAULT NULL,
--   PRIMARY KEY (`operationID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `staOperations`
--
-- 
-- LOCK TABLES `staOperations` WRITE;
-- /*!40000 ALTER TABLE `staOperations` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `staOperations` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `staServices`
--
-- 
-- DROP TABLE IF EXISTS `staServices`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `staServices` (
--   `serviceID` int(11) NOT NULL,
--   `serviceName` varchar(100) DEFAULT NULL,
--   `description` varchar(1000) DEFAULT NULL,
--   PRIMARY KEY (`serviceID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `staServices`
--
-- 
-- LOCK TABLES `staServices` WRITE;
-- /*!40000 ALTER TABLE `staServices` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `staServices` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `staStationTypes`
--
-- 
-- DROP TABLE IF EXISTS `staStationTypes`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `staStationTypes` (
--   `stationTypeID` int(11) NOT NULL,
--   `dockEntryX` double DEFAULT NULL,
--   `dockEntryY` double DEFAULT NULL,
--   `dockEntryZ` double DEFAULT NULL,
--   `dockOrientationX` double DEFAULT NULL,
--   `dockOrientationY` double DEFAULT NULL,
--   `dockOrientationZ` double DEFAULT NULL,
--   `operationID` int(11) DEFAULT NULL,
--   `officeSlots` int(11) DEFAULT NULL,
--   `reprocessingEfficiency` double DEFAULT NULL,
--   `conquerable` tinyint(1) DEFAULT NULL,
--   PRIMARY KEY (`stationTypeID`),
--   CONSTRAINT `stastat_conq` CHECK (`conquerable` in (0,1))
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `staStationTypes`
--
-- 
-- LOCK TABLES `staStationTypes` WRITE;
-- /*!40000 ALTER TABLE `staStationTypes` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `staStationTypes` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `staStations`
--

DROP TABLE IF EXISTS `staStations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staStations` (
  `stationID` bigint(20) NOT NULL,
  `security` double DEFAULT NULL,
  `dockingCostPerVolume` double DEFAULT NULL,
  `maxShipVolumeDockable` double DEFAULT NULL,
  `officeRentalCost` int(11) DEFAULT NULL,
  `operationID` int(11) DEFAULT NULL,
  `stationTypeID` int(11) DEFAULT NULL,
  `corporationID` int(11) DEFAULT NULL,
  `solarSystemID` int(11) DEFAULT NULL,
  `constellationID` int(11) DEFAULT NULL,
  `regionID` int(11) DEFAULT NULL,
  `stationName` varchar(100) DEFAULT NULL,
  `x` double DEFAULT NULL,
  `y` double DEFAULT NULL,
  `z` double DEFAULT NULL,
  `reprocessingEfficiency` double DEFAULT NULL,
  `reprocessingStationsTake` double DEFAULT NULL,
  `reprocessingHangarFlag` int(11) DEFAULT NULL,
  PRIMARY KEY (`stationID`),
  KEY `ix_staStations_stationTypeID` (`stationTypeID`),
  KEY `ix_staStations_constellationID` (`constellationID`),
  KEY `ix_staStations_corporationID` (`corporationID`),
  KEY `ix_staStations_regionID` (`regionID`),
  KEY `ix_staStations_solarSystemID` (`solarSystemID`),
  KEY `ix_staStations_operationID` (`operationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staStations`
--

LOCK TABLES `staStations` WRITE;
/*!40000 ALTER TABLE `staStations` DISABLE KEYS */;
/*!40000 ALTER TABLE `staStations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `translationTables`
--
-- 
-- DROP TABLE IF EXISTS `translationTables`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `translationTables` (
--   `sourceTable` varchar(200) NOT NULL,
--   `destinationTable` varchar(200) DEFAULT NULL,
--   `translatedKey` varchar(200) NOT NULL,
--   `tcGroupID` int(11) DEFAULT NULL,
--   `tcID` int(11) DEFAULT NULL,
--   PRIMARY KEY (`sourceTable`,`translatedKey`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `translationTables`
--
-- 
-- LOCK TABLES `translationTables` WRITE;
-- /*!40000 ALTER TABLE `translationTables` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `translationTables` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `trnTranslationColumns`
--
-- 
-- DROP TABLE IF EXISTS `trnTranslationColumns`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `trnTranslationColumns` (
--   `tcGroupID` int(11) DEFAULT NULL,
--   `tcID` int(11) NOT NULL,
--   `tableName` varchar(256) NOT NULL,
--   `columnName` varchar(128) NOT NULL,
--   `masterID` varchar(128) DEFAULT NULL,
--   PRIMARY KEY (`tcID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `trnTranslationColumns`
--
-- 
-- LOCK TABLES `trnTranslationColumns` WRITE;
-- /*!40000 ALTER TABLE `trnTranslationColumns` DISABLE KEYS */;
-- INSERT INTO `trnTranslationColumns` VALUES (4,6,'dbo.invCategories','categoryName','categoryID'),(5,7,'dbo.invGroups','groupName','groupID'),(5,8,'dbo.invTypes','typeName','typeID'),(7,9,'dbo.chrRaces','raceName','raceID'),(7,10,'dbo.chrRaces','description','raceID'),(8,11,'dbo.chrBloodlines','bloodlineName','bloodlineID'),(8,12,'dbo.chrBloodlines','description','bloodlineID'),(9,15,'dbo.chrAncestries','ancestryName','ancestryID'),(9,16,'dbo.chrAncestries','description','ancestryID'),(16,29,'dbo.chrFactions','description','factionID'),(5,33,'dbo.invTypes','description','typeID'),(6,34,'dbo.invMetaGroups','metaGroupName','metaGroupID'),(6,35,'dbo.invMetaGroups','description','metaGroupID'),(28,36,'dbo.invMarketGroups','marketGroupName','marketGroupID'),(28,37,'dbo.invMarketGroups','description','marketGroupID'),(33,45,'dbo.crpActivities','activityName','activityID'),(34,46,'dbo.staOperations','operationName','operationID'),(34,47,'dbo.staOperations','description','operationID'),(35,48,'dbo.staServices','serviceName','serviceID'),(35,49,'dbo.staServices','description','serviceID'),(41,58,'dbo.eveUnits','displayName','unitID'),(42,59,'dbo.dgmAttributeTypes','displayName','attributeID'),(46,63,'dbo.mapLandmarks','landmarkName','landmarkID'),(46,64,'dbo.mapLandmarks','description','landmarkID'),(47,65,'dbo.crpNPCDivisions','divisionName','divisionID'),(47,66,'dbo.crpNPCDivisions','leaderType','divisionID'),(53,74,'dbo.dgmEffects','displayName','effectID'),(53,75,'dbo.dgmEffects','description','effectID'),(65,100,'dbo.ramActivities','activityName','activityID'),(65,101,'dbo.ramActivities','description','activityID'),(84,119,'dbo.planetSchematics','schematicName','schematicID'),(41,122,'dbo.eveUnits','description','unitID'),(16,127,'dbo.chrFactions','factionName','factionID'),(64,138,'dbo.crpNPCCorporations','description','corporationID');
-- /*!40000 ALTER TABLE `trnTranslationColumns` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `trnTranslationLanguages`
--
-- 
-- DROP TABLE IF EXISTS `trnTranslationLanguages`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `trnTranslationLanguages` (
--   `numericLanguageID` int(11) NOT NULL,
--   `languageID` varchar(50) DEFAULT NULL,
--   `languageName` varchar(200) DEFAULT NULL,
--   PRIMARY KEY (`numericLanguageID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `trnTranslationLanguages`
--
-- 
-- LOCK TABLES `trnTranslationLanguages` WRITE;
-- /*!40000 ALTER TABLE `trnTranslationLanguages` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `trnTranslationLanguages` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `trnTranslations`
--

DROP TABLE IF EXISTS `trnTranslations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trnTranslations` (
  `tcID` int(11) NOT NULL,
  `keyID` int(11) NOT NULL,
  `languageID` varchar(50) NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`tcID`,`keyID`,`languageID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trnTranslations`
--

LOCK TABLES `trnTranslations` WRITE;
/*!40000 ALTER TABLE `trnTranslations` DISABLE KEYS */;
/*!40000 ALTER TABLE `trnTranslations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warCombatZoneSystems`
--
-- 
-- DROP TABLE IF EXISTS `warCombatZoneSystems`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `warCombatZoneSystems` (
--   `solarSystemID` int(11) NOT NULL,
--   `combatZoneID` int(11) DEFAULT NULL,
--   PRIMARY KEY (`solarSystemID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `warCombatZoneSystems`
--
-- 
-- LOCK TABLES `warCombatZoneSystems` WRITE;
-- /*!40000 ALTER TABLE `warCombatZoneSystems` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `warCombatZoneSystems` ENABLE KEYS */;
-- UNLOCK TABLES;
-- 
--
-- Table structure for table `warCombatZones`
--
-- 
-- DROP TABLE IF EXISTS `warCombatZones`;
-- /*!40101 SET @saved_cs_client     = @@character_set_client */;
-- /*!40101 SET character_set_client = utf8 */;
-- CREATE TABLE `warCombatZones` (
--   `combatZoneID` int(11) NOT NULL,
--   `combatZoneName` varchar(100) DEFAULT NULL,
--   `factionID` int(11) DEFAULT NULL,
--   `centerSystemID` int(11) DEFAULT NULL,
--   `description` varchar(500) DEFAULT NULL,
--   PRIMARY KEY (`combatZoneID`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- /*!40101 SET character_set_client = @saved_cs_client */;
-- 
--
-- Dumping data for table `warCombatZones`
--
-- 
-- LOCK TABLES `warCombatZones` WRITE;
-- /*!40000 ALTER TABLE `warCombatZones` DISABLE KEYS */;
-- /*!40000 ALTER TABLE `warCombatZones` ENABLE KEYS */;
-- UNLOCK TABLES;
-- /*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
-- 
-- /*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
-- /*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
-- /*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
-- /*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
-- /*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
-- /*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
-- /*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
-- 
-- Dump completed on 2025-07-07 17:47:07
-- 