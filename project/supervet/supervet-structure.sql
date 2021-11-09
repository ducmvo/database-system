-- MySQL dump 10.13  Distrib 8.0.26, for macos11 (x86_64)
--
-- Host: cs100.seattleu.edu    Database: mm_cpsc502101team01
-- ------------------------------------------------------
-- Server version	8.0.23

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
-- Table structure for table `Appointment`
--

DROP TABLE IF EXISTS `Appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Appointment` (
  `appointmentID` int NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `vetID` int NOT NULL,
  `petID` int NOT NULL,
  `createdAt` timestamp NULL DEFAULT NULL,
  `customerID` int NOT NULL,
  PRIMARY KEY (`appointmentID`),
  KEY `vet_idx` (`vetID`),
  KEY `pet_idx` (`petID`),
  KEY `fk_Appoinment_Customer1_idx` (`customerID`),
  CONSTRAINT `fk_Appoinment_Customer1` FOREIGN KEY (`customerID`) REFERENCES `Customer` (`customerID`),
  CONSTRAINT `pet` FOREIGN KEY (`petID`) REFERENCES `Pet` (`petID`),
  CONSTRAINT `vet` FOREIGN KEY (`vetID`) REFERENCES `Vet` (`vetID`)
) ENGINE=InnoDB AUTO_INCREMENT=9996 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer` (
  `customerID` int NOT NULL,
  `createdAt` timestamp NULL DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `address2` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `zip_code` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`customerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Employee`
--

DROP TABLE IF EXISTS `Employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Employee` (
  `employeeID` int NOT NULL,
  `createdAt` timestamp NULL DEFAULT NULL,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `address 2` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state` varchar(45) DEFAULT NULL,
  `zip_code` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`employeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Payment`
--

DROP TABLE IF EXISTS `Payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Payment` (
  `customerID` int NOT NULL,
  `saleID` int NOT NULL,
  `prescriptionID` int NOT NULL,
  `createdAt` timestamp NULL DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `method` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`customerID`,`saleID`,`prescriptionID`),
  KEY `fk_Payment_Customer1_idx` (`customerID`),
  KEY `fk_Payment_Sale1_idx` (`saleID`),
  KEY `fk_Payment_Prescription1_idx` (`prescriptionID`),
  CONSTRAINT `fk_Payment_Customer1` FOREIGN KEY (`customerID`) REFERENCES `Customer` (`customerID`),
  CONSTRAINT `fk_Payment_Prescription1` FOREIGN KEY (`prescriptionID`) REFERENCES `Prescription` (`prescriptionID`),
  CONSTRAINT `fk_Payment_Sale1` FOREIGN KEY (`saleID`) REFERENCES `Sale` (`saleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Pet`
--

DROP TABLE IF EXISTS `Pet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pet` (
  `petID` int NOT NULL AUTO_INCREMENT,
  `createdAt` varchar(45) DEFAULT NULL,
  `customerID` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `breed` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`petID`),
  KEY `customer_idx` (`customerID`),
  CONSTRAINT `customer` FOREIGN KEY (`customerID`) REFERENCES `Customer` (`customerID`)
) ENGINE=InnoDB AUTO_INCREMENT=2001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Prescription`
--

DROP TABLE IF EXISTS `Prescription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Prescription` (
  `prescriptionID` int NOT NULL AUTO_INCREMENT,
  `petID` int NOT NULL,
  `status` varchar(45) DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT NULL,
  `vetID` int NOT NULL,
  PRIMARY KEY (`prescriptionID`),
  KEY `fk_Prescription_Vet1_idx` (`vetID`),
  CONSTRAINT `fk_Prescription_Vet1` FOREIGN KEY (`vetID`) REFERENCES `Vet` (`vetID`)
) ENGINE=InnoDB AUTO_INCREMENT=2001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PrescriptionProduct`
--

DROP TABLE IF EXISTS `PrescriptionProduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PrescriptionProduct` (
  `prescriptionID` int NOT NULL,
  `productID` int NOT NULL,
  `quantity` varchar(45) DEFAULT NULL,
  `unit` varchar(45) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`prescriptionID`,`productID`),
  KEY `fk_Prescription_has_Product_Product1_idx` (`productID`),
  KEY `fk_Prescription_has_Product_Prescription1_idx` (`prescriptionID`),
  CONSTRAINT `fk_Prescription_has_Product_Prescription1` FOREIGN KEY (`prescriptionID`) REFERENCES `Prescription` (`prescriptionID`),
  CONSTRAINT `fk_Prescription_has_Product_Product1` FOREIGN KEY (`productID`) REFERENCES `Product` (`productID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Product`
--

DROP TABLE IF EXISTS `Product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Product` (
  `productID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(300) DEFAULT NULL,
  `brand` varchar(300) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `color` varchar(45) DEFAULT NULL,
  `size` varchar(5) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `category` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`productID`)
) ENGINE=InnoDB AUTO_INCREMENT=2001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Sale`
--

DROP TABLE IF EXISTS `Sale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sale` (
  `saleID` int NOT NULL AUTO_INCREMENT,
  `description` varchar(500) DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT NULL,
  `employeeID` int DEFAULT NULL,
  PRIMARY KEY (`saleID`),
  KEY `fk_Sale_Employee1_idx` (`employeeID`),
  CONSTRAINT `employee` FOREIGN KEY (`employeeID`) REFERENCES `Employee` (`employeeID`)
) ENGINE=InnoDB AUTO_INCREMENT=1999 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SaleProduct`
--

DROP TABLE IF EXISTS `SaleProduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SaleProduct` (
  `saleID` int NOT NULL,
  `productID` int NOT NULL,
  `quantity` int DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`saleID`,`productID`),
  KEY `fk_Sale_has_Product_Product1_idx` (`productID`),
  KEY `fk_Sale_has_Product_Sale1_idx` (`saleID`),
  CONSTRAINT `fk_Sale_has_Product_Product1` FOREIGN KEY (`productID`) REFERENCES `Product` (`productID`),
  CONSTRAINT `fk_Sale_has_Product_Sale1` FOREIGN KEY (`saleID`) REFERENCES `Sale` (`saleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Vet`
--

DROP TABLE IF EXISTS `Vet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Vet` (
  `vetID` int NOT NULL,
  `createdAt` varchar(45) DEFAULT 'CURRENT_TIMESTAMP',
  `password` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`vetID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-08 21:19:26
