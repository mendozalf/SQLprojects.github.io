-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema libraryDB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `libraryDB` ;

-- -----------------------------------------------------
-- Schema libraryDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `libraryDB` DEFAULT CHARACTER SET utf8 ;
USE `libraryDB` ;

-- -----------------------------------------------------
-- Table `libraryDB`.`locations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `libraryDB`.`locations` ;

CREATE TABLE IF NOT EXISTS `libraryDB`.`locations` (
  `locations_id` INT UNSIGNED NOT NULL,
  `location_name` VARCHAR(45) NOT NULL,
  `location_street` VARCHAR(45) NOT NULL,
  `location_city` VARCHAR(45) NOT NULL,
  `location_zip` INT(5) UNSIGNED NOT NULL,
  `location_state` VARCHAR(2) NOT NULL,
  `date_open` DATE NOT NULL,
  PRIMARY KEY (`locations_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `libraryDB`.`customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `libraryDB`.`customers` ;

CREATE TABLE IF NOT EXISTS `libraryDB`.`customers` (
  `customers_id` INT UNSIGNED NOT NULL,
  `locations_id` INT UNSIGNED NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `start_date` DATE NOT NULL,
  `card_id` INT NOT NULL,
  PRIMARY KEY (`customers_id`),
  INDEX `customers_fk_1` (`locations_id` ASC) VISIBLE,
  CONSTRAINT `fk_patrons_locations1`
    FOREIGN KEY (`locations_id`)
    REFERENCES `libraryDB`.`locations` (`locations_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `libraryDB`.`checkout`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `libraryDB`.`checkout` ;

