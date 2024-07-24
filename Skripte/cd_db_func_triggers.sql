-- ###################################################
-- Functions and Triggers 101; works for the CD_Database schema implemented
-- by cd_database.sql and connected data files.
-- by Matthias Obermaier, 2021
-- ###################################################

-- change into correct database
USE sqlinfo;

-- ############ (Stored) Functions ###################

-- Hello, World example function, useable with e.g. SELECT cd_db_func01();
-- as for Stored procedures, delimiter change is necessary in order to
-- make the function run through instead of stopping at the first ";"
DELIMITER |
CREATE FUNCTION cd_db_func01 ()
-- VARCHAR(13) is just enough to return the "Hello, World!" string
RETURNS VARCHAR(13)
-- [NOT] DETERMINISTIC for return values which stay the same for the same input
-- NOT DETERMINISTIC is applicable e.g. for using the RAND() (random value)
-- or the NOW() (current date and time) function where you get a new
-- return value for each function call
DETERMINISTIC
-- BEGIN/END to enclose code blocks as in Stored Procedures
BEGIN
    -- Just return the string
    RETURN ('Hello, World!');
END |
DELIMITER ;

-- Function for determining if a song is a Title song (i.e. has Track No. 1)
-- mostly for demonstration purposes in order to get a few statements into
-- the function; would be solved more elegantly in practice by just returning
-- e.g. "Title Yes/No" and fetching the other data by conventional means
-- Best called via user variable, e.g.:
-- SET @song = 'Cherub Rock';
-- SELECT cd_db_func02(@song), Release_year FROM CD_Albums INNER JOIN CD_Songs
-- ON CD_Albums.CD_ID = CD_Songs.CD_ID AND CD_Songs.Title = @song;
DELIMITER |
-- now with argument (Song Title)
CREATE FUNCTION cd_db_func02 (song_title VARCHAR(50))
-- Bigger VARCHAR necessary in order to return the long CONCAT string below
RETURNS VARCHAR(100)
-- same input yields same output
DETERMINISTIC
BEGIN
    -- declare the variables needed
    DECLARE album_id INT;
    DECLARE artist_id INT;
    DECLARE alb_title VARCHAR(50);
    DECLARE artist VARCHAR(50);
    -- ask if song has Track No. 1
    IF((SELECT Track_ID FROM CD_Songs WHERE song_title = Title) = 1) THEN
        -- successively fetch the various data chunks into the variables
        SELECT CD_ID INTO album_id FROM CD_Songs WHERE song_title = Title;
        -- one can also assign values to 2 or more variables in one statement
        -- by separating them with "," (in that order!)
        SELECT Title, Interpret_ID INTO alb_title, artist_id FROM CD_Albums
            WHERE CD_ID = album_id;
        SELECT Name INTO artist FROM CD_Artist
            WHERE artist_id = Interpret_ID;
        -- return a string with artist and album info
        RETURN (CONCAT('Dies ist der Titelsong von ', artist, ' - ',
        alb_title));
    ELSE
        -- this is not a track with ID no. 1!
        RETURN ('Dies ist kein Titelsong!');
    END IF;
END |
DELIMITER ;

-- Function for getting Album count by a certain Artist
DELIMITER |
CREATE FUNCTION cd_db_func03 (artist_name VARCHAR(50))
-- TINYINT just for fun (-128 - 127)...
RETURNS TINYINT
DETERMINISTIC
BEGIN
    DECLARE artist_id INT;
    -- RETURNed Variable of the same type as RETURN declaration
    DECLARE album_count TINYINT;
    -- get artist ID
    SELECT Interpret_ID INTO artist_id FROM CD_Artist WHERE Name = artist_name;
    -- if Artist ID is anything other than NULL - i.e. Artist exists
    -- not quite sure is NULL is really FALSE or somehow undefined
    -- but it seems to work for now. Could be remedied by giving artist_id
    -- a DEFAULT value of 0.
    IF (artist_id) THEN
        -- get count of albums into return variable
        SELECT COUNT(CD_ID) INTO album_count FROM CD_Albums
            WHERE Interpret_ID = artist_id;
    ELSE
        -- if Artist ID is NULL then just set return variable to 0
        SET album_count = 0;
    END IF;
    -- hand out the result
    RETURN album_count;
END |
DELIMITER ;



-- ############### Triggers ##########################



