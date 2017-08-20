-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: 127.0.0.1    Database: EcommerceDB
-- ------------------------------------------------------
-- Server version	5.7.18

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
-- Table structure for table `AddressMaster`
--

DROP TABLE IF EXISTS `AddressMaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AddressMaster` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(200) DEFAULT NULL,
  `UserId` varchar(100) NOT NULL,
  `UserType` varchar(45) DEFAULT NULL,
  `Line1` varchar(100) DEFAULT NULL,
  `Line2` varchar(100) DEFAULT NULL,
  `Line3` varchar(100) DEFAULT NULL,
  `Landmark` varchar(100) DEFAULT NULL,
  `State` varchar(45) DEFAULT NULL,
  `City` varchar(45) DEFAULT NULL,
  `PinCode` varchar(10) DEFAULT NULL,
  `Country` varchar(45) DEFAULT NULL,
  `PhoneNo1` varchar(20) DEFAULT NULL,
  `PhoneNo2` varchar(20) DEFAULT NULL,
  `IsDefault` tinyint(4) DEFAULT '0',
  `IsActive` tinyint(4) DEFAULT '0',
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AddressMaster`
--

LOCK TABLES `AddressMaster` WRITE;
/*!40000 ALTER TABLE `AddressMaster` DISABLE KEYS */;
INSERT INTO `AddressMaster` VALUES (4,'Test','test@gmail.com','Customer','Pune',NULL,NULL,'Aker Sol','MH','Pune','411045','India','987654321','',1,1,'test@gmail.com','2017-08-17 06:58:13'),(5,'Test','test@gmail.com','Customer','Pune',NULL,NULL,'Aker Sol','MH','Pune','411045','India','987654321','',1,1,'test@gmail.com','2017-08-17 07:00:51'),(6,'Risi Raja','risiraja@gmail.com','Customer','Baner ,Pune',NULL,NULL,'Aker Solution','MH','Pune','411045','India','9876543210','',1,1,'risiraja@gmail.com','2017-08-17 07:01:41'),(7,'Test','test@gmail.com','Customer','Pune',NULL,NULL,'Aker Sol','MH','Pune','411045','India','987654321','',1,1,'test@gmail.com','2017-08-17 07:01:47'),(8,'Test','test@gmail.com','Customer','Pune',NULL,NULL,'Aker Sol','MH','Pune','411045','India','987654321','',1,1,'test@gmail.com','2017-08-17 07:03:03'),(9,'Test','test@gmail.com','Customer','Pune',NULL,NULL,'Aker Sol','MH','Pune','411045','India','987654321','',1,1,'test@gmail.com','2017-08-17 07:03:23'),(10,'Test','test@gmail.com1','Customer','Pune',NULL,NULL,'Aker Sol','MH','Pune','411045','India','987654321','',1,1,'test@gmail.com1','2017-08-17 07:05:02');
/*!40000 ALTER TABLE `AddressMaster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AddressMasterLog`
--

DROP TABLE IF EXISTS `AddressMasterLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AddressMasterLog` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(200) DEFAULT NULL,
  `UserId` varchar(100) NOT NULL,
  `UserType` varchar(45) DEFAULT NULL,
  `Line1` varchar(100) DEFAULT NULL,
  `Line2` varchar(100) DEFAULT NULL,
  `Line3` varchar(100) DEFAULT NULL,
  `Landmark` varchar(100) DEFAULT NULL,
  `State` varchar(45) DEFAULT NULL,
  `City` varchar(45) DEFAULT NULL,
  `PinCode` varchar(10) DEFAULT NULL,
  `Country` varchar(45) DEFAULT NULL,
  `PhoneNo1` varchar(20) DEFAULT NULL,
  `PhoneNo2` varchar(20) DEFAULT NULL,
  `IsDefault` tinyint(4) DEFAULT '0',
  `IsActive` tinyint(4) DEFAULT '0',
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AddressMasterLog`
--