CREATE TABLE IF NOT EXISTS `libraryDB`.`checkout` (
  `checkout_id` INT UNSIGNED NOT NULL,
  `customers_id` INT UNSIGNED NOT NULL,
  `locations_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`checkout_id`),
  INDEX `fk_customers_has_checkout_customers1_idx` (`customers_id` ASC, `locations_id` ASC) VISIBLE,
  CONSTRAINT `checkout_fk_1`
    FOREIGN KEY (`customers_id` , `locations_id`)
    REFERENCES `libraryDB`.`customers` (`customers_id` , `locations_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `libraryDB`.`lookup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `libraryDB`.`lookup` ;

CREATE TABLE IF NOT EXISTS `libraryDB`.`lookup` (
  `lookup_id` INT NOT NULL AUTO_INCREMENT,
  `table_name` VARCHAR(45) NOT NULL,
  `column_name` VARCHAR(45) NOT NULL,
  `column_type` VARCHAR(45) NOT NULL,
  `lang` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`lookup_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `libraryDB`.`media`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `libraryDB`.`media` ;

CREATE TABLE IF NOT EXISTS `libraryDB`.`media` (
  `media_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `media_name` VARCHAR(100) NOT NULL,
  `media_type` VARCHAR(45) NOT NULL,
  `date_received` DATE NOT NULL,
  `author_first_name` VARCHAR(45) NOT NULL,
  `author_last_name` VARCHAR(45) NOT NULL,
  `dd_id` VARCHAR(45) NOT NULL,
  `publish_date` DATE NOT NULL,
  `customers_id` INT UNSIGNED NOT NULL,
  `locations_id` INT UNSIGNED NOT NULL,
  `checkout_id` INT UNSIGNED NOT NULL,
  `Lookup_id` INT NOT NULL,
  PRIMARY KEY (`media_id`, `customers_id`, `locations_id`, `checkout_id`),
  INDEX `media_fk_2` (`customers_id` ASC, `locations_id` ASC, `checkout_id` ASC) VISIBLE,
  INDEX `fk_Media_Lookup1_idx` (`Lookup_id` ASC) VISIBLE,
  CONSTRAINT `fk_Media_customers_has_checkout1`
    FOREIGN KEY (`customers_id` , `locations_id` , `checkout_id`)
    REFERENCES `libraryDB`.`checkout` (`customers_id` , `locations_id` , `checkout_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Media_Lookup1`
    FOREIGN KEY (`Lookup_id`)
    REFERENCES `libraryDB`.`lookup` (`lookup_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `libraryDB`.`sections`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `libraryDB`.`sections` ;

CREATE TABLE IF NOT EXISTS `libraryDB`.`sections` (
  `sections_id` INT UNSIGNED NOT NULL,
  `section_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`sections_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `libraryDB`.`genres`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `libraryDB`.`genres` ;

CREATE TABLE IF NOT EXISTS `libraryDB`.`genres` (
  `genres_id` INT UNSIGNED NOT NULL,
  `genre_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`genres_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `libraryDB`.`librarians`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `libraryDB`.`librarians` ;

CREATE TABLE IF NOT EXISTS `libraryDB`.`librarians` (
  `librarians_id` INT UNSIGNED NOT NULL,
  `locations_id` INT UNSIGNED NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `start_date` DATE NOT NULL,
  PRIMARY KEY (`librarians_id`),
  INDEX `fk_Librarians_locations1_idx` (`locations_id` ASC) VISIBLE,
  CONSTRAINT `librarians_fk_1`
    FOREIGN KEY (`locations_id`)
    REFERENCES `libraryDB`.`locations` (`locations_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `libraryDB`.`media_in_sectios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `libraryDB`.`media_in_sectios` ;

CREATE TABLE IF NOT EXISTS `libraryDB`.`media_in_sectios` (
  `sections_id` INT UNSIGNED NOT NULL,
  `media_id` INT NOT NULL,
  PRIMARY KEY (`sections_id`, `media_id`),
  INDEX `fk_sections_has_books_books1_idx` (`media_id` ASC) VISIBLE,
  INDEX `fk_sections_has_books_sections_idx` (`sections_id` ASC) VISIBLE,
  CONSTRAINT `fk_sections_has_books_sections`
    FOREIGN KEY (`sections_id`)
    REFERENCES `libraryDB`.`sections` (`sections_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sections_has_books_books1`
    FOREIGN KEY (`media_id`)
    REFERENCES `libraryDB`.`media` (`media_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `libraryDB`.`locations_has_media`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `libraryDB`.`locations_has_media` ;

CREATE TABLE IF NOT EXISTS `libraryDB`.`locations_has_media` (
  `media_id` INT NOT NULL,
  `locations_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`media_id`, `locations_id`),
  INDEX `fk_locations_has_books_books1_idx` (`media_id` ASC) VISIBLE,
  INDEX `fk_locations_has_media_locations1_idx` (`locations_id` ASC) VISIBLE,
  CONSTRAINT `fk_locations_has_books_books1`
    FOREIGN KEY (`media_id`)
    REFERENCES `libraryDB`.`media` (`media_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_locations_has_media_locations1`
    FOREIGN KEY (`locations_id`)
    REFERENCES `libraryDB`.`locations` (`locations_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `libraryDB`.`genres_has_media`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `libraryDB`.`genres_has_media` ;

CREATE TABLE IF NOT EXISTS `libraryDB`.`genres_has_media` (
  `genres_id` INT UNSIGNED NOT NULL,
  `media_id` INT NOT NULL,
  PRIMARY KEY (`genres_id`, `media_id`),
  INDEX `fk_Genres_has_books_books1_idx` (`media_id` ASC) VISIBLE,
  INDEX `fk_Genres_has_books_Genres1_idx` (`genres_id` ASC) VISIBLE,
  CONSTRAINT `fk_Genres_has_books_Genres1`
    FOREIGN KEY (`genres_id`)
    REFERENCES `libraryDB`.`genres` (`genres_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Genres_has_books_books1`
    FOREIGN KEY (`media_id`)
    REFERENCES `libraryDB`.`media` (`media_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
