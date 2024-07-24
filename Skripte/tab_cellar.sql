-- ##################################################
-- Simple wine cellar table with some data
-- by Matthias Obermaier, 2020
-- ##################################################

-- Make DB if it doesn't exist yet
CREATE DATABASE IF NOT EXISTS `SQLInfo`;

-- Use the DB
USE `SQLInfo`;

CREATE TABLE `cellar` (`bin` SMALLINT NOT NULL, `wine` VARCHAR(30),
            `producer` VARCHAR(30), `jahr` SMALLINT, `bottles` SMALLINT,
            `ready` SMALLINT, `comments` VARCHAR(50));

INSERT INTO `cellar` (`bin`, `wine`, `producer`, `jahr`, `bottles`, `ready`)
        VALUES (2, 'Chardonnay', 'Buena Vista', 83, 1, 85);
INSERT INTO `cellar` (`bin`, `wine`, `producer`, `jahr`, `bottles`, `ready`)
        VALUES (3, 'Chardonnay', 'LouisMartini', 81, 5, 84);
INSERT INTO `cellar` (`bin`, `wine`, `producer`, `jahr`, `bottles`, `ready`,
                    `comments`)
        VALUES (6, 'Chardonnay', 'Chappellet', 82, 4, 85, 'Thanksgiving');
INSERT INTO `cellar` (`bin`, `wine`, `producer`, `jahr`, `bottles`, `ready`)
        VALUES (11, 'Jo.Riesling', 'Jekel', 84, 10, 86);
INSERT INTO `cellar` (`bin`, `wine`, `producer`, `jahr`, `bottles`, `ready`,
                    `comments`)
        VALUES (12, 'Jo.Riesling', 'Buena Vista', 82, 1, 83, 'Late Harvest');
INSERT INTO `cellar` (`bin`, `wine`, `producer`, `jahr`, `bottles`, `ready`,
                    `comments`)
        VALUES (16, 'Jo.Riesling', 'Sattui', 82, 1, 83, 'very dry');
INSERT INTO `cellar` (`bin`, `wine`, `producer`, `jahr`, `bottles`, `ready`,
                    `comments`)
        VALUES (21, 'Fume Blanc', 'Ch.St.Jean', 79, 4, 83, 'Napa Valley');
INSERT INTO `cellar` (`bin`, `wine`, `producer`, `jahr`, `bottles`, `ready`)
        VALUES (22, 'Fume Blanc', 'Robt.Mondavi', 78, 2, 82);
INSERT INTO `cellar` (`bin`, `wine`, `producer`, `jahr`, `bottles`, `ready`)
        VALUES (25, 'Wh.Burgundy', 'Mirassou', 80, 6, 82);
INSERT INTO `cellar` (`bin`, `wine`, `producer`, `jahr`, `bottles`, `ready`)
        VALUES (30, 'Gewürztraminer', 'Buena Vista', 80, 3, 82);
INSERT INTO `cellar` (`bin`, `wine`, `producer`, `jahr`, `bottles`, `ready`)
        VALUES (43, 'Cab.Sauvignon', 'Robt.Mondavi', 77, 12, 87);
INSERT INTO `cellar` (`bin`, `wine`, `producer`, `jahr`, `bottles`, `ready`,
                    `comments`)
        VALUES (50, 'Pinot Noir', 'Mirassou', 77, 3, 85, 'Harvest');
INSERT INTO `cellar` (`bin`, `wine`, `producer`, `jahr`, `bottles`, `ready`)
        VALUES (51, 'Pinot Noir', 'Ch.St.Jean', 78, 2, 86);
INSERT INTO `cellar` (`bin`, `wine`, `producer`, `jahr`, `bottles`, `ready`,
                    `comments`)
        VALUES (64, 'Zinfandel', 'Mirassou', 77, 9, 86, 'Anniversary');
INSERT INTO `cellar` (`bin`, `wine`, `producer`, `jahr`, `bottles`, `ready`)
        VALUES (72, 'Gamay', 'Robt.Mondavi', 78, 2, 83);

