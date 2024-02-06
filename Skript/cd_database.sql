-- ###################################################
-- CD database schema
-- run this file first to build Table structure in SQL_Info2
-- then run "cd_database_data.sql" in order to fill it with some data
-- by Matthias Obermaier, 2021, after Normalising scheme and Data
-- found on Wikipedia
-- ###################################################

-- Make DB if it doesn't exist
-- probably gives a warning if it actually does already exist
CREATE DATABASE IF NOT EXISTS `sqlinfo`;

-- Use DB
USE `sqlinfo`;

-- Drop (Delete) Tables first, in the correct order so that Foreign Key
-- constraints are resolved (see comments to CREATE TABLEs!)
DROP TABLE IF EXISTS `CD_Songs`;
DROP TABLE IF EXISTS `CD_Albums`;
DROP TABLE IF EXISTS `CD_Artist`;
DROP TABLE IF EXISTS `CD_Changelog`;


-- Create 3 Tables; due to Forein Key Constraint (CD_Albums.Interpret_ID is
-- Foreign Key to CD_Artist.Interpret_ID), CD_Artist has to be created first!
-- Same for CD_Songs and its FK
-- CD_Songs.CD_ID --FK--> CD_Albums.CD_ID
CREATE TABLE `CD_Artist` (`Interpret_ID` INT NOT NULL, `Name` VARCHAR(50),
        `Year_Established` INT, PRIMARY KEY(`Interpret_ID`));

CREATE TABLE `CD_Albums` (`CD_ID` INT NOT NULL AUTO_INCREMENT,
        `Title` VARCHAR(50), `Interpret_ID` INT NOT NULL, `Release_Year` INT,
        PRIMARY KEY(`CD_ID`), CONSTRAINT `inter_id` FOREIGN KEY (`Interpret_ID`)
        REFERENCES `CD_Artist` (`Interpret_ID`) ON UPDATE CASCADE
        ON DELETE CASCADE) AUTO_INCREMENT=1001;

CREATE TABLE `CD_Songs` (`CD_ID` INT NOT NULL, `Track_ID` SMALLINT NOT NULL,
        `Title` VARCHAR(50), PRIMARY KEY(`CD_ID`, `Track_ID`),
        CONSTRAINT `cd_id` FOREIGN KEY (`CD_ID`)
        REFERENCES `CD_Albums` (`CD_ID`) ON UPDATE CASCADE ON DELETE CASCADE);

-- Create an additional changelog table; ID autoincrement from 10001,
-- change_time of type DATETIME with default CURRENT_TIMESTAMP
-- (synonyms for that: CURRENT_TIMESTAMP(), NOW(), LOCALTIME() etc...)
CREATE TABLE `CD_Changelog` (`CH_ID` INT NOT NULL AUTO_INCREMENT,
    `CD_ID` INT NOT NULL, `old_albumtitle` VARCHAR(50),
    `new_albumtitle` VARCHAR(50), `change_time` DATETIME
    DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY(`CH_ID`))AUTO_INCREMENT = 10001;
