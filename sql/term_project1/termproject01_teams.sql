-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: termproject01
-- ------------------------------------------------------
-- Server version	8.4.2

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
-- Table structure for table `teams`
--

DROP TABLE IF EXISTS `teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teams` (
  `team_code` varchar(5) NOT NULL,
  `full_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`team_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams`
--

LOCK TABLES `teams` WRITE;
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
INSERT INTO `teams` VALUES ('AFM','Atlanta Flames'),('ANA','Anaheim Ducks'),('ARI','Arizona Coyotes'),('ATL','Atlanta Thrashers'),('BOS','Boston Bruins'),('BRK','Brooklyn Americans'),('BUF','Buffalo Sabres'),('CAR','Carolina Hurricanes'),('CBJ','Columbus Blue Jackets'),('CGS','California Golden Seals'),('CGY','Calgary Flames'),('CHI','Chicago Blackhawks'),('CLE','Cleveland Barons'),('CLR','Colorado Rockies'),('COL','Colorado Avalanche'),('DAL','Dallas Stars'),('DCG','Detroit Cougars'),('DET','Detroit Red Wings'),('DFL','Detroit Falcons'),('EDM','Edmonton Oilers'),('FLA','Florida Panthers'),('HAM','Hamilton Tigers'),('HFD','Hartford Whalers'),('KCS','Kansas City Scouts'),('LAK','Los Angeles Kings'),('MIN','Minnesota Wild'),('MMR','Montreal Maroons'),('MNS','Minnesota North Stars'),('MTL','Montréal Canadiens'),('MWN','Montreal Wanderers'),('NHL','NHL'),('NJD','New Jersey Devils'),('NSH','Nashville Predators'),('NYA','New York Americans'),('NYI','New York Islanders'),('NYR','New York Rangers'),('OAK','Oakland Seals'),('OTT','Ottawa Senators'),('PHI','Philadelphia Flyers'),('PHX','Phoenix Coyotes'),('PIR','Pittsburgh Pirates'),('PIT','Pittsburgh Penguins'),('QBD','Quebec Bulldogs'),('QUA','Philadelphia Quakers'),('QUE','Quebec Nordiques'),('SEA','Seattle Kraken'),('SEN','Ottawa Senators (1917)'),('SJS','San Jose Sharks'),('SLE','St. Louis Eagles'),('STL','St. Louis Blues'),('TAN','Toronto Arenas'),('TBL','Tampa Bay Lightning'),('TOR','Toronto Maple Leafs'),('TSP','Toronto St. Patricks'),('VAN','Vancouver Canucks'),('VGK','Vegas Golden Knights'),('WIN','Winnipeg Jets (1979)'),('WPG','Winnipeg Jets'),('WSH','Washington Capitals');
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-25 14:09:03
