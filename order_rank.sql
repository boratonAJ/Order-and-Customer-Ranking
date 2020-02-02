-- MySQL Script generated by MySQL Workbench
-- Wed Jan 29 10:20:50 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema inventory_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema inventory_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `inventory_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `inventory_db` ;

-- -----------------------------------------------------
-- Table `inventory_db`.`customer_orders_rank_tb`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_db`.`customer_orders_rank_tb` (
  `customerid` INT NOT NULL,
  `orderid` INT NOT NULL,
  `rank_id` INT NOT NULL,
  PRIMARY KEY (`orderid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inventory_db`.`customer_orders_tb`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_db`.`customer_orders_tb` (
  `createdat` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `orderid` INT NOT NULL,
  `restaurantstatus` VARCHAR(45) NULL DEFAULT NULL,
  `paymentmethod` VARCHAR(45) NULL DEFAULT NULL,
  `subtotal` DECIMAL(45,0) NULL DEFAULT NULL,
  `customerid` INT NOT NULL,
  `restaurantname` VARCHAR(150) NULL DEFAULT NULL,
  `customeraddressprovince` VARCHAR(45) NULL DEFAULT NULL,
  `restaurantacceptedat` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `foodpreparedpromised` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `podactual` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`orderid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;