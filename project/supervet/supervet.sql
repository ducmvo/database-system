-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema mm_cpsc502101team01
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mm_cpsc502101team01
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mm_cpsc502101team01` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `mm_cpsc502101team01` ;

-- -----------------------------------------------------
-- Table `mm_cpsc502101team01`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mm_cpsc502101team01`.`Customer` (
  `customerID` INT NOT NULL,
  `createdAt` TIMESTAMP NULL DEFAULT NULL,
  `address` VARCHAR(45) NULL DEFAULT NULL,
  `address2` VARCHAR(45) NULL DEFAULT NULL,
  `city` VARCHAR(45) NULL DEFAULT NULL,
  `state` VARCHAR(45) NULL DEFAULT NULL,
  `zip_code` VARCHAR(45) NULL DEFAULT NULL,
  `password` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`customerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mm_cpsc502101team01`.`Pet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mm_cpsc502101team01`.`Pet` (
  `petID` INT NOT NULL AUTO_INCREMENT,
  `createdAt` VARCHAR(45) NULL DEFAULT NULL,
  `customerID` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `breed` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`petID`),
  INDEX `customer_idx` (`customerID` ASC) VISIBLE,
  CONSTRAINT `customer`
    FOREIGN KEY (`customerID`)
    REFERENCES `mm_cpsc502101team01`.`Customer` (`customerID`))
ENGINE = InnoDB
AUTO_INCREMENT = 2001
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mm_cpsc502101team01`.`Vet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mm_cpsc502101team01`.`Vet` (
  `vetID` INT NOT NULL,
  `createdAt` VARCHAR(45) NULL DEFAULT 'CURRENT_TIMESTAMP',
  `password` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`vetID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mm_cpsc502101team01`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mm_cpsc502101team01`.`Appointment` (
  `appointmentID` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NULL DEFAULT NULL,
  `status` VARCHAR(45) NULL DEFAULT NULL,
  `vetID` INT NOT NULL,
  `petID` INT NOT NULL,
  `createdAt` TIMESTAMP NULL DEFAULT NULL,
  `customerID` INT NOT NULL,
  PRIMARY KEY (`appointmentID`),
  INDEX `vet_idx` (`vetID` ASC) VISIBLE,
  INDEX `pet_idx` (`petID` ASC) VISIBLE,
  INDEX `fk_Appoinment_Customer1_idx` (`customerID` ASC) VISIBLE,
  CONSTRAINT `fk_Appoinment_Customer1`
    FOREIGN KEY (`customerID`)
    REFERENCES `mm_cpsc502101team01`.`Customer` (`customerID`),
  CONSTRAINT `pet`
    FOREIGN KEY (`petID`)
    REFERENCES `mm_cpsc502101team01`.`Pet` (`petID`),
  CONSTRAINT `vet`
    FOREIGN KEY (`vetID`)
    REFERENCES `mm_cpsc502101team01`.`Vet` (`vetID`))
ENGINE = InnoDB
AUTO_INCREMENT = 9996
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mm_cpsc502101team01`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mm_cpsc502101team01`.`Employee` (
  `employeeID` INT NOT NULL,
  `createdAt` TIMESTAMP NULL DEFAULT NULL,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `address` VARCHAR(45) NULL DEFAULT NULL,
  `address 2` VARCHAR(45) NULL DEFAULT NULL,
  `city` VARCHAR(45) NULL DEFAULT NULL,
  `state` VARCHAR(45) NULL DEFAULT NULL,
  `zip_code` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`employeeID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mm_cpsc502101team01`.`Prescription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mm_cpsc502101team01`.`Prescription` (
  `prescriptionID` INT NOT NULL AUTO_INCREMENT,
  `petID` INT NOT NULL,
  `status` VARCHAR(45) NULL DEFAULT NULL,
  `createdAt` TIMESTAMP NULL DEFAULT NULL,
  `vetID` INT NOT NULL,
  PRIMARY KEY (`prescriptionID`),
  INDEX `fk_Prescription_Vet1_idx` (`vetID` ASC) VISIBLE,
  CONSTRAINT `fk_Prescription_Vet1`
    FOREIGN KEY (`vetID`)
    REFERENCES `mm_cpsc502101team01`.`Vet` (`vetID`))
ENGINE = InnoDB
AUTO_INCREMENT = 2001
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mm_cpsc502101team01`.`Sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mm_cpsc502101team01`.`Sale` (
  `saleID` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(500) NULL DEFAULT NULL,
  `createdAt` TIMESTAMP NULL DEFAULT NULL,
  `updatedAt` TIMESTAMP NULL DEFAULT NULL,
  `employeeID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`saleID`),
  INDEX `fk_Sale_Employee1_idx` (`employeeID` ASC) VISIBLE,
  CONSTRAINT `employee`
    FOREIGN KEY (`employeeID`)
    REFERENCES `mm_cpsc502101team01`.`Employee` (`employeeID`))
