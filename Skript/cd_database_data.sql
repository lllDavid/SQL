-- ###################################################
-- CD database schema data
-- to be used AFTER running cd_database.sql which establishes DB schema
-- by Matthias Obermaier, 2021, after Normalising scheme and Data
-- found on Wikipedia
-- ###################################################

-- Change to correct database
USE `sqlinfo`;

-- Due to Foreign Key Constraints (CD_Albums.Interpret_ID --FK-->
-- CD_Artist.Interpret_ID), CD_Artist has to have an Interpret_ID registered
-- before it can be used in CD_Albums

-- ATTENTION: For the PRIMARY KEY in CD_Albums, which is Auto_Incremented,
-- failed INSERT Queries still increment the column (CD_ID!). Therefore, the
-- next successful INSERT might not have the next, consecutive, CD_ID Number!
-- This can cause Problems with the Foreign Key in CD_Songs: If you just rely on
-- CD_ID being the next number, you will get into trouble sooner or later.  To
-- remedy this, either query CD_Albums first for the correct CD_ID when entering
-- songs into CD_Songs - OR: use LAST_INSERT_ID() for CD_Songs.CD_ID - but this
-- works only within the same MariaDB connection (i.e. The SQL Script Window
-- where you INSERTed the Album into CD_Albums must be the same where you INSERT
-- the respective songs)!
INSERT INTO `CD_Artist` (`Interpret_ID`, `Name`, `Year_Established`)
	VALUES (9001, 'Anastacia', 1999),
	(9002, 'Pink Floyd', 1965),
	(9003, 'AC/DC', 1973),
	(9004, 'Badfinger', 1961),
	(9005, 'Slayer', 1981),
	(9006, 'Smashing Pumpkins', 1988);

INSERT INTO `CD_Albums` (`Title`, `Interpret_ID`, `Release_Year`)
	VALUES ('Not That Kind', 9001, 2000),
	('Freak Of Nature', 9001, 2001),
	('The Dark Side Of The Moon', 9002, 1973),
	('Wish You Were Here', 9002, 1975),
	('The Razors Edge', 9003, 1990),
	('Ballbreaker', 9003, 1995),
	('Badfinger', 9004, 1974),
	('Airwaves', 9004, 1979),
	('Reign In Blood', 9005, 1986),
	('South Of Heaven', 9005, 1988),
    ('Siamese Dream', 9006, 1993),
    ('Mellon Collie And The Infinite Sadness', 9006, 1995);

INSERT INTO `CD_Songs` (`CD_ID`, `Track_ID`, `Title`)
    VALUES (1001, 1, 'Not That Kind'),
    (1001, 2, 'I\'m Outta Love'),
    (1001, 3, 'Cowboys & Kisses'),
    (1002, 1, 'Freak Of Nature'),
    (1002, 2, 'Paid My Dues'),
    (1002, 3, 'Overdue Goodbye'),
    (1003, 1, 'Speak To Me'),
    (1003, 2, 'Breathe'),
    (1003, 3, 'On The Run'),
    (1004, 1, 'Shine On You Crazy Diamond'),
    (1004, 2, 'Welcome To The Machine'),
    (1004, 3, 'Have A Cigar'),
    (1005, 1, 'Thunderstruck'),
    (1005, 2, 'Fire Your Guns'),
    (1005, 3, 'Moneytalks'),
    (1006, 1, 'Hard As A Rock'),
    (1006, 2, 'Cover You In Oil'),
    (1006, 3, 'The Furor'),
    (1007, 1, 'I Miss You'),
    (1007, 2, 'Shine On'),
    (1007, 3, 'Love Is Easy'),
    (1008, 1, 'Airwaves'),
    (1008, 2, 'Look Out'),
    (1008, 3, 'Lost Inside Your Love'),
    (1009, 1, 'Angel Of Death'),
    (1009, 2, 'Piece By Piece'),
    (1009, 3, 'Necrophobic'),
    (1010, 1, 'South Of Heaven'),
    (1010, 2, 'Silent Scream'),
    (1010, 3, 'Live Undead'),
    (1011, 1, 'Cherub Rock'),
    (1011, 2, 'Quiet'),
    (1011, 3, 'Today'),
    (1012, 1, 'Mellon Collie And The Infinite Sadness'),
    (1012, 2, 'Tonight Tonight'),
    (1012, 3, 'Jellybelly');