LOCK TABLES `AddressMasterLog` WRITE;
/*!40000 ALTER TABLE `AddressMasterLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `AddressMasterLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CardMaster`
--

DROP TABLE IF EXISTS `CardMaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CardMaster` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` varchar(100) NOT NULL,
  `BankName` varchar(45) DEFAULT NULL,
  `CardType` varchar(45) DEFAULT NULL,
  `NameOnCard` varchar(45) DEFAULT NULL,
  `CardNumber` varchar(45) DEFAULT NULL,
  `ExpiryDate` datetime DEFAULT NULL,
  `IsActive` tinyint(4) DEFAULT '1',
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_Card_Customer_idx` (`UserId`),
  CONSTRAINT `fk_Card_Customer` FOREIGN KEY (`UserId`) REFERENCES `Customers` (`UserId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CardMaster`
--

LOCK TABLES `CardMaster` WRITE;
/*!40000 ALTER TABLE `CardMaster` DISABLE KEYS */;
/*!40000 ALTER TABLE `CardMaster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CardMasterLog`
--

DROP TABLE IF EXISTS `CardMasterLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CardMasterLog` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` varchar(100) NOT NULL,
  `BankName` varchar(45) DEFAULT NULL,
  `CardType` varchar(45) DEFAULT NULL,
  `NameOnCard` varchar(45) DEFAULT NULL,
  `CardNumber` varchar(45) DEFAULT NULL,
  `ExpiryDate` datetime DEFAULT NULL,
  `IsActive` tinyint(4) DEFAULT '1',
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CardMasterLog`
--

LOCK TABLES `CardMasterLog` WRITE;
/*!40000 ALTER TABLE `CardMasterLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `CardMasterLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CartDetails`
--

DROP TABLE IF EXISTS `CartDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CartDetails` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` varchar(150) NOT NULL,
  `ProductId` int(11) DEFAULT NULL,
  `ProductDesc` varchar(500) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `CreatedBy` varchar(150) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_Cart_Customer_idx` (`UserId`),
  CONSTRAINT `fk_Cart_Customer` FOREIGN KEY (`UserId`) REFERENCES `Customers` (`UserId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CartDetails`
--

LOCK TABLES `CartDetails` WRITE;
/*!40000 ALTER TABLE `CartDetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `CartDetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CartDetailsLog`
--

DROP TABLE IF EXISTS `CartDetailsLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CartDetailsLog` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` varchar(150) NOT NULL,
  `ProductId` int(11) DEFAULT NULL,
  `ProductDesc` varchar(500) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `CreatedBy` varchar(150) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CartDetailsLog`
--

LOCK TABLES `CartDetailsLog` WRITE;
/*!40000 ALTER TABLE `CartDetailsLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `CartDetailsLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CustomerNotification`
--

DROP TABLE IF EXISTS `CustomerNotification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CustomerNotification` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` varchar(100) DEFAULT NULL,
  `Message` varchar(500) DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_Notification_Customer_idx` (`UserId`),
  CONSTRAINT `fk_Notification_Customer` FOREIGN KEY (`UserId`) REFERENCES `Customers` (`UserId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CustomerNotification`
--

LOCK TABLES `CustomerNotification` WRITE;
/*!40000 ALTER TABLE `CustomerNotification` DISABLE KEYS */;
/*!40000 ALTER TABLE `CustomerNotification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CustomerNotificationLog`
--

DROP TABLE IF EXISTS `CustomerNotificationLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CustomerNotificationLog` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` varchar(100) DEFAULT NULL,
  `Message` varchar(500) DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CustomerNotificationLog`
--

LOCK TABLES `CustomerNotificationLog` WRITE;
/*!40000 ALTER TABLE `CustomerNotificationLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `CustomerNotificationLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CustomerWishList`
--

DROP TABLE IF EXISTS `CustomerWishList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CustomerWishList` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` varchar(100) DEFAULT NULL,
  `WishlistTitle` varchar(100) DEFAULT NULL,
  `ProductID` int(11) DEFAULT NULL,
  `ProductDesc` varchar(500) DEFAULT NULL,
  `IsPublic` tinyint(4) DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_WishList_Customer_idx` (`UserId`),
  CONSTRAINT `fk_WishList_Customer` FOREIGN KEY (`UserId`) REFERENCES `Customers` (`UserId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CustomerWishList`
--

LOCK TABLES `CustomerWishList` WRITE;
/*!40000 ALTER TABLE `CustomerWishList` DISABLE KEYS */;
/*!40000 ALTER TABLE `CustomerWishList` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CustomerWishListLog`
--

DROP TABLE IF EXISTS `CustomerWishListLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CustomerWishListLog` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` varchar(100) DEFAULT NULL,
  `WishlistTitle` varchar(100) DEFAULT NULL,
  `ProductID` int(11) DEFAULT NULL,
  `ProductDesc` varchar(500) DEFAULT NULL,
  `IsPublic` tinyint(4) DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CustomerWishListLog`
--

LOCK TABLES `CustomerWishListLog` WRITE;
/*!40000 ALTER TABLE `CustomerWishListLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `CustomerWishListLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Customers`
--

DROP TABLE IF EXISTS `Customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Customers` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CustomerId` varchar(45) DEFAULT NULL,
  `UserId` varchar(100) NOT NULL,
  `FirstName` varchar(45) DEFAULT NULL,
  `LastName` varchar(45) DEFAULT NULL,
  `ContactNo` varchar(20) DEFAULT NULL,
  `Gender` varchar(20) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `ReferralCode` varchar(45) DEFAULT NULL,
  `MyReferral` varchar(45) DEFAULT NULL,
  `MaritalStatus` varchar(20) DEFAULT NULL,
  `ReferedBy` varchar(45) DEFAULT NULL,
  `IsActive` tinyint(4) DEFAULT '0',
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `ModifyBy` varchar(100) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UserId_UNIQUE` (`UserId`),
  KEY `MainIndex` (`UserId`),
  CONSTRAINT `fk_Customer_UserAuth` FOREIGN KEY (`UserId`) REFERENCES `UserAuthentication` (`UserId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customers`
--

LOCK TABLES `Customers` WRITE;
/*!40000 ALTER TABLE `Customers` DISABLE KEYS */;
INSERT INTO `Customers` VALUES (6,'gourav20170808','gourav@db.com','gourav','Pal','9876543210','Male','2017-09-09',NULL,NULL,'Single',NULL,1,'admin@api.com','2017-08-08 00:00:00',NULL,'2017-08-08 00:00:00'),(7,'ajay20170808','ajay@firstcry.com','ajay','santra','9876543210','Male','2017-09-09',NULL,NULL,'Single',NULL,1,'admin@api.com','2017-08-08 00:00:00',NULL,'2017-08-08 00:00:00'),(8,'C0001','rahulm@gmail.com','abhi','Sharma','9876543210','Male',NULL,'15955412PF63417867',NULL,NULL,NULL,1,'abhi@gmail.com','2017-08-12 09:45:28','abhi@gmail.com','2017-08-12 09:45:28'),(9,'C0001','test@gmail.com','test','k','98760','female','1990-01-01','',NULL,NULL,NULL,1,NULL,'2017-08-13 00:54:32','test@gmail.com','2017-08-20 10:43:23');
/*!40000 ALTER TABLE `Customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CustomersLog`
--

DROP TABLE IF EXISTS `CustomersLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CustomersLog` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CustomerId` varchar(45) DEFAULT NULL,
  `UserId` varchar(100) DEFAULT NULL,
  `FirstName` varchar(45) DEFAULT NULL,
  `LastName` varchar(45) DEFAULT NULL,
  `ContactNo` varchar(20) DEFAULT NULL,
  `Gender` varchar(20) DEFAULT NULL,
  `DOB` datetime DEFAULT NULL,
  `ReferralCode` varchar(45) DEFAULT NULL,
  `MyReferral` varchar(45) DEFAULT NULL,
  `MaritalStatus` varchar(20) DEFAULT NULL,
  `ReferedBy` varchar(45) DEFAULT NULL,
  `IsActive` tinyint(4) DEFAULT '0',
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `ModifyBy` varchar(100) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CustomersLog`
--

LOCK TABLES `CustomersLog` WRITE;
/*!40000 ALTER TABLE `CustomersLog` DISABLE KEYS */;
INSERT INTO `CustomersLog` VALUES (1,'gourav20170808','gourav@db.com','gourav','Pal','9876543210','Male','2017-09-09 00:00:00',NULL,NULL,'Single',NULL,1,'admin@api.com','2017-08-08 00:00:00',NULL,'2017-08-08 00:00:00'),(2,'C0001','rahulm@gmail.com','abhi','Sharma','9876543210','Male',NULL,'15955412PF63417867',NULL,NULL,NULL,1,'abhi@gmail.com','2017-08-12 09:45:28','abhi@gmail.com','2017-08-12 09:45:28'),(3,'C0001','test@gmail.com','test','k','8568565236','Male',NULL,'',NULL,NULL,NULL,1,NULL,'2017-08-13 00:54:32',NULL,'2017-08-13 00:54:32'),(4,'C0001','test@gmail.com','test','k','9876543210','MALE','1990-01-01 00:00:00','',NULL,NULL,NULL,1,NULL,'2017-08-13 00:54:32','test@gmail.com','2017-08-17 06:27:29'),(5,'C0001','test@gmail.com','test','k','9876543210','Male','1990-01-01 00:00:00','',NULL,NULL,NULL,1,NULL,'2017-08-13 00:54:32','test@gmail.com','2017-08-17 06:28:26'),(6,'C0001','test@gmail.com','test','k','98760','female','1990-01-01 00:00:00','',NULL,NULL,NULL,1,NULL,'2017-08-13 00:54:32','test@gmail.com','2017-08-20 10:42:02'),(7,'C0001','test@gmail.com','test','k','98760','female','1990-01-01 00:00:00','',NULL,NULL,NULL,1,NULL,'2017-08-13 00:54:32','test@gmail.com','2017-08-20 10:43:03'),(8,'C0001','test@gmail.com','test','k','98760','female','1990-01-01 00:00:00','',NULL,NULL,NULL,1,NULL,'2017-08-13 00:54:32','test@gmail.com','2017-08-20 10:43:22'),(9,'C0001','test@gmail.com','test','k','98760','female','1990-01-01 00:00:00','',NULL,NULL,NULL,1,NULL,'2017-08-13 00:54:32','test@gmail.com','2017-08-20 10:43:23');
/*!40000 ALTER TABLE `CustomersLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ErrorLog`
--

DROP TABLE IF EXISTS `ErrorLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ErrorLog` (
  `LogId` int(11) NOT NULL AUTO_INCREMENT,
  `ErrorDateTime` datetime DEFAULT NULL,
  `UserId` varchar(100) DEFAULT NULL,
  `ErrorNumber` varchar(45) DEFAULT NULL,
  `ErrorSeverity` int(11) DEFAULT NULL,
  `ErrorState` int(11) DEFAULT NULL,
  `ErrorProcedure` varchar(200) DEFAULT NULL,
  `ErrorLine` int(11) DEFAULT NULL,
  `ErrorMessage` text,
  PRIMARY KEY (`LogId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ErrorLog`
--

LOCK TABLES `ErrorLog` WRITE;
/*!40000 ALTER TABLE `ErrorLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `ErrorLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PurchaseDetails`
--

DROP TABLE IF EXISTS `PurchaseDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PurchaseDetails` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `OrderNo` varchar(45) NOT NULL,
  `OrderDate` datetime DEFAULT NULL,
  `ProductID` int(11) DEFAULT NULL,
  `ProductName` varchar(200) DEFAULT NULL,
  `ProductDesc` varchar(500) DEFAULT NULL,
  `MRP` decimal(18,2) DEFAULT NULL,
  `DiscountType` varchar(45) DEFAULT NULL,
  `DiscountPercentage` decimal(18,2) DEFAULT NULL,
  `DiscountAmount` decimal(18,2) DEFAULT NULL,
  `Quanity` int(11) DEFAULT NULL,
  `OfferMRP` decimal(18,2) DEFAULT NULL,
  `ItemStatus` varchar(20) DEFAULT NULL,
  `Comments` varchar(500) DEFAULT NULL,
  `StoreID` varchar(50) DEFAULT NULL,
  `Color` varchar(45) DEFAULT NULL,
  `BaseCost` decimal(18,2) DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `ModifyBy` varchar(100) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_PurachseDetails_PurchaseMaster_idx` (`OrderNo`),
  CONSTRAINT `fk_PurachseDetails_PurchaseMaster` FOREIGN KEY (`OrderNo`) REFERENCES `PurchaseMaster` (`OrderNo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PurchaseDetails`
--

LOCK TABLES `PurchaseDetails` WRITE;
/*!40000 ALTER TABLE `PurchaseDetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `PurchaseDetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PurchaseDetailsLog`
--

DROP TABLE IF EXISTS `PurchaseDetailsLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PurchaseDetailsLog` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `OrderNo` varchar(45) NOT NULL,
  `OrderDate` datetime DEFAULT NULL,
  `ProductID` int(11) DEFAULT NULL,
  `ProductName` varchar(200) DEFAULT NULL,
  `ProductDesc` varchar(500) DEFAULT NULL,
  `MRP` decimal(18,2) DEFAULT NULL,
  `DiscountType` varchar(45) DEFAULT NULL,
  `DiscountPercentage` decimal(18,2) DEFAULT NULL,
  `DiscountAmount` decimal(18,2) DEFAULT NULL,
  `Quanity` int(11) DEFAULT NULL,
  `OfferMRP` decimal(18,2) DEFAULT NULL,
  `ItemStatus` varchar(20) DEFAULT NULL,
  `Comments` varchar(500) DEFAULT NULL,
  `StoreID` varchar(50) DEFAULT NULL,
  `Color` varchar(45) DEFAULT NULL,
  `BaseCost` decimal(18,2) DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `ModifyBy` varchar(100) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PurchaseDetailsLog`
--

LOCK TABLES `PurchaseDetailsLog` WRITE;
/*!40000 ALTER TABLE `PurchaseDetailsLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `PurchaseDetailsLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PurchaseMaster`
--

DROP TABLE IF EXISTS `PurchaseMaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PurchaseMaster` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `OrderNo` varchar(45) NOT NULL,
  `OrderDate` datetime DEFAULT NULL,
  `UserId` varchar(100) NOT NULL,
  `StoreId` varchar(50) DEFAULT NULL,
  `OrderStatus` varchar(20) DEFAULT NULL,
  `TotalQty` int(11) DEFAULT NULL,
  `TotalAmount` decimal(18,2) DEFAULT NULL,
  `Tax` decimal(18,2) DEFAULT NULL,
  `TaxAmount` decimal(18,2) DEFAULT NULL,
  `OtherTax` decimal(18,2) DEFAULT NULL,
  `OtherTaxAmount` decimal(18,2) DEFAULT NULL,
  `Discount` decimal(18,2) DEFAULT NULL,
  `DiscountAmount` decimal(18,2) DEFAULT NULL,
  `RoundOff` decimal(18,2) DEFAULT NULL,
  `OfferCode` varchar(50) DEFAULT NULL,
  `Comments` varchar(500) DEFAULT NULL,
  `PaymentType` varchar(20) DEFAULT NULL,
  `OrderType` varchar(20) DEFAULT NULL,
  `ShippingAndHandling` decimal(18,2) DEFAULT NULL,
  `GrandAmount` decimal(18,2) DEFAULT NULL,
  `ShippingAddress` varchar(500) DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `ModifyBy` varchar(100) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `OrderNo_UNIQUE` (`OrderNo`),
  KEY `fk_PurchaseMaster_Customers_idx` (`UserId`),
  KEY `fk_PuchaseMaster_Store_idx` (`StoreId`),
  CONSTRAINT `fk_PuchaseMaster_Store` FOREIGN KEY (`StoreId`) REFERENCES `StoreMaster` (`StoreId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PurchaseMaster_Customers` FOREIGN KEY (`UserId`) REFERENCES `Customers` (`UserId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PurchaseMaster`
--

LOCK TABLES `PurchaseMaster` WRITE;
/*!40000 ALTER TABLE `PurchaseMaster` DISABLE KEYS */;
/*!40000 ALTER TABLE `PurchaseMaster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PurchaseMasterLog`
--

DROP TABLE IF EXISTS `PurchaseMasterLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PurchaseMasterLog` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `OrderNo` varchar(45) NOT NULL,
  `OrderDate` datetime DEFAULT NULL,
  `UserId` varchar(100) NOT NULL,
  `StoreId` varchar(50) DEFAULT NULL,
  `OrderStatus` varchar(20) DEFAULT NULL,
  `TotalQty` int(11) DEFAULT NULL,
  `TotalAmount` decimal(18,2) DEFAULT NULL,
  `Tax` decimal(18,2) DEFAULT NULL,
  `TaxAmount` decimal(18,2) DEFAULT NULL,
  `OtherTax` decimal(18,2) DEFAULT NULL,
  `OtherTaxAmount` decimal(18,2) DEFAULT NULL,
  `Discount` decimal(18,2) DEFAULT NULL,
  `DiscountAmount` decimal(18,2) DEFAULT NULL,
  `RoundOff` decimal(18,2) DEFAULT NULL,
  `OfferCode` varchar(50) DEFAULT NULL,
  `Comments` varchar(500) DEFAULT NULL,
  `PaymentType` varchar(20) DEFAULT NULL,
  `ShippingAndHandling` decimal(18,2) DEFAULT NULL,
  `GrandAmount` decimal(18,2) DEFAULT NULL,
  `ShippingAddress` varchar(500) DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `ModifyBy` varchar(100) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PurchaseMasterLog`
--

LOCK TABLES `PurchaseMasterLog` WRITE;
/*!40000 ALTER TABLE `PurchaseMasterLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `PurchaseMasterLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ReviewAndRatings`
--

DROP TABLE IF EXISTS `ReviewAndRatings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ReviewAndRatings` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ProductId` varchar(50) DEFAULT NULL,
  `UserId` varchar(100) DEFAULT NULL,
  `Stars` int(11) DEFAULT NULL,
  `Comments` varchar(5000) DEFAULT NULL,
  `IsApproved` tinyint(4) DEFAULT NULL,
  `IsHelpFull` tinyint(4) DEFAULT NULL,
  `ReviewTitle` varchar(200) DEFAULT NULL,
  `VerifiedCustomer` tinyint(4) DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_Review_Customers_idx` (`UserId`),
  CONSTRAINT `fk_Review_Customers` FOREIGN KEY (`UserId`) REFERENCES `Customers` (`UserId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ReviewAndRatings`
--

LOCK TABLES `ReviewAndRatings` WRITE;
/*!40000 ALTER TABLE `ReviewAndRatings` DISABLE KEYS */;
/*!40000 ALTER TABLE `ReviewAndRatings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ReviewAndRatingsLog`
--

DROP TABLE IF EXISTS `ReviewAndRatingsLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ReviewAndRatingsLog` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ProductId` varchar(50) DEFAULT NULL,
  `UserId` varchar(100) DEFAULT NULL,
  `Stars` int(11) DEFAULT NULL,
  `Comments` varchar(5000) DEFAULT NULL,
  `IsApproved` tinyint(4) DEFAULT NULL,
  `IsHelpFull` tinyint(4) DEFAULT NULL,
  `ReviewTitle` varchar(200) DEFAULT NULL,
  `VerifiedCustomer` tinyint(4) DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ReviewAndRatingsLog`
--

LOCK TABLES `ReviewAndRatingsLog` WRITE;
/*!40000 ALTER TABLE `ReviewAndRatingsLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `ReviewAndRatingsLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sellers`
--

DROP TABLE IF EXISTS `Sellers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Sellers` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SellerId` varchar(45) NOT NULL,
  `UserId` varchar(100) NOT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `CompanyName` varchar(200) DEFAULT NULL,
  `Gender` varchar(10) DEFAULT NULL,
  `ContactNo` varchar(20) DEFAULT NULL,
  `MobileNo` varchar(20) DEFAULT NULL,
  `ReferadBy` varchar(100) DEFAULT NULL,
  `CustomerCareNumber` varchar(45) DEFAULT NULL,
  `IsActive` tinyint(4) DEFAULT '1',
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `ModifyBy` varchar(100) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `EmailID_UNIQUE` (`UserId`),
  CONSTRAINT `fk_Seller_UserAuth` FOREIGN KEY (`UserId`) REFERENCES `UserAuthentication` (`UserId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sellers`
--

LOCK TABLES `Sellers` WRITE;
/*!40000 ALTER TABLE `Sellers` DISABLE KEYS */;
INSERT INTO `Sellers` VALUES (1,'S0001','sale@eco.com','Seller','Lname','Saller Pvt. Ltd.','Male','22-600299','9876543210',NULL,'1800234590',1,NULL,'2017-09-09 00:00:00',NULL,'2015-09-09 00:00:00');
/*!40000 ALTER TABLE `Sellers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SellersLog`
--

DROP TABLE IF EXISTS `SellersLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SellersLog` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `SellerId` varchar(45) DEFAULT NULL,
  `UserId` varchar(100) DEFAULT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `CompanyName` varchar(200) DEFAULT NULL,
  `Gender` varchar(10) DEFAULT NULL,
  `ContactNo` varchar(20) DEFAULT NULL,
  `MobileNo` varchar(20) DEFAULT NULL,
  `ReferadBy` varchar(100) DEFAULT NULL,
  `CustomerCareNumber` varchar(45) DEFAULT NULL,
  `IsActive` tinyint(4) DEFAULT '1',
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `ModifyBy` varchar(100) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SellersLog`
--

LOCK TABLES `SellersLog` WRITE;
/*!40000 ALTER TABLE `SellersLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `SellersLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `StoreMaster`
--

DROP TABLE IF EXISTS `StoreMaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `StoreMaster` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `StoreId` varchar(45) NOT NULL,
  `UserId` varchar(100) NOT NULL,
  `SellerId` varchar(100) NOT NULL,
  `StoreName` varchar(500) DEFAULT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `MobileNo` varchar(20) DEFAULT NULL,
  `ContactNo` varchar(20) DEFAULT NULL,
  `CustomerCareNumber` varchar(20) DEFAULT NULL,
  `SpecialOffersEmails` varchar(50) DEFAULT NULL,
  `ReferralCode` varchar(50) DEFAULT NULL,
  `Latitude` varchar(45) DEFAULT NULL,
  `Longitude` varchar(45) DEFAULT NULL,
  `IsActive` tinyint(4) DEFAULT '1',
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `ModifyBy` varchar(100) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `StoreId_UNIQUE` (`StoreId`),
  KEY `fk_Sellers_Store_idx` (`SellerId`),
  KEY `fk_Store_UserAuth_idx` (`UserId`),
  CONSTRAINT `fk_Store_Seller` FOREIGN KEY (`SellerId`) REFERENCES `Sellers` (`UserId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Store_UserAuth` FOREIGN KEY (`UserId`) REFERENCES `UserAuthentication` (`UserId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `StoreMaster`
--

LOCK TABLES `StoreMaster` WRITE;
/*!40000 ALTER TABLE `StoreMaster` DISABLE KEYS */;
INSERT INTO `StoreMaster` VALUES (1,'ST001','store@eco.com','sale@eco.com','store 1','store ','lname','987654321','22-6009876','1800123456',NULL,NULL,'18.5679387','73.785364',1,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `StoreMaster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `StoreMasterLog`
--

DROP TABLE IF EXISTS `StoreMasterLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `StoreMasterLog` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `StoreId` varchar(45) DEFAULT NULL,
  `UserId` varchar(100) DEFAULT NULL,
  `SellerId` varchar(100) DEFAULT NULL,
  `StoreName` varchar(500) DEFAULT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `MobileNo` varchar(20) DEFAULT NULL,
  `ContactNo` varchar(20) DEFAULT NULL,
  `CustomerCareNumber` varchar(20) DEFAULT NULL,
  `SpecialOffersEmails` varchar(50) DEFAULT NULL,
  `ReferralCode` varchar(50) DEFAULT NULL,
  `Latitude` varchar(45) DEFAULT NULL,
  `Longitude` varchar(45) DEFAULT NULL,
  `IsActive` tinyint(4) DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `ModifyBy` varchar(100) DEFAULT NULL,
  `ModifyDate` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `StoreMasterLog`
--

LOCK TABLES `StoreMasterLog` WRITE;
/*!40000 ALTER TABLE `StoreMasterLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `StoreMasterLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserAuthentication`
--

DROP TABLE IF EXISTS `UserAuthentication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserAuthentication` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` varchar(100) NOT NULL,
  `Password` varchar(1000) DEFAULT NULL,
  `AccessToken` varchar(1000) DEFAULT NULL,
  `LoginType` varchar(45) DEFAULT NULL,
  `IsSocial` tinyint(4) DEFAULT '0',
  `SocialType` varchar(45) DEFAULT NULL,
  `SocialToken` varchar(2000) DEFAULT NULL,
  `IsActive` tinyint(4) DEFAULT '1',
  `CreatedBy` varchar(45) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UserID_UNIQUE` (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserAuthentication`
--

LOCK TABLES `UserAuthentication` WRITE;
/*!40000 ALTER TABLE `UserAuthentication` DISABLE KEYS */;
INSERT INTO `UserAuthentication` VALUES (1,'ajay@firstcry.com','ajay',NULL,'Customer',0,NULL,NULL,1,'admin@firstcry.com',NULL),(2,'gourav@db.com','sha1$ed2f50fd$1$9d300dc13f25579400d8e060458b395282979b21',NULL,'Customer',0,NULL,NULL,1,'admin@firstcry.com',NULL),(3,'sale@eco.com',NULL,NULL,'Seller',0,NULL,NULL,1,'admin@firstcry.com',NULL),(4,'Store@eco.com',NULL,NULL,'Store',0,NULL,NULL,1,NULL,NULL),(6,'rahulm@gmail.com','sha1$095391a6$1$6cd488acb9e29690448fbfd8842e9c4128ff04d6','9876Asbc','Customer',1,'F','adfjasldflasd13nlasdflasdfjkaskdf',1,'abhi@gmail.com','2017-08-12 09:45:28'),(7,'test@gmail.com','sha1$fb0b201f$1$960b89cfdbe84aa242818cb2426cbb8632d99429',NULL,'customer',NULL,NULL,NULL,1,NULL,'2017-08-13 00:54:32');
/*!40000 ALTER TABLE `UserAuthentication` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserAuthenticationLog`
--

DROP TABLE IF EXISTS `UserAuthenticationLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserAuthenticationLog` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` varchar(100) DEFAULT NULL,
  `Password` varchar(1000) DEFAULT NULL,
  `AccessToken` varchar(1000) DEFAULT NULL,
  `LoginType` varchar(45) DEFAULT NULL,
  `IsSocial` tinyint(4) DEFAULT '0',
  `SocialType` varchar(45) DEFAULT NULL,
  `SocialToken` varchar(2000) DEFAULT NULL,
  `IsActive` tinyint(4) DEFAULT '1',
  `CreatedBy` varchar(45) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserAuthenticationLog`
--

LOCK TABLES `UserAuthenticationLog` WRITE;
/*!40000 ALTER TABLE `UserAuthenticationLog` DISABLE KEYS */;
INSERT INTO `UserAuthenticationLog` VALUES (1,'ajay@firstcry.com','ajay',NULL,'Customer',0,NULL,NULL,1,'admin@firstcry.com',NULL),(2,'rahu1231sadfas23l@gmail.com','sha1$4c40182f$1$322181fa1fda01987d4c89afb23851bb1becd7eb','9876Asbc','Customer',0,NULL,NULL,1,'abhi@gmail.com','2017-08-12 09:32:51'),(3,'rahulm@gmail.com','sha1$095391a6$1$6cd488acb9e29690448fbfd8842e9c4128ff04d6','9876Asbc','Customer',0,NULL,NULL,1,'abhi@gmail.com','2017-08-12 09:45:28'),(4,'rahulm@gmail.com','sha1$095391a6$1$6cd488acb9e29690448fbfd8842e9c4128ff04d6','9876Asbc','Customer',1,'F','adfjasldflasd13nlasdflasdfjkaskdf',1,'abhi@gmail.com','2017-08-12 09:45:28'),(5,'rahulm@gmail.com','sha1$095391a6$1$6cd488acb9e29690448fbfd8842e9c4128ff04d6','9876Asbc','Customer',1,'G','adfjasldflasd13nlasdflasdfjksdfsdfsdfsdfsaskdf',1,'abhi@gmail.com','2017-08-12 09:45:28'),(6,'rahulm@gmail.com','sha1$095391a6$1$6cd488acb9e29690448fbfd8842e9c4128ff04d6','9876Asbc','Customer',1,'F','adfjasldflasd13nlasdflasdfjkaskdf',1,'abhi@gmail.com','2017-08-12 09:45:28'),(7,'test@gmail.com','sha1$fb0b201f$1$960b89cfdbe84aa242818cb2426cbb8632d99429',NULL,'customer',NULL,NULL,NULL,1,NULL,'2017-08-13 00:54:32');
/*!40000 ALTER TABLE `UserAuthenticationLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WalletTransactionsLog`
--

DROP TABLE IF EXISTS `WalletTransactionsLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WalletTransactionsLog` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` varchar(100) DEFAULT NULL,
  `TransactionType` varchar(45) DEFAULT NULL,
  `Amount` decimal(18,2) DEFAULT NULL,
  `OrderID` varchar(20) DEFAULT NULL,
  `PaymentType` varchar(20) DEFAULT NULL,
  `TransactionDate` varchar(45) DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_WalletTrans_WalletMaster_idx` (`UserId`),
  CONSTRAINT `fk_WalletTrans_WalletMaster` FOREIGN KEY (`UserId`) REFERENCES `WalletsMaster` (`UserId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WalletTransactionsLog`
--

LOCK TABLES `WalletTransactionsLog` WRITE;
/*!40000 ALTER TABLE `WalletTransactionsLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `WalletTransactionsLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WalletsMaster`
--

DROP TABLE IF EXISTS `WalletsMaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WalletsMaster` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` varchar(45) DEFAULT NULL,
  `BalanceAmount` decimal(18,2) DEFAULT NULL,
  `CreatedBy` varchar(100) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UserID_UNIQUE` (`UserId`),
  CONSTRAINT `fk_Wallets_Customer` FOREIGN KEY (`UserId`) REFERENCES `Customers` (`UserId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WalletsMaster`
--

LOCK TABLES `WalletsMaster` WRITE;
/*!40000 ALTER TABLE `WalletsMaster` DISABLE KEYS */;
/*!40000 ALTER TABLE `WalletsMaster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'EcommerceDB'
--
/*!50003 DROP PROCEDURE IF EXISTS `AddAddressDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddAddressDetails`(
		
        IN _name VARCHAR(100),
		IN _userId VARCHAR(150),
		IN _userType VARCHAR(20),
		IN _line1 VARCHAR(100),
		IN _line2 VARCHAR(100),
		IN _line3 VARCHAR(100),
		IN _landmark VARCHAR(100),
		IN _state VARCHAR(50),
		IN _city VARCHAR(50),
		IN _pincode VARCHAR(20),
		IN _country VARCHAR(50),
		IN _phone1 VARCHAR(20),
		IN _phone2 VARCHAR(20),
		IN _isDefault TINYINT
		
)
BEGIN
			DECLARE Message VARCHAR(200);
			DECLARE _ID int ;
            
            IF EXISTS (SELECT  1 FROM  `EcommerceDB`.`AddressMaster` WHERE UserId = _userId  AND _isDefault = 1)
            THEN
            
				UPDATE  `EcommerceDB`.`AddressMaster` SET IsDefault = 0 WHERE UserId = _userId;
            
            END IF;
            

			INSERT INTO `EcommerceDB`.`AddressMaster`
					(`Name`, `UserId`, `UserType`, `Line1`, `Line2`, `Line3`, `Landmark`, `State`, `City`, `PinCode`, `Country`, `PhoneNo1`,
					`PhoneNo2`, `IsDefault`, `IsActive`, `CreatedBy`, `CreatedDate`)
			VALUES
					(_name, _userId, _userType, _line1, _line2, _line3, _landmark, _state, _city, _pincode, _country, _phone1, _phone2, 
					_isDefault, 1, _userId, CURRENT_TIMESTAMP());

			SET _ID = (SELECT LAST_INSERT_ID());

			IF( IFNULL( _ID , 0 ) > 0)
			THEN

				CALL  AddAddressLog(_ID);
				
				SET Message ='Data has been saved successfully.';
				SELECT Message;
            
            
            ELSE 
            
				SET Message ='Error : Details not saved..';
				SELECT Message;

			END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddAddressLog` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddAddressLog`(
	IN _ID  INT
)
BEGIN


	INSERT INTO `EcommerceDB`.`AddressMasterLog`
	(`Name`, `UserId`, `UserType`, `Line1`, `Line2`, `Line3`, `Landmark`, `State`, `City`, `PinCode`, `Country`, `PhoneNo1`,
	`PhoneNo2`, `IsDefault`, `IsActive`, `CreatedBy`, `CreatedDate`)
	SELECT
	(`Name`, `UserId`, `UserType`, `Line1`, `Line2`, `Line3`, `Landmark`, `State`, `City`, `PinCode`, `Country`, `PhoneNo1`,
	`PhoneNo2`, `IsDefault`, `IsActive`, `CreatedBy`, `CreatedDate`)
	FROM     `EcommerceDB`.`AddressMaster`
	WHERE `ID` = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddCustomersLog` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddCustomersLog`(
	IN _ID INT
)
BEGIN
	
	INSERT INTO `EcommerceDB`.`CustomersLog`
		(`CustomerId`, `UserId`, `FirstName`, `LastName`, `ContactNo`, `Gender`, `DOB`, `ReferralCode`, `MyReferral`
			, `MaritalStatus`, `ReferedBy`, `IsActive`, `CreatedBy`, `CreatedDate`, `ModifyBy`,`ModifyDate`)
	SELECT `CustomerId`, `UserId`, `FirstName`, `LastName`, `ContactNo`, `Gender`, `DOB`, `ReferralCode`, `MyReferral`
			, `MaritalStatus`, `ReferedBy`, `IsActive`, `CreatedBy`, `CreatedDate`, `ModifyBy`,`ModifyDate`
	FROM `EcommerceDB`.`Customers`
    WHERE `ID` = _ID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddUserAuthenticationLog` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddUserAuthenticationLog`(
	IN _ID  INT
)
BEGIN

		INSERT INTO `EcommerceDB`.`UserAuthenticationLog`
			(`UserId`, `Password`, `AccessToken`, `LoginType`, `IsSocial`, `SocialType`, `SocialToken`, `IsActive`, `CreatedBy`, `CreatedDate`)
		SELECT 
			`UserId`, `Password`, `AccessToken`, `LoginType`, `IsSocial`, `SocialType`, `SocialToken`, `IsActive`, `CreatedBy`, `CreatedDate`
		FROM `EcommerceDB`.`UserAuthentication`
		WHERE `ID` = _ID;
        
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CheckUserAuthentication` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckUserAuthentication`(
	IN _userId VARCHAR(250)
)
BEGIN
	DECLARE Message VARCHAR(200);
    
    IF EXISTS (SELECT  1 FROM UserAuthentication U WHERE U.UserId  = _userId )
    THEN
    
		SELECT CU.ContactNo, CU.Gender , CU.UserId, CONCAT(IFNULL(CU.FirstName,'') ,' ', IFNULL(CU.LastName,'') )AS FullName
						, CU.CustomerId, UA.Password , '' AS Message 
		FROM Customers CU 
		INNER JOIN UserAuthentication UA ON CU.UserId = UA.UserId
		WHERE UA.UserId = _userId
        LIMIT 1;
        
        SELECT COUNT(1) AS CartCount FROM CartDetails LIMIT 1; 
            
    ELSE
    
		SET Message = 'Invalid User ID.';
		SELECT Message;
		END IF;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetAddressDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAddressDetails`(

	IN _userId VARCHAR(100)
)
BEGIN
		
            SELECT am.ID, am.`Name`, am.UserId, am.UserType, am.Line1, am.Line2, am.Line3, am.Landmark, am.State, am.City, am.PinCode, am.Country, am.PhoneNo1,
					am.PhoneNo2, am.IsDefault
            FROM AddressMaster am 
            WHERE am.UserId = _userId;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `StoreDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `StoreDetails`(
	in _storeId VARCHAR(250) 
 )
BEGIN
		IF( IFNULL(_storeId,'') = '')
        THEN
        
			SELECT s.StoreId, s.UserId as EmailId, s.StoreName, CONCAT(IFNULL(s.FirstName,'') ,' ', IFNULL(s.LastName,'') ) AS FullName, s.MobileNo
            ,s.ContactNo, s.CustomerCareNumber, s.Latitude, s.Longitude, sl.CompanyName as SellerName, sl.SellerId
            FROM StoreMaster s 
            INNER JOIN Sellers sl ON s.SellerId = sl.UserId;
            
        ELSE
        
			SELECT s.StoreId, s.UserId as EmailId, s.StoreName, CONCAT(IFNULL(s.FirstName,'') ,' ', IFNULL(s.LastName,'') ) AS FullName, s.MobileNo
            ,s.ContactNo, s.CustomerCareNumber, s.Latitude, s.Longitude, sl.CompanyName as SellerName, sl.SellerId
            FROM StoreMaster s 
            INNER JOIN Sellers sl ON s.SellerId = sl.UserId
            WHERE s.UserId = _storeId;
            
        END IF;
		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateCustomerDetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateCustomerDetails`(
	
	IN _userId VARCHAR(100),
    IN _dob VARCHAR(200),
	IN _contactNo VARCHAR(20),
	IN _gender VARCHAR(20)
)
BEGIN

	DECLARE Message VARCHAR(200);
	DECLARE _ID INT ;

	UPDATE `EcommerceDB`.`Customers`
	SET	 `ContactNo` =_contactNo,
			`Gender` =  _gender, DOB = _dob, `ModifyBy` = _userId, `ModifyDate` = CURRENT_TIMESTAMP()
	WHERE `UserId` = _userId;

	SET _ID = (SELECT ID FROM Customers WHERE UserId = _userId LIMIT 1);

	IF(_ID > 0)
	THEN
		
		CALL AddCustomersLog(_ID);
        
		 CALL CheckUserAuthentication(_userId);

	ELSE

		SET Message =' Invalid Details.';
		SELECT Message;

	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UserRegistration` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UserRegistration`(
	IN _firstname VARCHAR(100),
	IN _lastname VARCHAR(100),
	IN _userId VARCHAR(100),
	IN _password VARCHAR(100),
	IN _contactNo VARCHAR(20),
	IN _gender VARCHAR(20),
	IN _referralCode VARCHAR(100),
    IN _isSocial tinyint,
	IN _socialToken VARCHAR(2000),
	IN _socialType VARCHAR(5),
	IN _createdBy VARCHAR(100),
	IN _loginType VARCHAR(100),
	IN _accessToken VARCHAR(250)
)
BEGIN

    DECLARE Message VARCHAR(200);
	DECLARE _ID int ;
   -- SET _ID = 0;
    DECLARE  _tempSocialType VARCHAR(10);
    DECLARE _CustomerId VARCHAR(200);
    SET _CustomerId = 'C0001';
	
    IF NOT EXISTS( SELECT  ID FROM UserAuthentication  WHERE UserId = _userId LIMIT 1)
	THEN
			

			INSERT INTO `EcommerceDB`.`UserAuthentication`
				(`UserId`, `Password`, `AccessToken`, `LoginType`, `IsSocial`,`SocialType` ,`SocialToken`, `IsActive`, `CreatedBy`, `CreatedDate`)
			VALUES(_userId, _password, _accessToken, _loginType, _isSocial, _socialType, _socialToken,1,_createdBy, CURRENT_TIMESTAMP());

			-- Get the last inserted ID
			SET _ID = (SELECT LAST_INSERT_ID());

			IF( IFNULL( _ID , 0 ) > 0) -- Start Log
			THEN

				CALL  AddUserAuthenticationLog(_ID);

				INSERT INTO `EcommerceDB`.`Customers`
					(`CustomerId`, `UserId`, `FirstName`, `LastName`, `ContactNo`, `Gender`, `ReferralCode`
					, `IsActive`, `CreatedBy`, `CreatedDate`, `ModifyBy`, `ModifyDate`)
				VALUES	(_CustomerId, _userId, _firstName, _lastName, _contactNo, _gender, _referralCode
					 , 1, _createdBy,CURRENT_TIMESTAMP() , _createdBy, CURRENT_TIMESTAMP());

				SET _ID = (SELECT LAST_INSERT_ID());

						IF( IFNULL( _ID , 0 ) > 0)
						THEN

							CALL  AddCustomersLog(_ID);

						END IF;

			END IF;  -- End Log
            
            CALL CheckUserAuthentication(_userId);
            

	ELSE

		IF (IFNULL(_socialToken,'') <> '')
		THEN

				SET _tempSocialType = (SELECT SocialType FROM UserAuthentication WHERE UserId = _userId LIMIT 1);

				IF(IFNULL(_socialType,'') <> IFNULL(_tempSocialType,''))
				THEN

						UPDATE UserAuthentication SET IsSocial = _isSocial , SocialType = _socialType , SocialToken = _socialToken
						WHERE UserId = _userId;

						SET _ID = (SELECT ID FROM UserAuthentication WHERE UserId = _userId LIMIT 1);

						IF(_ID > 0)
						THEN
                        	CALL AddUserAuthenticationLog(_ID);
						END IF;
                        
                        CALL CheckUserAuthentication(_userId);

				ELSE

						IF NOT EXISTS(SELECT * FROM UserAuthentication WHERE UserId = _userId AND SocialType = _socialType 
						AND SocialToken = _socialToken)
						THEN

							SET Message ='Unable to login with social network.';
							SELECT Message;
                            
						ELSE
                        
                        	CALL CheckUserAuthentication(_userId);
						
						END IF;

				END IF;
                
		ELSE       
			
            SET Message ='User Id  Is Already Exists.';
			SELECT Message;

		END IF;

	END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-08-20 16:41:49
