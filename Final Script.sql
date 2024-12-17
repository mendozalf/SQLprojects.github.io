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
  `locations_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `location_name` VARCHAR(45) NOT NULL,
  `location_street` VARCHAR(45) NOT NULL,
  `location_city` VARCHAR(45) NOT NULL,
  `location_zip` INT(5) UNSIGNED NOT NULL,
  `location_state` VARCHAR(2) NOT NULL,
  `date_open` DATE NOT NULL,
  PRIMARY KEY (`locations_id`))
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
  `locations_id1` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`media_id`),
  INDEX `fk_media_locations1_idx` (`locations_id1` ASC) VISIBLE,
  CONSTRAINT `fk_media_locations1`
    FOREIGN KEY (`locations_id1`)
    REFERENCES `libraryDB`.`locations` (`locations_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `libraryDB`.`customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `libraryDB`.`customers` ;

CREATE TABLE IF NOT EXISTS `libraryDB`.`customers` (
  `customers_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
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
-- Table `libraryDB`.`sections`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `libraryDB`.`sections` ;

CREATE TABLE IF NOT EXISTS `libraryDB`.`sections` (
  `sections_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `section_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`sections_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `libraryDB`.`genres`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `libraryDB`.`genres` ;

CREATE TABLE IF NOT EXISTS `libraryDB`.`genres` (
  `genres_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `genre_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`genres_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `libraryDB`.`librarians`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `libraryDB`.`librarians` ;

CREATE TABLE IF NOT EXISTS `libraryDB`.`librarians` (
  `librarians_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
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
  `media_id` INT UNSIGNED NOT NULL,
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
-- Table `libraryDB`.`genres_has_media`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `libraryDB`.`genres_has_media` ;

CREATE TABLE IF NOT EXISTS `libraryDB`.`genres_has_media` (
  `genres_id` INT UNSIGNED NOT NULL,
  `media_id` INT UNSIGNED NOT NULL,
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


-- -----------------------------------------------------
-- Table `libraryDB`.`checkout`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `libraryDB`.`checkout` ;

CREATE TABLE IF NOT EXISTS `libraryDB`.`checkout` (
  `checkout_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `customers_id` INT UNSIGNED NOT NULL,
  `media_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`checkout_id`),
  INDEX `fk_checkout_customers1_idx` (`customers_id` ASC) VISIBLE,
  INDEX `fk_checkout_media1_idx` (`media_id` ASC) VISIBLE,
  CONSTRAINT `fk_checkout_customers1`
    FOREIGN KEY (`customers_id`)
    REFERENCES `libraryDB`.`customers` (`customers_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_checkout_media1`
    FOREIGN KEY (`media_id`)
    REFERENCES `libraryDB`.`media` (`media_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

# Insert values in the locations table.
INSERT INTO locations VALUES(default, 'Novel Idea Library', 'First Street', 'Rexburg', 83440, 'ID', '2023-10-27');
INSERT INTO locations VALUES(default, 'Cosmic Library', 'Second Street', 'Rexburg', 83440, 'ID', '2023-09-27');
SELECT * from locations;

# Insert values in the librarians table.
INSERT INTO librarians VALUES(default, (SELECT locations_id FROM locations WHERE location_name = 'Novel Idea Library'), 'Thomas', 'Da Ville', '2023-10-28');
SELECT * FROM librarians;
INSERT INTO librarians VALUES(default, (SELECT locations_id FROM locations WHERE location_name = 'Novel Idea Library'), 'Eric', 'Savea', '2023-10-29');

# Insert values in the sections table.
INSERT INTO sections VALUES(default, 'Teen');
INSERT INTO sections VALUES(default, 'Adult');
INSERT INTO sections VALUES(default, 'Children');
INSERT INTO sections VALUES(default, 'Non Fiction');
INSERT INTO sections VALUES(default, 'DVDs');
INSERT INTO sections VALUES(default, 'CDs');

# Insert values in the genres table.
INSERT INTO genres VALUES(default, 'Fantasy');
INSERT INTO genres VALUES(default, 'Mistery');
INSERT INTO genres VALUES(default, 'Drama');
INSERT INTO genres VALUES(default, 'Comedy');
INSERT INTO genres VALUES(default, 'Romance');
INSERT INTO genres VALUES(default, 'Adventure');
INSERT INTO genres VALUES(default, 'Science Fiction');
INSERT INTO genres VALUES(default, 'Sports');
INSERT INTO genres VALUES(default, 'Action');
INSERT INTO genres VALUES(default, 'Horror');

# # Insert values in the customer table.
INSERT INTO customers VALUES(default,(SELECT locations_id FROM locations WHERE location_name = 'Cosmic Library'), 'Tazmine', 'Tobler', '2023-11-11', 15);
INSERT INTO customers VALUES(default,(SELECT locations_id FROM locations WHERE location_name = 'Cosmic Library'), 'Tithing', 'Kempton', '2023-12-11', 36);
INSERT INTO customers VALUES(default,(SELECT locations_id FROM locations WHERE location_name = 'Cosmic Library'), 'Lant', 'Benson', '2023-12-11', 10);
INSERT INTO customers VALUES(default,(SELECT locations_id FROM locations WHERE location_name = 'Cosmic Library'), 'Cesare', 'Sanzone', '2023-11-11', 17);
INSERT INTO customers VALUES(default,(SELECT locations_id FROM locations WHERE location_name = 'Cosmic Library'), 'Molly', 'Heskett', '2023-11-12', 11);
INSERT INTO customers VALUES(default,(SELECT locations_id FROM locations WHERE location_name = 'Novel Idea Library'), 'Angel', 'Parrish', '2023-11-01', 37);
INSERT INTO customers VALUES(default,(SELECT locations_id FROM locations WHERE location_name = 'Novel Idea Library'), 'Keith', 'Cage', '2023-11-02', 45);
INSERT INTO customers VALUES(default,(SELECT locations_id FROM locations WHERE location_name = 'Novel Idea Library'), 'Ed', 'Duke', '2023-11-12', 12);
INSERT INTO customers VALUES(default,(SELECT locations_id FROM locations WHERE location_name = 'Novel Idea Library'), 'Mell', 'Arthur', '2023-11-16', 21);
INSERT INTO customers VALUES(default,(SELECT locations_id FROM locations WHERE location_name = 'Novel Idea Library'), 'Elliot', 'Joy', '2023-11-11', 31);
INSERT INTO customers VALUES(default,(SELECT locations_id FROM locations WHERE location_name = 'Novel Idea Library'), 'Caden', 'Crane', '2023-11-20', 47);

# Insert values in the media table.
INSERT INTO media VALUES(default, 'Knight On My Journey', 'Book', '2023-11-01', 'Hugh', 'Huddleston', '007', '1992-09-18',(SELECT locations_id FROM locations WHERE location_name = 'Cosmic Library'));
INSERT INTO media VALUES(default, 'Enemies Without Borders', 'Book', '2023-11-10', 'Zaky', 'El-Hababi', '160', '1994-08-30',(SELECT locations_id FROM locations WHERE location_name = 'Cosmic Library'));
INSERT INTO media VALUES(default, 'Trees Of The South', 'Book', '2023-11-02', 'Arwarh', 'Ghallab', '810', '1900-09-10',(SELECT locations_id FROM locations WHERE location_name = 'Cosmic Library'));
INSERT INTO media VALUES(default, 'Throne Of The Banner', 'Book', '2023-11-03', 'Omar', 'Al-Tayyeb', '810', '1985-01-15',(SELECT locations_id FROM locations WHERE location_name = 'Novel Idea Library'));
INSERT INTO media VALUES(default, 'Meeting At Eternity', 'Book', '2023-11-05', 'Naziha', 'Tazi', '210', '1966-05-26',(SELECT locations_id FROM locations WHERE location_name = 'Novel Idea Library'));
INSERT INTO media VALUES(default, 'Perfection Of Snow', 'Book', '2023-11-01', 'Hakima', 'Laroui', '810', '1999-07-31',(SELECT locations_id FROM locations WHERE location_name = 'Novel Idea Library'));
INSERT INTO media VALUES(default, 'Live and learn', 'CDs', '2023-11-05', 'Allen', 'Clare', '000', '1992-08-18',(SELECT locations_id FROM locations WHERE location_name = 'Cosmic Library'));
INSERT INTO media VALUES(default, 'Beas of beauty', 'CDs', '2023-11-17', 'Mike', 'Keith', '000', '1994-05-30',(SELECT locations_id FROM locations WHERE location_name = 'Cosmic Library'));
INSERT INTO media VALUES(default, 'Class act', 'CDs', '2023-11-09', 'Shay', 'Mell', '000', '1980-12-10',(SELECT locations_id FROM locations WHERE location_name = 'Cosmic Library'));
INSERT INTO media VALUES(default, 'Eye to eye', 'CDs', '2023-11-20', 'Logan', 'Carroll', '000', '1987-03-15',(SELECT locations_id FROM locations WHERE location_name = 'Novel Idea Library'));
INSERT INTO media VALUES(default, 'Do not push this button', 'CDs', '2023-11-12', 'Jess', 'Kingsley', '000', '1988-08-26',(SELECT locations_id FROM locations WHERE location_name = 'Novel Idea Library'));
INSERT INTO media VALUES(default, 'Apparatus', 'CDs', '2023-11-01', 'Elliot', 'Fierce', '000', '1999-11-23',(SELECT locations_id FROM locations WHERE location_name = 'Novel Idea Library'));
INSERT INTO media VALUES(default, 'The Daydream Plunderers', 'DVDs', '2023-11-10', 'Ehehene', 'Nohealani', '000', '2000-08-18',(SELECT locations_id FROM locations WHERE location_name = 'Cosmic Library'));
INSERT INTO media VALUES(default, 'The Full Sail Buccaneers', 'DVDs', '2023-11-15', 'Makala', 'Kamali', '000', '2005-05-30',(SELECT locations_id FROM locations WHERE location_name = 'Cosmic Library'));
INSERT INTO media VALUES(default, 'Bureau Of Felonies', 'DVDs', '2023-11-09', 'Kamamalu', 'Kawai', '000', '2017-10-10',(SELECT locations_id FROM locations WHERE location_name = 'Cosmic Library'));
INSERT INTO media VALUES(default, 'Global Dream Zapper Apparatus', 'DVDs','2023-11-22', 'Kawelo', 'Laemoa', '000', '1997-09-15',(SELECT locations_id FROM locations WHERE location_name = 'Novel Idea Library'));
INSERT INTO media VALUES(default, 'Tactical Air Mutator Matrix', 'DVDs', '2023-11-03', 'Keonaona', 'Leilani', '000', '1999-07-26',(SELECT locations_id FROM locations WHERE location_name = 'Novel Idea Library'));
INSERT INTO media VALUES(default, 'Message Analyzer Network', 'DVDs', '2023-11-09', 'Keala', 'Kaia', '000', '1998-12-23',(SELECT locations_id FROM locations WHERE location_name = 'Novel Idea Library'));

# Insert values in the checkout table.
INSERT INTO checkout VALUES(default,(SELECT customers_id FROM customers WHERE card_id = 15), (SELECT media_id FROM media WHERE media_name = 'Knight On My Journey'));
INSERT INTO checkout VALUES(default,(SELECT customers_id FROM customers WHERE card_id = 36), (SELECT media_id FROM media WHERE media_name = 'Enemies Without Borders'));
INSERT INTO checkout VALUES(default,(SELECT customers_id FROM customers WHERE card_id = 10), (SELECT media_id FROM media WHERE media_name = 'Trees Of The South'));
INSERT INTO checkout VALUES(default,(SELECT customers_id FROM customers WHERE card_id = 17), (SELECT media_id FROM media WHERE media_name = 'Throne Of The Banner'));
INSERT INTO checkout VALUES(default,(SELECT customers_id FROM customers WHERE card_id = 11), (SELECT media_id FROM media WHERE media_name = 'Meeting At Eternity'));
INSERT INTO checkout VALUES(default,(SELECT customers_id FROM customers WHERE card_id = 37), (SELECT media_id FROM media WHERE media_name = 'Perfection Of Snow'));
INSERT INTO checkout VALUES(default,(SELECT customers_id FROM customers WHERE card_id = 45), (SELECT media_id FROM media WHERE media_name = 'Live and learn'));
INSERT INTO checkout VALUES(default,(SELECT customers_id FROM customers WHERE card_id = 12), (SELECT media_id FROM media WHERE media_name = 'Beas of beauty'));
INSERT INTO checkout VALUES(default,(SELECT customers_id FROM customers WHERE card_id = 21), (SELECT media_id FROM media WHERE media_name = 'Class act'));
INSERT INTO checkout VALUES(default,(SELECT customers_id FROM customers WHERE card_id = 31), (SELECT media_id FROM media WHERE media_name = 'Eye to eye'));
INSERT INTO checkout VALUES(default,(SELECT customers_id FROM customers WHERE card_id = 47), (SELECT media_id FROM media WHERE media_name = 'Do not push this button'));

# Insert values in the genres_has_media table.
INSERT INTO genres_has_media VALUES((SELECT genres_id FROM genres WHERE genres_id = 1), (SELECT media_id FROM media WHERE media_name = 'Enemies Without Borders'));
INSERT INTO genres_has_media VALUES((SELECT genres_id FROM genres WHERE genres_id = 2), (SELECT media_id FROM media WHERE media_name = 'Trees Of The South'));
INSERT INTO genres_has_media VALUES((SELECT genres_id FROM genres WHERE genres_id = 3), (SELECT media_id FROM media WHERE media_name = 'Throne Of The Banner'));
INSERT INTO genres_has_media VALUES((SELECT genres_id FROM genres WHERE genres_id = 4), (SELECT media_id FROM media WHERE media_name = 'Meeting At Eternity'));
INSERT INTO genres_has_media VALUES((SELECT genres_id FROM genres WHERE genres_id = 5), (SELECT media_id FROM media WHERE media_name = 'Perfection Of Snow'));
INSERT INTO genres_has_media VALUES((SELECT genres_id FROM genres WHERE genres_id = 6), (SELECT media_id FROM media WHERE media_name = 'Live and learn'));
INSERT INTO genres_has_media VALUES((SELECT genres_id FROM genres WHERE genres_id = 7), (SELECT media_id FROM media WHERE media_name = 'Beas of beauty'));
INSERT INTO genres_has_media VALUES((SELECT genres_id FROM genres WHERE genres_id = 8), (SELECT media_id FROM media WHERE media_name = 'Class act'));
INSERT INTO genres_has_media VALUES((SELECT genres_id FROM genres WHERE genres_id = 9), (SELECT media_id FROM media WHERE media_name = 'Eye to eye'));
INSERT INTO genres_has_media VALUES((SELECT genres_id FROM genres WHERE genres_id = 10), (SELECT media_id FROM media WHERE media_name = 'Do not push this button'));
INSERT INTO genres_has_media VALUES((SELECT genres_id FROM genres WHERE genres_id = 11), (SELECT media_id FROM media WHERE media_name = 'Apparatus'));

# Insert values in the media_in_sections table.
INSERT INTO media_in_sectios VALUES((SELECT sections_id FROM sections WHERE  section_name = 'Non Fiction'), (SELECT media_id FROM media WHERE media_name = 'Knight On My Journey'));
INSERT INTO media_in_sectios VALUES((SELECT sections_id FROM sections WHERE  section_name = 'Teen'), (SELECT media_id FROM media WHERE media_name = 'Enemies Without Borders'));
INSERT INTO media_in_sectios VALUES((SELECT sections_id FROM sections WHERE  section_name = 'Children'), (SELECT media_id FROM media WHERE media_name = 'Perfection Of Snow'));
INSERT INTO media_in_sectios VALUES((SELECT sections_id FROM sections WHERE  section_name = 'Non Fiction'), (SELECT media_id FROM media WHERE media_name = 'Trees Of The South'));
INSERT INTO media_in_sectios VALUES((SELECT sections_id FROM sections WHERE  section_name = 'Non Fiction'), (SELECT media_id FROM media WHERE media_name = 'Meeting At Eternity'));
INSERT INTO media_in_sectios VALUES((SELECT sections_id FROM sections WHERE  section_name = 'DVDs'), (SELECT media_id FROM media WHERE media_name = 'Live and learn'));
INSERT INTO media_in_sectios VALUES((SELECT sections_id FROM sections WHERE  section_name = 'CDs'), (SELECT media_id FROM media WHERE media_name = 'Beas of beauty'));
INSERT INTO media_in_sectios VALUES((SELECT sections_id FROM sections WHERE  section_name = 'Adult'), (SELECT media_id FROM media WHERE media_name = 'Class act'));
INSERT INTO media_in_sectios VALUES((SELECT sections_id FROM sections WHERE  section_name = 'Non Fiction'), (SELECT media_id FROM media WHERE media_name = 'Apparatus'));
INSERT INTO media_in_sectios VALUES((SELECT sections_id FROM sections WHERE  section_name = 'Teen'), (SELECT media_id FROM media WHERE media_name = 'Tactical Air Mutator Matrix'));

# Select everything from all tables;
SELECT * FROM checkout;
SELECT * FROM customers;
SELECT * FROM genres;
SELECT * FROM genres_has_media;
SELECT * FROM librarians;
SELECT * FROM locations;
SELECT * FROM media;
SELECT * FROM media_in_sectios;
SELECT * FROM sections;