ENGINE = InnoDB
AUTO_INCREMENT = 1999
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mm_cpsc502101team01`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mm_cpsc502101team01`.`Payment` (
  `customerID` INT NOT NULL,
  `saleID` INT NOT NULL,
  `prescriptionID` INT NOT NULL,
  `createdAt` TIMESTAMP NULL DEFAULT NULL,
  `amount` DECIMAL(10,2) NULL DEFAULT NULL,
  `status` VARCHAR(45) NULL DEFAULT NULL,
  `method` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`customerID`, `saleID`, `prescriptionID`),
  INDEX `fk_Payment_Customer1_idx` (`customerID` ASC) VISIBLE,
  INDEX `fk_Payment_Sale1_idx` (`saleID` ASC) VISIBLE,
  INDEX `fk_Payment_Prescription1_idx` (`prescriptionID` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_Customer1`
    FOREIGN KEY (`customerID`)
    REFERENCES `mm_cpsc502101team01`.`Customer` (`customerID`),
  CONSTRAINT `fk_Payment_Prescription1`
    FOREIGN KEY (`prescriptionID`)
    REFERENCES `mm_cpsc502101team01`.`Prescription` (`prescriptionID`),
  CONSTRAINT `fk_Payment_Sale1`
    FOREIGN KEY (`saleID`)
    REFERENCES `mm_cpsc502101team01`.`Sale` (`saleID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mm_cpsc502101team01`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mm_cpsc502101team01`.`Product` (
  `productID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(300) NULL DEFAULT NULL,
  `brand` VARCHAR(300) NULL DEFAULT NULL,
  `price` DECIMAL(10,2) NULL DEFAULT NULL,
  `color` VARCHAR(45) NULL DEFAULT NULL,
  `size` VARCHAR(5) NULL DEFAULT NULL,
  `quantity` INT NULL DEFAULT NULL,
  `createdAt` TIMESTAMP NULL DEFAULT NULL,
  `updatedAt` TIMESTAMP NULL DEFAULT NULL,
  `description` VARCHAR(500) NULL DEFAULT NULL,
  `category` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`productID`))
ENGINE = InnoDB
AUTO_INCREMENT = 2001
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mm_cpsc502101team01`.`PrescriptionProduct`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mm_cpsc502101team01`.`PrescriptionProduct` (
  `prescriptionID` INT NOT NULL,
  `productID` INT NOT NULL,
  `quantity` VARCHAR(45) NULL DEFAULT NULL,
  `unit` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(500) NULL DEFAULT NULL,
  `createdAt` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`prescriptionID`, `productID`),
  INDEX `fk_Prescription_has_Product_Product1_idx` (`productID` ASC) VISIBLE,
  INDEX `fk_Prescription_has_Product_Prescription1_idx` (`prescriptionID` ASC) VISIBLE,
  CONSTRAINT `fk_Prescription_has_Product_Prescription1`
    FOREIGN KEY (`prescriptionID`)
    REFERENCES `mm_cpsc502101team01`.`Prescription` (`prescriptionID`),
  CONSTRAINT `fk_Prescription_has_Product_Product1`
    FOREIGN KEY (`productID`)
    REFERENCES `mm_cpsc502101team01`.`Product` (`productID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `mm_cpsc502101team01`.`SaleProduct`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mm_cpsc502101team01`.`SaleProduct` (
  `saleID` INT NOT NULL,
  `productID` INT NOT NULL,
  `quantity` INT NULL DEFAULT NULL,
  `description` VARCHAR(45) NULL DEFAULT NULL,
  `createdAt` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`saleID`, `productID`),
  INDEX `fk_Sale_has_Product_Product1_idx` (`productID` ASC) VISIBLE,
  INDEX `fk_Sale_has_Product_Sale1_idx` (`saleID` ASC) VISIBLE,
  CONSTRAINT `fk_Sale_has_Product_Product1`
    FOREIGN KEY (`productID`)
    REFERENCES `mm_cpsc502101team01`.`Product` (`productID`),
  CONSTRAINT `fk_Sale_has_Product_Sale1`
    FOREIGN KEY (`saleID`)
    REFERENCES `mm_cpsc502101team01`.`Sale` (`saleID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
