-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Hotel
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Hotel
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Hotel` DEFAULT CHARACTER SET utf8 ;
USE `Hotel` ;

-- -----------------------------------------------------
-- Table `Hotel`.`RoomType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hotel`.`RoomType` ;

CREATE TABLE IF NOT EXISTS `Hotel`.`RoomType` (
  `RoomTypeId` INT NOT NULL AUTO_INCREMENT,
  `RoomTypeName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`RoomTypeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel`.`Room`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hotel`.`Room` ;

CREATE TABLE IF NOT EXISTS `Hotel`.`Room` (
  `RoomId` INT NOT NULL AUTO_INCREMENT,
  `AdaAccessible` TINYINT NOT NULL,
  `StandardOccupancy` INT NOT NULL,
  `MaxOccupancy` INT NOT NULL,
  `BasePrice` DECIMAL(10,2) NOT NULL,
  `ExtraPerson` DECIMAL(4,0) NULL,
  `RoomType_RoomTypeId` INT NOT NULL,
  PRIMARY KEY (`RoomId`),
  INDEX `fk_Room_RoomType` (`RoomType_RoomTypeId` ASC) VISIBLE,
  CONSTRAINT `fk_Room_RoomType1`
    FOREIGN KEY (`RoomType_RoomTypeId`)
    REFERENCES `Hotel`.`RoomType` (`RoomTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel`.`Guest`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hotel`.`Guest` ;

CREATE TABLE IF NOT EXISTS `Hotel`.`Guest` (
  `GuestId` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(50) NOT NULL,
  `Address` VARCHAR(50) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `State` VARCHAR(25) NOT NULL,
  `Zip` VARCHAR(25) NOT NULL,
  `Phone` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`GuestId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel`.`Reservation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hotel`.`Reservation` ;

CREATE TABLE IF NOT EXISTS `Hotel`.`Reservation` (
  `ReservationId` INT NOT NULL AUTO_INCREMENT,
  `NumAdults` INT NOT NULL,
  `NumChildren` INT NOT NULL,
  `StartDate` DATE NOT NULL,
  `EndDate` DATE NOT NULL,
  `TotalCost` DECIMAL(10,2) NOT NULL,
  `Guest_GuestId` INT NOT NULL,
  PRIMARY KEY (`ReservationId`),
  INDEX `fk_Reservation_Guest` (`Guest_GuestId` ASC) VISIBLE,
  CONSTRAINT `fk_Reservation_Guest`
    FOREIGN KEY (`Guest_GuestId`)
    REFERENCES `Hotel`.`Guest` (`GuestId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel`.`Amenity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hotel`.`Amenity` ;

CREATE TABLE IF NOT EXISTS `Hotel`.`Amenity` (
  `AmenityId` INT NOT NULL AUTO_INCREMENT,
  `AmenityName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`AmenityId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel`.`RoomAmenities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hotel`.`RoomAmenities` ;

CREATE TABLE IF NOT EXISTS `Hotel`.`RoomAmenities` (
  `Room_RoomId` INT NOT NULL,
  `Amenity_AmenityId` INT NOT NULL,
  PRIMARY KEY (`Room_RoomId`, `Amenity_AmenityId`),
  INDEX `fk_RoomAmenities_Amenity` (`Amenity_AmenityId` ASC) VISIBLE,
  CONSTRAINT `fk_RoomAmenities_Room1`
    FOREIGN KEY (`Room_RoomId`)
    REFERENCES `Hotel`.`Room` (`RoomId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RoomAmenities_Amenity1`
    FOREIGN KEY (`Amenity_AmenityId`)
    REFERENCES `Hotel`.`Amenity` (`AmenityId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel`.`RoomReservation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Hotel`.`RoomReservation` ;

CREATE TABLE IF NOT EXISTS `Hotel`.`RoomReservation` (
  `Room_RoomId` INT NOT NULL,
  `Reservation_ReservationId` INT NOT NULL,
  PRIMARY KEY (`Room_RoomId`, `Reservation_ReservationId`),
  INDEX `fk_Room_has_Reservation_Reservation` (`Reservation_ReservationId` ASC) VISIBLE,
  INDEX `fk_Room_has_Reservation_Room` (`Room_RoomId` ASC) VISIBLE,
  CONSTRAINT `fk_Room_has_Reservation_Room1`
    FOREIGN KEY (`Room_RoomId`)
    REFERENCES `Hotel`.`Room` (`RoomId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Room_has_Reservation_Reservation1`
    FOREIGN KEY (`Reservation_ReservationId`)
    REFERENCES `Hotel`.`Reservation` (`ReservationId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
