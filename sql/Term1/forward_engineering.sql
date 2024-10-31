-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema termproject1_zsg
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema termproject1_zsg
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `termproject1_zsg` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `termproject1_zsg` ;

-- -----------------------------------------------------
-- Table `termproject1_zsg`.`births`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `termproject1_zsg`.`births` (
  `year` INT NOT NULL,
  `month` INT NOT NULL,
  `births` INT NOT NULL,
  PRIMARY KEY (`year`, `month`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `termproject1_zsg`.`can_cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `termproject1_zsg`.`can_cities` (
  `city` VARCHAR(100) NOT NULL,
  `country` VARCHAR(30) NULL DEFAULT NULL,
  `pop2024` INT NULL DEFAULT NULL,
  PRIMARY KEY (`city`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `termproject1_zsg`.`player_birth`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `termproject1_zsg`.`player_birth` (
  `player_id` INT NOT NULL,
  `first_name` VARCHAR(20) NULL DEFAULT NULL,
  `last_name` VARCHAR(20) NULL DEFAULT NULL,
  `birth_date` DATE NULL DEFAULT NULL,
  `birth_city` VARCHAR(30) NULL DEFAULT NULL,
  `birth_country` VARCHAR(20) NULL DEFAULT NULL,
  `birth_state_province` VARCHAR(30) NULL DEFAULT NULL,
  `birth_year` INT NOT NULL,
  `birth_month` INT NOT NULL,
  PRIMARY KEY (`player_id`),
  INDEX `birthconn_idx` (`birth_year` ASC, `birth_month` ASC) VISIBLE,
  INDEX `ciyiconn_idx` (`birth_city` ASC) VISIBLE,
  CONSTRAINT `birthconn`
    FOREIGN KEY (`birth_year` , `birth_month`)
    REFERENCES `termproject1_zsg`.`births` (`year` , `month`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ciyiconn`
    FOREIGN KEY (`birth_city`)
    REFERENCES `termproject1_zsg`.`can_cities` (`city`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `termproject1_zsg`.`teams`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `termproject1_zsg`.`teams` (
  `team_code` VARCHAR(5) NOT NULL,
  `full_name` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`team_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `termproject1_zsg`.`rosters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `termproject1_zsg`.`rosters` (
  `team_code` VARCHAR(5) NULL DEFAULT NULL,
  `season` INT NULL DEFAULT NULL,
  `position_type` VARCHAR(15) NULL DEFAULT NULL,
  `player_id` INT NOT NULL,
  `headshot` VARCHAR(150) NULL DEFAULT NULL,
  `first_name` VARCHAR(20) NULL DEFAULT NULL,
  `last_name` VARCHAR(20) NULL DEFAULT NULL,
  `sweater_number` INT NULL DEFAULT NULL,
  `position_code` VARCHAR(1) NULL DEFAULT NULL,
  `shoots_catches` VARCHAR(2) NULL DEFAULT NULL,
  `height_in_inches` INT NULL DEFAULT NULL,
  `weight_in_pounds` INT NULL DEFAULT NULL,
  `height_in_centimeters` INT NULL DEFAULT NULL,
  `weight_in_kilograms` INT NULL DEFAULT NULL,
  `birth_date` DATE NULL DEFAULT NULL,
  `birth_city` VARCHAR(30) NULL DEFAULT NULL,
  `birth_country` VARCHAR(30) NULL DEFAULT NULL,
  `birth_state_province` VARCHAR(30) NULL DEFAULT NULL,
  INDEX `playerid_idx` (`player_id` ASC) VISIBLE,
  INDEX `teamcode_idx` (`team_code` ASC) VISIBLE,
  CONSTRAINT `playerid`
    FOREIGN KEY (`player_id`)
    REFERENCES `termproject1_zsg`.`player_birth` (`player_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `teamcode`
    FOREIGN KEY (`team_code`)
    REFERENCES `termproject1_zsg`.`teams` (`team_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
