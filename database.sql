-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `game`
--

DROP TABLE IF EXISTS `game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game` (
  `idGame` int NOT NULL,
  `Season_idSeason` int NOT NULL,
  `Stadium_idStadium` int NOT NULL,
  `headidReferee` int NOT NULL,
  `date` varchar(45) DEFAULT NULL,
  `starttime` varchar(45) DEFAULT NULL,
  `weather` varchar(45) DEFAULT NULL,
  `attendance` varchar(45) DEFAULT NULL,
  `totalscoreHome` int DEFAULT NULL,
  `totalscoreAway` int DEFAULT NULL,
  PRIMARY KEY (`idGame`,`Season_idSeason`),
  KEY `fk_Game_Season1_idx` (`Season_idSeason`),
  KEY `fk_Game_Stadium1_idx` (`Stadium_idStadium`),
  CONSTRAINT `fk_Game_Season1` FOREIGN KEY (`Season_idSeason`) REFERENCES `season` (`idSeason`),
  CONSTRAINT `fk_Game_Stadium1` FOREIGN KEY (`Stadium_idStadium`) REFERENCES `stadium` (`idStadium`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game`
--

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
/*!40000 ALTER TABLE `game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_has_referee`
--

DROP TABLE IF EXISTS `game_has_referee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_has_referee` (
  `Game_idGame` int NOT NULL,
  `Game_Season_idSeason` int NOT NULL,
  `Referee_idReferee` int NOT NULL,
  PRIMARY KEY (`Game_idGame`,`Game_Season_idSeason`,`Referee_idReferee`),
  KEY `fk_Game_has_Referee_Referee1_idx` (`Referee_idReferee`),
  KEY `fk_Game_has_Referee_Game1_idx` (`Game_idGame`,`Game_Season_idSeason`),
  CONSTRAINT `fk_Game_has_Referee_Game1` FOREIGN KEY (`Game_idGame`, `Game_Season_idSeason`) REFERENCES `game` (`idGame`, `Season_idSeason`),
  CONSTRAINT `fk_Game_has_Referee_Referee1` FOREIGN KEY (`Referee_idReferee`) REFERENCES `referee` (`idReferee`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_has_referee`
--

LOCK TABLES `game_has_referee` WRITE;
/*!40000 ALTER TABLE `game_has_referee` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_has_referee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game_has_team`
--

DROP TABLE IF EXISTS `game_has_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game_has_team` (
  `Game_idGame` int NOT NULL,
  `Team_idTeam` int NOT NULL,
  `yardsgained` int DEFAULT NULL,
  `turnovers` int DEFAULT NULL,
  `penalities` int DEFAULT NULL,
  `possessiontime` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Game_idGame`,`Team_idTeam`),
  KEY `fk_Game_has_Team_Team1_idx` (`Team_idTeam`),
  KEY `fk_Game_has_Team_Game_idx` (`Game_idGame`),
  CONSTRAINT `fk_Game_has_Team_Game` FOREIGN KEY (`Game_idGame`) REFERENCES `game` (`idGame`),
  CONSTRAINT `fk_Game_has_Team_Team1` FOREIGN KEY (`Team_idTeam`) REFERENCES `team` (`idTeam`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game_has_team`
--

LOCK TABLES `game_has_team` WRITE;
/*!40000 ALTER TABLE `game_has_team` DISABLE KEYS */;
/*!40000 ALTER TABLE `game_has_team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `head_coach`
--

DROP TABLE IF EXISTS `head_coach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `head_coach` (
  `idCoach` int NOT NULL AUTO_INCREMENT,
  `fname` varchar(45) DEFAULT NULL,
  `lname` varchar(45) DEFAULT NULL,
  `startyear` varchar(45) DEFAULT NULL,
  `endyear` varchar(45) DEFAULT NULL,
  `season` varchar(45) DEFAULT NULL,
  `Team_idTeam` int NOT NULL,
  PRIMARY KEY (`idCoach`,`Team_idTeam`),
  KEY `fk_Coach_Team1_idx` (`Team_idTeam`),
  CONSTRAINT `fk_Coach_Team1` FOREIGN KEY (`Team_idTeam`) REFERENCES `team` (`idTeam`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `head_coach`
--

LOCK TABLES `head_coach` WRITE;
/*!40000 ALTER TABLE `head_coach` DISABLE KEYS */;
/*!40000 ALTER TABLE `head_coach` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_stats`
--

DROP TABLE IF EXISTS `player_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player_stats` (
  `Game_idGame` int NOT NULL,
  `Players_idplayers` int NOT NULL,
  `Touchdowns` int DEFAULT NULL,
  `Yards` int DEFAULT NULL,
  `Completions` int DEFAULT NULL,
  `Interceptions` int DEFAULT NULL,
  `Tackles` int DEFAULT NULL,
  PRIMARY KEY (`Game_idGame`,`Players_idplayers`),
  KEY `fk_Game_has_Players_Players1_idx` (`Players_idplayers`),
  KEY `fk_Game_has_Players_Game1_idx` (`Game_idGame`),
  CONSTRAINT `fk_Game_has_Players_Game1` FOREIGN KEY (`Game_idGame`) REFERENCES `game` (`idGame`),
  CONSTRAINT `fk_Game_has_Players_Players1` FOREIGN KEY (`Players_idplayers`) REFERENCES `players` (`idplayers`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_stats`
--

LOCK TABLES `player_stats` WRITE;
/*!40000 ALTER TABLE `player_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `players` (
  `idplayers` int NOT NULL,
  `fname` varchar(45) DEFAULT NULL,
  `lname` varchar(45) DEFAULT NULL,
  `jerseynumber` int DEFAULT NULL,
  `position` varchar(45) DEFAULT NULL,
  `classyear` varchar(45) DEFAULT NULL,
  `Team_idTeam` int NOT NULL,
  PRIMARY KEY (`idplayers`),
  KEY `fk_players_Team1_idx` (`Team_idTeam`),
  CONSTRAINT `fk_players_Team1` FOREIGN KEY (`Team_idTeam`) REFERENCES `team` (`idTeam`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `players`
--

LOCK TABLES `players` WRITE;
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
/*!40000 ALTER TABLE `players` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `referee`
--

DROP TABLE IF EXISTS `referee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referee` (
  `idReferee` int NOT NULL,
  `refereename` varchar(45) DEFAULT NULL,
  `experience` varchar(45) DEFAULT NULL,
  `region` varchar(45) DEFAULT NULL,
  `role` varchar(45) DEFAULT NULL,
  `headrefid` int NOT NULL,
  PRIMARY KEY (`idReferee`,`headrefid`),
  KEY `fk_Referee_Referee1_idx` (`headrefid`),
  CONSTRAINT `fk_Referee_Referee1` FOREIGN KEY (`headrefid`) REFERENCES `referee` (`idReferee`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `referee`
--

LOCK TABLES `referee` WRITE;
/*!40000 ALTER TABLE `referee` DISABLE KEYS */;
/*!40000 ALTER TABLE `referee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `season`
--

DROP TABLE IF EXISTS `season`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `season` (
  `idSeason` int NOT NULL,
  `year` varchar(45) DEFAULT NULL,
  `startdate` varchar(45) DEFAULT NULL,
  `enddate` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idSeason`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `season`
--

LOCK TABLES `season` WRITE;
/*!40000 ALTER TABLE `season` DISABLE KEYS */;
/*!40000 ALTER TABLE `season` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stadium`
--

DROP TABLE IF EXISTS `stadium`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stadium` (
  `idStadium` int NOT NULL,
  `stadiumname` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  PRIMARY KEY (`idStadium`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stadium`
--

LOCK TABLES `stadium` WRITE;
/*!40000 ALTER TABLE `stadium` DISABLE KEYS */;
/*!40000 ALTER TABLE `stadium` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team` (
  `idTeam` int NOT NULL,
  `teamname` varchar(45) DEFAULT NULL,
  `mascot` varchar(45) DEFAULT NULL,
  `confrence` varchar(45) DEFAULT NULL,
  `homestadiumID` int DEFAULT NULL,
  PRIMARY KEY (`idTeam`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team_matchup`
--

DROP TABLE IF EXISTS `team_matchup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team_matchup` (
  `HomeTeamID` int NOT NULL,
  `AwayTeamID` int NOT NULL,
  PRIMARY KEY (`HomeTeamID`,`AwayTeamID`),
  KEY `fk_Team_has_Team_Team2_idx` (`AwayTeamID`),
  KEY `fk_Team_has_Team_Team1_idx` (`HomeTeamID`),
  CONSTRAINT `fk_Team_has_Team_Team1` FOREIGN KEY (`HomeTeamID`) REFERENCES `team` (`idTeam`),
  CONSTRAINT `fk_Team_has_Team_Team2` FOREIGN KEY (`AwayTeamID`) REFERENCES `team` (`idTeam`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_matchup`
--

LOCK TABLES `team_matchup` WRITE;
/*!40000 ALTER TABLE `team_matchup` DISABLE KEYS */;
/*!40000 ALTER TABLE `team_matchup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team_season_performance`
--

DROP TABLE IF EXISTS `team_season_performance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team_season_performance` (
  `Season_idSeason` int NOT NULL,
  `Team_idTeam` int NOT NULL,
  `wins` int DEFAULT NULL,
  `losses` int DEFAULT NULL,
  `pointsscored` int DEFAULT NULL,
  `pointsallowed` int DEFAULT NULL,
  PRIMARY KEY (`Season_idSeason`,`Team_idTeam`),
  KEY `fk_Season_has_Team_Team1_idx` (`Team_idTeam`),
  KEY `fk_Season_has_Team_Season1_idx` (`Season_idSeason`),
  CONSTRAINT `fk_Season_has_Team_Season1` FOREIGN KEY (`Season_idSeason`) REFERENCES `season` (`idSeason`),
  CONSTRAINT `fk_Season_has_Team_Team1` FOREIGN KEY (`Team_idTeam`) REFERENCES `team` (`idTeam`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_season_performance`
--

LOCK TABLES `team_season_performance` WRITE;
/*!40000 ALTER TABLE `team_season_performance` DISABLE KEYS */;
/*!40000 ALTER TABLE `team_season_performance` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-25 17:05:53