-- Trigger for logging changes in CD_Albums; changes to Album titles
-- will be logged in CD_Changelog
-- Delimiters, like in Stored Procedures
-- BE AWARE: Trigger will fire on any update on CD_Albums, not just for
-- changing the title column. For more, other triggers need to be written
-- and/or the CD_Changelog table needs to be expanded (e.g. for logging
-- changes to Release_Year in CD_Albums - etc.)
DELIMITER |
-- Log entry should happen AFTER actual update
-- irrelevant for many uses except query goes wrong
-- (Note: BEFORE could be useful for validating entries before
-- they'll actually be written into the table!)
CREATE TRIGGER cd_trg_01 AFTER UPDATE ON CD_Albums
-- Trigger will fire for each row that's been/being worked on
-- UPDATE in this case! FOR EACH ROW is mandantory (in MariaDB/MySQL).
FOR EACH ROW
-- BEGIN/END not really necessary for a single statement - but it's nice
-- to keep things tidy.
BEGIN
    -- CD_Changelog has an AUTO_INCREMENT Primary Key (CH_ID); we'll
    -- rely on that here, so we insert only the last 4 columns.
    -- OLD./NEW. statements (the ones in Caps) access the values of the
    -- base table (CD_Albums here) before/after the update.
    -- old_albumtitle and new_albumtitle are just the column names.
    -- CURRENT_TIMESTAMP yields the current time (DATETIME-Type) 
    INSERT INTO CD_Changelog (CD_ID, old_albumtitle, new_albumtitle,
        change_time)
        VALUES (OLD.CD_ID, OLD.Title, NEW.Title, CURRENT_TIMESTAMP);
END |
DELIMITER ;

-- Triggers for changing new and updated name column
-- entries to UPPER case
DELIMITER |
-- An INSERT trigger; BEFORE is of importance here as only in
-- BEFORE INSERT trigger, the NEW value is accessible and changeable!
-- This trigger would not work as an AFTER INSERT version (NEW is still
-- accessible there, but not changeable!)
-- again: The trigger will fire on any INSERT/UPDATE!
CREATE TRIGGER cd_trg_02 BEFORE INSERT ON CD_Artist
FOR EACH ROW
BEGIN
    -- using the UPPER function to convert the name column to upper case
    SET NEW.Name = UPPER(NEW.Name);
END |
DELIMITER ;

-- same stuff for UPDATEs to CD_Artist
DELIMITER |
CREATE TRIGGER cd_trg_03 BEFORE UPDATE ON CD_Artist
FOR EACH ROW 
BEGIN 
    SET NEW.Name = UPPER(NEW.Name);
END |
DELIMITER ;

-- Trigger for verifying Values befor INSERT
DELIMITER |
-- We want a verification BEFORE anything is written to the DB
CREATE TRIGGER cd_trg_04 BEFORE INSERT ON CD_Artist
FOR EACH ROW 
BEGIN
    -- set up error message; note that Interpret_ID is accessible
    -- even when it is auto-incremented on insert
    DECLARE error_message VARCHAR(255);
    SET error_message = CONCAT('Die Interpreten-ID liegt bei ',
        NEW.Interpret_ID, ', nicht zwischen 9001 und 9999!');
    -- NOT BETWEEN 9001 and 9002 equivalent to:
    -- WHERE Interpret_ID < 9001 AND Interpret_ID > 9999
    -- Note also that SELECT.. FROM not necessary here if the
    -- value for verification is already given (via the NEW/OLD variables)
    IF (NEW.Interpret_ID NOT BETWEEN 9001 AND 9999) THEN
        -- if not between..., error out, with message
        -- (again: SQLSTATE '45000' is a generic, user-defined error)
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = error_message;
    END IF;
END |
DELIMITER ;

-- Trigger to demonstrate additional triggers for the same
-- Event, where the the FOLLOWS/PRECEDES establish order.
DELIMITER |
-- another INSERT trigger; has to be BEFORE because we change
-- NEW values again (not possible in AFTER INSERT)
CREATE TRIGGER cd_trg_05 BEFORE INSERT ON CD_Artist
FOR EACH ROW
-- Keyword FOLLOWS to fire the new trigger after the other one;
-- PRECEDING to do this before the other one
-- in order to establish precedence between different triggers
FOLLOWS cd_trg_02
BEGIN
    -- up founding year by 1, just for testing purposes
    SET NEW.Year_Established = NEW.Year_Established + 1;
END |
DELIMITER ;

-- Addendum: Calling Stored Procedures is possible in Triggers, via
-- the normal CALL() routine. Note, however, that triggers can't
-- return any SELECT result or similar, so those SPs can't be
-- called from inside a trigger.

