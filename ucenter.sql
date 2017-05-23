-- MySQL dump 10.13  Distrib 5.6.36, for Linux (x86_64)
--
-- Host: localhost    Database: ucenter
-- ------------------------------------------------------
-- Server version	5.6.36-log

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
-- Table structure for table `uc_admins`
--

DROP TABLE IF EXISTS `uc_admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_admins` (
  `uid` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `username` char(15) NOT NULL DEFAULT '',
  `allowadminsetting` tinyint(1) NOT NULL DEFAULT '0',
  `allowadminapp` tinyint(1) NOT NULL DEFAULT '0',
  `allowadminuser` tinyint(1) NOT NULL DEFAULT '0',
  `allowadminbadword` tinyint(1) NOT NULL DEFAULT '0',
  `allowadmintag` tinyint(1) NOT NULL DEFAULT '0',
  `allowadminpm` tinyint(1) NOT NULL DEFAULT '0',
  `allowadmincredits` tinyint(1) NOT NULL DEFAULT '0',
  `allowadmindomain` tinyint(1) NOT NULL DEFAULT '0',
  `allowadmindb` tinyint(1) NOT NULL DEFAULT '0',
  `allowadminnote` tinyint(1) NOT NULL DEFAULT '0',
  `allowadmincache` tinyint(1) NOT NULL DEFAULT '0',
  `allowadminlog` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_admins`
--

LOCK TABLES `uc_admins` WRITE;
/*!40000 ALTER TABLE `uc_admins` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_applications`
--

DROP TABLE IF EXISTS `uc_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_applications` (
  `appid` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(16) NOT NULL DEFAULT '',
  `name` varchar(20) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `authkey` varchar(255) NOT NULL DEFAULT '',
  `ip` varchar(15) NOT NULL DEFAULT '',
  `viewprourl` varchar(255) NOT NULL,
  `apifilename` varchar(30) NOT NULL DEFAULT 'uc.php',
  `charset` varchar(8) NOT NULL DEFAULT '',
  `dbcharset` varchar(8) NOT NULL DEFAULT '',
  `synlogin` tinyint(1) NOT NULL DEFAULT '0',
  `recvnote` tinyint(1) DEFAULT '0',
  `extra` text NOT NULL,
  `tagtemplates` text NOT NULL,
  `allowips` text NOT NULL,
  PRIMARY KEY (`appid`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_applications`
--

LOCK TABLES `uc_applications` WRITE;
/*!40000 ALTER TABLE `uc_applications` DISABLE KEYS */;
INSERT INTO `uc_applications` VALUES (1,'OTHER','boheofficial','http://test.zhenweitech.cn:8000','8744auNbmi0S2PQOcHA7BY1Ph/fFQ1tML+y7vaf4vbAGyDPlXDNmE+2IRLwt2BcVm6pXR5lzZNZ7Zq1tkPCc1fwCICU','','','ucapi','','',1,0,'a:2:{s:7:\"apppath\";s:0:\"\";s:8:\"extraurl\";a:0:{}}','<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\r\n<root>\r\n	<item id=\"template\"><![CDATA[]]></item>\r\n</root>',''),(2,'OTHER','bohemint','http://test.zhenweitech.cn/mintAdmin/index.php/UCenter','8d8b8/J+Y/XD5H2GBec/4cwqcKt0bG5tAUnQ4j4Yihm0pJLj9RZKj/s4M1FgpEA37M67kHaFV9sxV9rkzHtDCjPHBF0','','','uc','','',1,0,'a:2:{s:7:\"apppath\";s:0:\"\";s:8:\"extraurl\";a:0:{}}','<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\r\n<root>\r\n	<item id=\"template\"><![CDATA[]]></item>\r\n</root>','');
/*!40000 ALTER TABLE `uc_applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_badwords`
--

DROP TABLE IF EXISTS `uc_badwords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_badwords` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `admin` varchar(15) NOT NULL DEFAULT '',
  `find` varchar(255) NOT NULL DEFAULT '',
  `replacement` varchar(255) NOT NULL DEFAULT '',
  `findpattern` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `find` (`find`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_badwords`
--

LOCK TABLES `uc_badwords` WRITE;
/*!40000 ALTER TABLE `uc_badwords` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_badwords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_domains`
--

DROP TABLE IF EXISTS `uc_domains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_domains` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain` char(40) NOT NULL DEFAULT '',
  `ip` char(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_domains`
--

LOCK TABLES `uc_domains` WRITE;
/*!40000 ALTER TABLE `uc_domains` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_domains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_failedlogins`
--

DROP TABLE IF EXISTS `uc_failedlogins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_failedlogins` (
  `ip` char(15) NOT NULL DEFAULT '',
  `count` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `lastupdate` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_failedlogins`
--

LOCK TABLES `uc_failedlogins` WRITE;
/*!40000 ALTER TABLE `uc_failedlogins` DISABLE KEYS */;
INSERT INTO `uc_failedlogins` VALUES ('49.4.178.50',1,1494557252);
/*!40000 ALTER TABLE `uc_failedlogins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_feeds`
--

DROP TABLE IF EXISTS `uc_feeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_feeds` (
  `feedid` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `appid` varchar(30) NOT NULL DEFAULT '',
  `icon` varchar(30) NOT NULL DEFAULT '',
  `uid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `username` varchar(15) NOT NULL DEFAULT '',
  `dateline` int(10) unsigned NOT NULL DEFAULT '0',
  `hash_template` varchar(32) NOT NULL DEFAULT '',
  `hash_data` varchar(32) NOT NULL DEFAULT '',
  `title_template` text NOT NULL,
  `title_data` text NOT NULL,
  `body_template` text NOT NULL,
  `body_data` text NOT NULL,
  `body_general` text NOT NULL,
  `image_1` varchar(255) NOT NULL DEFAULT '',
  `image_1_link` varchar(255) NOT NULL DEFAULT '',
  `image_2` varchar(255) NOT NULL DEFAULT '',
  `image_2_link` varchar(255) NOT NULL DEFAULT '',
  `image_3` varchar(255) NOT NULL DEFAULT '',
  `image_3_link` varchar(255) NOT NULL DEFAULT '',
  `image_4` varchar(255) NOT NULL DEFAULT '',
  `image_4_link` varchar(255) NOT NULL DEFAULT '',
  `target_ids` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`feedid`),
  KEY `uid` (`uid`,`dateline`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_feeds`
--

LOCK TABLES `uc_feeds` WRITE;
/*!40000 ALTER TABLE `uc_feeds` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_feeds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_friends`
--

DROP TABLE IF EXISTS `uc_friends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_friends` (
  `uid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `friendid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `direction` tinyint(1) NOT NULL DEFAULT '0',
  `version` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `delstatus` tinyint(1) NOT NULL DEFAULT '0',
  `comment` char(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`version`),
  KEY `uid` (`uid`),
  KEY `friendid` (`friendid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_friends`
--

LOCK TABLES `uc_friends` WRITE;
/*!40000 ALTER TABLE `uc_friends` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_friends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_mailqueue`
--

DROP TABLE IF EXISTS `uc_mailqueue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_mailqueue` (
  `mailid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `touid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `tomail` varchar(32) NOT NULL,
  `frommail` varchar(100) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `charset` varchar(15) NOT NULL,
  `htmlon` tinyint(1) NOT NULL DEFAULT '0',
  `level` tinyint(1) NOT NULL DEFAULT '1',
  `dateline` int(10) unsigned NOT NULL DEFAULT '0',
  `failures` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `appid` smallint(6) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`mailid`),
  KEY `appid` (`appid`),
  KEY `level` (`level`,`failures`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_mailqueue`
--

LOCK TABLES `uc_mailqueue` WRITE;
/*!40000 ALTER TABLE `uc_mailqueue` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_mailqueue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_memberfields`
--

DROP TABLE IF EXISTS `uc_memberfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_memberfields` (
  `uid` mediumint(8) unsigned NOT NULL,
  `blacklist` text NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_memberfields`
--

LOCK TABLES `uc_memberfields` WRITE;
/*!40000 ALTER TABLE `uc_memberfields` DISABLE KEYS */;
INSERT INTO `uc_memberfields` VALUES (12,''),(7,''),(11,'');
/*!40000 ALTER TABLE `uc_memberfields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_members`
--

DROP TABLE IF EXISTS `uc_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_members` (
  `uid` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `username` char(32) NOT NULL,
  `password` char(32) NOT NULL DEFAULT '',
  `email` char(32) NOT NULL DEFAULT '',
  `myid` char(30) NOT NULL DEFAULT '',
  `myidkey` char(16) NOT NULL DEFAULT '',
  `regip` char(15) NOT NULL DEFAULT '',
  `regdate` int(10) unsigned NOT NULL DEFAULT '0',
  `lastloginip` int(10) NOT NULL DEFAULT '0',
  `lastlogintime` int(10) unsigned NOT NULL DEFAULT '0',
  `salt` char(6) NOT NULL,
  `secques` char(8) NOT NULL DEFAULT '',
  `phone` char(100) DEFAULT '',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `username` (`username`),
  KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_members`
--

LOCK TABLES `uc_members` WRITE;
/*!40000 ALTER TABLE `uc_members` DISABLE KEYS */;
INSERT INTO `uc_members` VALUES (7,'f1c605f05fd7fe91d45a503ffb930b54','d279fa859659dcce10fee85eaab5d081','13820108691@bohe.com','','','49.4.178.50',1494856587,0,0,'b4a4c0','','13820108691'),(12,'5e92e3f713bcad6088c8b4332b3d3b09','e3c2d455ecb6700eef7982ec06d93a08','15810812531@bohe.com','','','49.4.178.50',1494927929,0,0,'9b61f7','','15810812531'),(11,'2384a9de96b96d1807802908f1f99f52','b108c66ed6d60097d60e5ff88fdee85e','18910907174@bohe.com','','','49.4.178.50',1494919446,0,0,'622f6d','','18910907174');
/*!40000 ALTER TABLE `uc_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_mergemembers`
--

DROP TABLE IF EXISTS `uc_mergemembers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_mergemembers` (
  `appid` smallint(6) unsigned NOT NULL,
  `username` char(15) NOT NULL,
  PRIMARY KEY (`appid`,`username`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_mergemembers`
--

LOCK TABLES `uc_mergemembers` WRITE;
/*!40000 ALTER TABLE `uc_mergemembers` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_mergemembers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_newpm`
--

DROP TABLE IF EXISTS `uc_newpm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_newpm` (
  `uid` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_newpm`
--

LOCK TABLES `uc_newpm` WRITE;
/*!40000 ALTER TABLE `uc_newpm` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_newpm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_notelist`
--

DROP TABLE IF EXISTS `uc_notelist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_notelist` (
  `noteid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `operation` char(32) NOT NULL,
  `closed` tinyint(4) NOT NULL DEFAULT '0',
  `totalnum` smallint(6) unsigned NOT NULL DEFAULT '0',
  `succeednum` smallint(6) unsigned NOT NULL DEFAULT '0',
  `getdata` mediumtext NOT NULL,
  `postdata` mediumtext NOT NULL,
  `dateline` int(10) unsigned NOT NULL DEFAULT '0',
  `pri` tinyint(3) NOT NULL DEFAULT '0',
  `app1` tinyint(4) NOT NULL,
  `app2` tinyint(4) NOT NULL,
  PRIMARY KEY (`noteid`),
  KEY `closed` (`closed`,`pri`,`noteid`),
  KEY `dateline` (`dateline`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_notelist`
--

LOCK TABLES `uc_notelist` WRITE;
/*!40000 ALTER TABLE `uc_notelist` DISABLE KEYS */;
INSERT INTO `uc_notelist` VALUES (1,'updateapps',1,0,0,'','<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\r\n<root>\r\n	<item id=\"1\">\r\n		<item id=\"appid\"><![CDATA[1]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[boheofficial]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn:8000]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[ucapi]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"UC_API\"><![CDATA[http://test.zhenweitech.cn:8810]]></item>\r\n</root>',0,0,0,0),(2,'updateapps',1,0,0,'','<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\r\n<root>\r\n	<item id=\"1\">\r\n		<item id=\"appid\"><![CDATA[1]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[boheofficial]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn:8000]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[ucapi]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"2\">\r\n		<item id=\"appid\"><![CDATA[2]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[bohemint]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn/UCenter/Api]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"UC_API\"><![CDATA[http://test.zhenweitech.cn:8810]]></item>\r\n</root>',0,0,0,0),(3,'updateapps',1,0,0,'','<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\r\n<root>\r\n	<item id=\"1\">\r\n		<item id=\"appid\"><![CDATA[1]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[boheofficial]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn:8000]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[ucapi]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"2\">\r\n		<item id=\"appid\"><![CDATA[2]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[bohemint]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn/UCenter]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[Api]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"UC_API\"><![CDATA[http://test.zhenweitech.cn:8810]]></item>\r\n</root>',0,0,0,0),(4,'updateapps',1,0,0,'','<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\r\n<root>\r\n	<item id=\"1\">\r\n		<item id=\"appid\"><![CDATA[1]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[boheofficial]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn:8000]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[ucapi]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"2\">\r\n		<item id=\"appid\"><![CDATA[2]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[bohemint]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn/mintAdmin/index.php/UCenter/Api]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"UC_API\"><![CDATA[http://test.zhenweitech.cn:8810]]></item>\r\n</root>',0,0,0,0),(5,'updateapps',1,0,0,'','<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\r\n<root>\r\n	<item id=\"1\">\r\n		<item id=\"appid\"><![CDATA[1]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[boheofficial]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn:8000]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[ucapi]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"2\">\r\n		<item id=\"appid\"><![CDATA[2]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[bohemint]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn/mintAdmin/index.php/UCenter/Api]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"UC_API\"><![CDATA[http://test.zhenweitech.cn:8810]]></item>\r\n</root>',0,0,0,0),(6,'updateapps',1,0,0,'','<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\r\n<root>\r\n	<item id=\"1\">\r\n		<item id=\"appid\"><![CDATA[1]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[boheofficial]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn:8000]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[ucapi]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"2\">\r\n		<item id=\"appid\"><![CDATA[2]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[bohemint]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn/mintAdmin/index.php/UCenter]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[uc]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"UC_API\"><![CDATA[http://test.zhenweitech.cn:8810]]></item>\r\n</root>',0,0,0,0),(7,'deleteuser',1,0,0,'ids=\'2\'','',0,0,0,0),(8,'deleteuser',1,0,0,'ids=\'3\'','',0,0,0,0),(9,'updateapps',1,0,0,'','<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\r\n<root>\r\n	<item id=\"1\">\r\n		<item id=\"appid\"><![CDATA[1]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[boheofficial]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn:8000]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[ucapi]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"2\">\r\n		<item id=\"appid\"><![CDATA[2]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[bohemint]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn/mintAdmin/index.php/UCenter]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[uc]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"UC_API\"><![CDATA[http://test.zhenweitech.cn:8810]]></item>\r\n</root>',0,0,0,0),(10,'updateapps',1,0,0,'','<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\r\n<root>\r\n	<item id=\"1\">\r\n		<item id=\"appid\"><![CDATA[1]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[boheofficial]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn:8000]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[ucapi]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"2\">\r\n		<item id=\"appid\"><![CDATA[2]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[bohemint]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn/mintAdmin/index.php/UCenter]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[uc]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"UC_API\"><![CDATA[http://test.zhenweitech.cn:8810]]></item>\r\n</root>',0,0,0,0),(11,'updateapps',1,0,0,'','<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\r\n<root>\r\n	<item id=\"1\">\r\n		<item id=\"appid\"><![CDATA[1]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[boheofficial]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn:8000]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[ucapi]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"2\">\r\n		<item id=\"appid\"><![CDATA[2]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[bohemint]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn/mintAdmin/index.php/UCenter]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[uc]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"UC_API\"><![CDATA[http://test.zhenweitech.cn:8810]]></item>\r\n</root>',0,0,0,0),(12,'updateapps',1,0,0,'','<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\r\n<root>\r\n	<item id=\"1\">\r\n		<item id=\"appid\"><![CDATA[1]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[boheofficial]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn:8000]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[ucapi]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"2\">\r\n		<item id=\"appid\"><![CDATA[2]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[bohemint]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn/mintAdmin/index.php/UCenter]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[uc]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"UC_API\"><![CDATA[http://test.zhenweitech.cn:8810]]></item>\r\n</root>',0,0,0,0),(13,'updateapps',1,0,0,'','<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\r\n<root>\r\n	<item id=\"1\">\r\n		<item id=\"appid\"><![CDATA[1]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[boheofficial]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn:8000]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[ucapi]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"2\">\r\n		<item id=\"appid\"><![CDATA[2]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[bohemint]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn/mintAdmin/index.php/UCenter]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[uc]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"UC_API\"><![CDATA[http://test.zhenweitech.cn:8810]]></item>\r\n</root>',0,0,0,0),(14,'updateapps',1,0,0,'','<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\r\n<root>\r\n	<item id=\"1\">\r\n		<item id=\"appid\"><![CDATA[1]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[boheofficial]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn:8000]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[ucapi]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"2\">\r\n		<item id=\"appid\"><![CDATA[2]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[bohemint]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn/mintAdmin/index.php/UCenter]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[uc]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"UC_API\"><![CDATA[http://test.zhenweitech.cn:8810]]></item>\r\n</root>',0,0,0,0),(15,'updateapps',1,0,0,'','<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\r\n<root>\r\n	<item id=\"1\">\r\n		<item id=\"appid\"><![CDATA[1]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[boheofficial]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn:8000]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[ucapi]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"2\">\r\n		<item id=\"appid\"><![CDATA[2]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[bohemint]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn/mintAdmin/index.php/UCenter]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[uc]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"UC_API\"><![CDATA[http://test.zhenweitech.cn:8810]]></item>\r\n</root>',0,0,0,0),(16,'updateapps',1,0,0,'','<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\r\n<root>\r\n	<item id=\"1\">\r\n		<item id=\"appid\"><![CDATA[1]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[boheofficial]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn:8000]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[ucapi]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"2\">\r\n		<item id=\"appid\"><![CDATA[2]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[bohemint]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn/mintAdmin/index.php/UCenter]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[uc]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"UC_API\"><![CDATA[http://test.zhenweitech.cn:8810]]></item>\r\n</root>',0,0,0,0),(17,'updateapps',1,0,0,'','<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\r\n<root>\r\n	<item id=\"1\">\r\n		<item id=\"appid\"><![CDATA[1]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[boheofficial]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn:8000]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[ucapi]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"2\">\r\n		<item id=\"appid\"><![CDATA[2]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[bohemint]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn/mintAdmin/index.php/UCenter]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[uc]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"UC_API\"><![CDATA[http://test.zhenweitech.cn:8810]]></item>\r\n</root>',0,0,0,0),(18,'deleteuser',1,0,0,'ids=\'1\',\'4\'','',0,0,0,0),(19,'updateapps',1,0,0,'','<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\r\n<root>\r\n	<item id=\"1\">\r\n		<item id=\"appid\"><![CDATA[1]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[boheofficial]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn:8000]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[ucapi]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"2\">\r\n		<item id=\"appid\"><![CDATA[2]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[bohemint]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn/mintAdmin/index.php/UCenter]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[uc]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"UC_API\"><![CDATA[http://test.zhenweitech.cn:8810]]></item>\r\n</root>',0,0,0,0),(20,'updateapps',1,0,0,'','<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\r\n<root>\r\n	<item id=\"1\">\r\n		<item id=\"appid\"><![CDATA[1]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[boheofficial]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn:8000]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[ucapi]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"2\">\r\n		<item id=\"appid\"><![CDATA[2]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[bohemint]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn/mintAdmin/index.php/UCenter]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[uc]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"UC_API\"><![CDATA[http://test.zhenweitech.cn:8810]]></item>\r\n</root>',0,0,0,0),(21,'deleteuser',1,0,0,'ids=\'5\'','',0,0,0,0),(22,'updateapps',1,0,0,'','<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\r\n<root>\r\n	<item id=\"1\">\r\n		<item id=\"appid\"><![CDATA[1]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[boheofficial]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn:8000]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[ucapi]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"2\">\r\n		<item id=\"appid\"><![CDATA[2]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[bohemint]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn/mintAdmin/index.php/UCenter]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[uc]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"UC_API\"><![CDATA[http://test.zhenweitech.cn:8810]]></item>\r\n</root>',0,0,0,0),(23,'updateapps',1,0,0,'','<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\r\n<root>\r\n	<item id=\"1\">\r\n		<item id=\"appid\"><![CDATA[1]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[boheofficial]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn:8000]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[ucapi]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"2\">\r\n		<item id=\"appid\"><![CDATA[2]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[bohemint]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn/mintAdmin/index.php/UCenter]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[uc]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"UC_API\"><![CDATA[http://test.zhenweitech.cn:8810]]></item>\r\n</root>',0,0,0,0),(24,'deleteuser',1,0,0,'ids=\'6\'','',0,0,0,0),(25,'updateapps',1,0,0,'','<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\r\n<root>\r\n	<item id=\"1\">\r\n		<item id=\"appid\"><![CDATA[1]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[boheofficial]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn:8000]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[ucapi]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"2\">\r\n		<item id=\"appid\"><![CDATA[2]]></item>\r\n		<item id=\"type\"><![CDATA[OTHER]]></item>\r\n		<item id=\"name\"><![CDATA[bohemint]]></item>\r\n		<item id=\"url\"><![CDATA[http://test.zhenweitech.cn/mintAdmin/index.php/UCenter]]></item>\r\n		<item id=\"ip\"><![CDATA[]]></item>\r\n		<item id=\"viewprourl\"><![CDATA[]]></item>\r\n		<item id=\"apifilename\"><![CDATA[uc]]></item>\r\n		<item id=\"charset\"><![CDATA[]]></item>\r\n		<item id=\"synlogin\"><![CDATA[1]]></item>\r\n		<item id=\"extra\">\r\n			<item id=\"apppath\"><![CDATA[]]></item>\r\n			<item id=\"extraurl\">\r\n			</item>\r\n		</item>\r\n		<item id=\"recvnote\"><![CDATA[0]]></item>\r\n	</item>\r\n	<item id=\"UC_API\"><![CDATA[http://test.zhenweitech.cn:8810]]></item>\r\n</root>',0,0,0,0),(26,'deleteuser',1,1,0,'ids=\'8\'','',1494907931,0,-1,0),(27,'deleteuser',1,1,0,'ids=\'9\'','',1494914380,0,-1,0),(28,'deleteuser',1,0,0,'ids=\'10\'','',0,0,0,0);
/*!40000 ALTER TABLE `uc_notelist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_pm_indexes`
--

DROP TABLE IF EXISTS `uc_pm_indexes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_pm_indexes` (
  `pmid` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `plid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`pmid`),
  KEY `plid` (`plid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_pm_indexes`
--

LOCK TABLES `uc_pm_indexes` WRITE;
/*!40000 ALTER TABLE `uc_pm_indexes` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_pm_indexes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_pm_lists`
--

DROP TABLE IF EXISTS `uc_pm_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_pm_lists` (
  `plid` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `authorid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `pmtype` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `subject` varchar(80) NOT NULL,
  `members` smallint(5) unsigned NOT NULL DEFAULT '0',
  `min_max` varchar(17) NOT NULL,
  `dateline` int(10) unsigned NOT NULL DEFAULT '0',
  `lastmessage` text NOT NULL,
  PRIMARY KEY (`plid`),
  KEY `pmtype` (`pmtype`),
  KEY `min_max` (`min_max`),
  KEY `authorid` (`authorid`,`dateline`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_pm_lists`
--

LOCK TABLES `uc_pm_lists` WRITE;
/*!40000 ALTER TABLE `uc_pm_lists` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_pm_lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_pm_members`
--

DROP TABLE IF EXISTS `uc_pm_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_pm_members` (
  `plid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `uid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `isnew` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `pmnum` int(10) unsigned NOT NULL DEFAULT '0',
  `lastupdate` int(10) unsigned NOT NULL DEFAULT '0',
  `lastdateline` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`plid`,`uid`),
  KEY `isnew` (`isnew`),
  KEY `lastdateline` (`uid`,`lastdateline`),
  KEY `lastupdate` (`uid`,`lastupdate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_pm_members`
--

LOCK TABLES `uc_pm_members` WRITE;
/*!40000 ALTER TABLE `uc_pm_members` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_pm_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_pm_messages_0`
--

DROP TABLE IF EXISTS `uc_pm_messages_0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_pm_messages_0` (
  `pmid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `plid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `authorid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `delstatus` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateline` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`pmid`),
  KEY `plid` (`plid`,`delstatus`,`dateline`),
  KEY `dateline` (`plid`,`dateline`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_pm_messages_0`
--

LOCK TABLES `uc_pm_messages_0` WRITE;
/*!40000 ALTER TABLE `uc_pm_messages_0` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_pm_messages_0` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_pm_messages_1`
--

DROP TABLE IF EXISTS `uc_pm_messages_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_pm_messages_1` (
  `pmid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `plid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `authorid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `delstatus` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateline` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`pmid`),
  KEY `plid` (`plid`,`delstatus`,`dateline`),
  KEY `dateline` (`plid`,`dateline`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_pm_messages_1`
--

LOCK TABLES `uc_pm_messages_1` WRITE;
/*!40000 ALTER TABLE `uc_pm_messages_1` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_pm_messages_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_pm_messages_2`
--

DROP TABLE IF EXISTS `uc_pm_messages_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_pm_messages_2` (
  `pmid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `plid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `authorid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `delstatus` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateline` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`pmid`),
  KEY `plid` (`plid`,`delstatus`,`dateline`),
  KEY `dateline` (`plid`,`dateline`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_pm_messages_2`
--

LOCK TABLES `uc_pm_messages_2` WRITE;
/*!40000 ALTER TABLE `uc_pm_messages_2` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_pm_messages_2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_pm_messages_3`
--

DROP TABLE IF EXISTS `uc_pm_messages_3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_pm_messages_3` (
  `pmid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `plid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `authorid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `delstatus` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateline` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`pmid`),
  KEY `plid` (`plid`,`delstatus`,`dateline`),
  KEY `dateline` (`plid`,`dateline`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_pm_messages_3`
--

LOCK TABLES `uc_pm_messages_3` WRITE;
/*!40000 ALTER TABLE `uc_pm_messages_3` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_pm_messages_3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_pm_messages_4`
--

DROP TABLE IF EXISTS `uc_pm_messages_4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_pm_messages_4` (
  `pmid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `plid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `authorid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `delstatus` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateline` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`pmid`),
  KEY `plid` (`plid`,`delstatus`,`dateline`),
  KEY `dateline` (`plid`,`dateline`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_pm_messages_4`
--

LOCK TABLES `uc_pm_messages_4` WRITE;
/*!40000 ALTER TABLE `uc_pm_messages_4` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_pm_messages_4` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_pm_messages_5`
--

DROP TABLE IF EXISTS `uc_pm_messages_5`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_pm_messages_5` (
  `pmid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `plid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `authorid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `delstatus` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateline` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`pmid`),
  KEY `plid` (`plid`,`delstatus`,`dateline`),
  KEY `dateline` (`plid`,`dateline`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_pm_messages_5`
--

LOCK TABLES `uc_pm_messages_5` WRITE;
/*!40000 ALTER TABLE `uc_pm_messages_5` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_pm_messages_5` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_pm_messages_6`
--

DROP TABLE IF EXISTS `uc_pm_messages_6`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_pm_messages_6` (
  `pmid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `plid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `authorid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `delstatus` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateline` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`pmid`),
  KEY `plid` (`plid`,`delstatus`,`dateline`),
  KEY `dateline` (`plid`,`dateline`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_pm_messages_6`
--

LOCK TABLES `uc_pm_messages_6` WRITE;
/*!40000 ALTER TABLE `uc_pm_messages_6` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_pm_messages_6` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_pm_messages_7`
--

DROP TABLE IF EXISTS `uc_pm_messages_7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_pm_messages_7` (
  `pmid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `plid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `authorid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `delstatus` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateline` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`pmid`),
  KEY `plid` (`plid`,`delstatus`,`dateline`),
  KEY `dateline` (`plid`,`dateline`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_pm_messages_7`
--

LOCK TABLES `uc_pm_messages_7` WRITE;
/*!40000 ALTER TABLE `uc_pm_messages_7` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_pm_messages_7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_pm_messages_8`
--

DROP TABLE IF EXISTS `uc_pm_messages_8`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_pm_messages_8` (
  `pmid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `plid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `authorid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `delstatus` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateline` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`pmid`),
  KEY `plid` (`plid`,`delstatus`,`dateline`),
  KEY `dateline` (`plid`,`dateline`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_pm_messages_8`
--

LOCK TABLES `uc_pm_messages_8` WRITE;
/*!40000 ALTER TABLE `uc_pm_messages_8` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_pm_messages_8` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_pm_messages_9`
--

DROP TABLE IF EXISTS `uc_pm_messages_9`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_pm_messages_9` (
  `pmid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `plid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `authorid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  `delstatus` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateline` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`pmid`),
  KEY `plid` (`plid`,`delstatus`,`dateline`),
  KEY `dateline` (`plid`,`dateline`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_pm_messages_9`
--

LOCK TABLES `uc_pm_messages_9` WRITE;
/*!40000 ALTER TABLE `uc_pm_messages_9` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_pm_messages_9` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_protectedmembers`
--

DROP TABLE IF EXISTS `uc_protectedmembers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_protectedmembers` (
  `uid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `username` char(15) NOT NULL DEFAULT '',
  `appid` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateline` int(10) unsigned NOT NULL DEFAULT '0',
  `admin` char(15) NOT NULL DEFAULT '0',
  UNIQUE KEY `username` (`username`,`appid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_protectedmembers`
--

LOCK TABLES `uc_protectedmembers` WRITE;
/*!40000 ALTER TABLE `uc_protectedmembers` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_protectedmembers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_settings`
--

DROP TABLE IF EXISTS `uc_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_settings` (
  `k` varchar(32) NOT NULL DEFAULT '',
  `v` text NOT NULL,
  PRIMARY KEY (`k`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_settings`
--

LOCK TABLES `uc_settings` WRITE;
/*!40000 ALTER TABLE `uc_settings` DISABLE KEYS */;
INSERT INTO `uc_settings` VALUES ('accessemail',''),('censoremail',''),('censorusername',''),('dateformat','y-n-j'),('doublee','0'),('nextnotetime','0'),('timeoffset','28800'),('privatepmthreadlimit','25'),('chatpmthreadlimit','30'),('chatpmmemberlimit','35'),('pmfloodctrl','15'),('pmcenter','1'),('sendpmseccode','1'),('pmsendregdays','0'),('maildefault','username@21cn.com'),('mailsend','1'),('mailserver','smtp.21cn.com'),('mailport','25'),('mailauth','1'),('mailfrom','UCenter <username@21cn.com>'),('mailauth_username','username@21cn.com'),('mailauth_password','password'),('maildelimiter','0'),('mailusername','1'),('mailsilent','1'),('version','1.6.0');
/*!40000 ALTER TABLE `uc_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_sqlcache`
--

DROP TABLE IF EXISTS `uc_sqlcache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_sqlcache` (
  `sqlid` char(6) NOT NULL DEFAULT '',
  `data` char(100) NOT NULL,
  `expiry` int(10) unsigned NOT NULL,
  PRIMARY KEY (`sqlid`),
  KEY `expiry` (`expiry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_sqlcache`
--

LOCK TABLES `uc_sqlcache` WRITE;
/*!40000 ALTER TABLE `uc_sqlcache` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_sqlcache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_tags`
--

DROP TABLE IF EXISTS `uc_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_tags` (
  `tagname` char(20) NOT NULL,
  `appid` smallint(6) unsigned NOT NULL DEFAULT '0',
  `data` mediumtext,
  `expiration` int(10) unsigned NOT NULL,
  KEY `tagname` (`tagname`,`appid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_tags`
--

LOCK TABLES `uc_tags` WRITE;
/*!40000 ALTER TABLE `uc_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `uc_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uc_vars`
--

DROP TABLE IF EXISTS `uc_vars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uc_vars` (
  `name` char(32) NOT NULL DEFAULT '',
  `value` char(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uc_vars`
--

LOCK TABLES `uc_vars` WRITE;
/*!40000 ALTER TABLE `uc_vars` DISABLE KEYS */;
INSERT INTO `uc_vars` VALUES ('noteexists','0'),('noteexists1','0'),('noteexists2','0');
/*!40000 ALTER TABLE `uc_vars` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-17 10:34:40
