-- ###################################################
-- Stored Procedures 101; works for the CD_Database schema implemented
-- by cd_database.sql and connected data files.
-- by Matthias Obermaier, 2021
-- ###################################################

-- change into correct database
USE SQL_Info2;

-- First, minimal, Stored Procedure (Hello, World!)
DELIMITER |
CREATE PROCEDURE cd_stpr_01 ()
BEGIN
    SELECT 'Hello, World!';
END |
DELIMITER ;

-- With a Parameter
DELIMITER |
CREATE PROCEDURE cd_stpr_02 (Artist VARCHAR(50))
BEGIN
    -- CONCAT(): Connects one or more arguments, string-style.
    -- returns NULL if one (or more) arguments is NULL.
    SELECT CONCAT(Artist, 'wurde angegeben!');
END |
DELIMITER ;

-- IF/THEN/ELSE statement
DELIMITER |
CREATE PROCEDURE cd_stpr_03 (Artist VARCHAR(50))
BEGIN
    IF ((SELECT COUNT(Name) FROM CD_Artist WHERE Name = Artist) = 0) THEN
    -- BEGIN / END; not really necessary here, for clarity it can be used to
    -- mark nested code blocks.
    BEGIN
        SELECT 'Es ist noch kein Künstler dieses Namens eingetragen';
    END;
    ELSE
    -- same here for BEGIN / END;
    BEGIN
        SELECT 'Künstler/Band ist in den Tabellen schon vorhanden';
    END;
    END IF;
END |
DELIMITER ;

-- Superflous BEGIN/END;s removed; actual SELECT Query added
DELIMITER |
CREATE PROCEDURE cd_stpr_04 (Artist VARCHAR(50))
BEGIN
    IF ((SELECT COUNT(Name) FROM CD_Artist WHERE Name = Artist) = 0) THEN
        SELECT 'Es ist noch kein Künstler dieses Namens eingetragen';
    ELSE
        SELECT CD_Artist.Interpret_ID, CD_Artist.Name,
            CD_Artist.Year_Established, CD_Albums.CD_ID, CD_Albums.Title,
            CD_Albums.Release_Year FROM CD_Artist, CD_Albums
            WHERE CD_Artist.Name = Artist
            AND CD_Artist.Interpret_ID = CD_Albums.Interpret_ID;
    END IF;
END |
DELIMITER ;

-- Procedure in order to automatically insert new Artist
DELIMITER |
-- second IN(put) parameter here, IN is default for values that can't be changed
-- there's also OUT for parameters that can be overwritten but not referenced
-- and IN OUT for params that can both be overwritten and referenced
CREATE PROCEDURE cd_stpr_05 (artist VARCHAR(50), founding_year INT)
BEGIN
    -- Declaring an internal variable; scope between resp. BEGIN/END
    DECLARE mx_art_id INT;
    -- not really necessary here, just for demonstration of SET usage
    SET mx_art_id = 0;

    IF ((SELECT COUNT(Name) FROM CD_Artist WHERE Name = artist) = 0) THEN
    BEGIN
        -- find out max interpret ID, add one write INTO the declared variable
        SELECT MAX(Interpret_ID) + 1 INTO mx_art_id FROM CD_Artist;
        -- insert data into table
        INSERT INTO CD_Artist (Interpret_ID, Name, Year_Established)
        VALUES (mx_art_id, artist, founding_year);
    END;
    ELSE
        SELECT 'Künstler/Interpret ist schon in CD_Artist vorhanden!';
    END IF;
END |
DELIMITER ;

-- Proc. for entering new Albums AFTER artist has been added
DELIMITER |
CREATE PROCEDURE cd_stpr_06 (album_title VARCHAR(50), release_year INT,
    artist_name VARCHAR(50))
-- this codeblock is now labeled in order to make the LEAVE command work
-- properly.
main:BEGIN
    DECLARE next_album_id INT;
    DECLARE artist_id INT;
    IF ((SELECT COUNT(Name) FROM CD_Artist WHERE Name = artist_name) = 0) THEN
        SELECT 'Kein Künstler/Interpret gefunden! Trage zunächst den Künstler
            in \'CD_Artist\' ein!';
        -- At this point, there is nothing more to do. Jump over the rest of the
        -- code via the LEAVE command. This leaves the labeled code block.
        LEAVE main;
    -- Else-Output removed
    END IF;
    -- get artist ID from its Table
    SELECT Interpret_ID INTO artist_id FROM CD_Artist
        WHERE Name = artist_name;
    -- same as for inserting data into CD_Artists: If Album title already there,
    -- jump to ELSE with its message; otherwise get next CD_ID and insert
    -- everything into CD_Albums.
    IF ((SELECT COUNT(Title) FROM CD_Albums WHERE Title = album_title) = 0) THEN
        SELECT MAX(CD_ID) + 1 INTO next_album_id FROM CD_Albums;
        INSERT INTO CD_Albums (CD_ID, Title, Interpret_ID, Release_Year)
            VALUES (next_album_id, album_title, artist_id, release_year);
    ELSE
        -- Failure message in case CD is already there
        SELECT 'Album ist schon in \'CD_Albums\' vorhanden!';
    END IF;
END |
DELIMITER ;

-- Proc. for putting out No. of albums from an artist
-- OUTPUT-Variable must be called with prefix "@"!
-- e.g. SET @nummer = 0; CALL cd_stpr_07 ('Anastacia', @nummer);
DELIMITER |
CREATE PROCEDURE cd_stpr_07 (artist_name VARCHAR(50), OUT num_albums SMALLINT)
BEGIN
    DECLARE artist_id INT;
    -- num_albums doesn't have to be declared here again!
    IF ((SELECT COUNT(Name) FROM CD_Artist WHERE Name = artist_name) = 0) THEN
        -- If there is no artist,  there are exactly 0 albums of that artist
        SET num_albums = 0;
    ELSE
        -- get Interpret_ID
        SELECT Interpret_ID INTO artist_id FROM CD_Artist
            WHERE Name = artist_name;
        -- and get a count of albums with it
        SELECT COUNT(Interpret_ID) INTO num_albums FROM CD_Albums
            WHERE Interpret_ID = artist_id;
    END IF;
END |
DELIMITER ;

-- Procedure for finding Number of Songs of a certain Track_ID
-- testing CASE statement
DELIMITER |
CREATE PROCEDURE cd_stpr_08 (artist_name VARCHAR(50), song_number SMALLINT)
main:BEGIN
    DECLARE artist_id INT;
    -- Default values are given like so:
    DECLARE track_count SMALLINT DEFAULT 0;
    IF ((SELECT COUNT(Name) FROM CD_Artist WHERE Name = artist_name) = 0) THEN
        SELECT 'Kein Künstler/Interpret gefunden! Trage zunächst den Künstler
            in \'CD_Artist\' ein!';
        -- LEAVE if no artist there
        LEAVE main;
    END IF;
    -- get artist ID from its Table
    SELECT Interpret_ID INTO artist_id FROM CD_Artist
        WHERE Name = artist_name;
    -- CASE 1, 2 or 3 in song_number
    CASE song_number
        WHEN 1 THEN
            -- use track_count for holding the respective COUNT and output
            SELECT COUNT(*) INTO track_count FROM CD_Songs WHERE Track_ID = 1;
            SELECT CONCAT('Für ', artist_name, ' gibt es ', track_count,
                ' Titel mit Track Nummer 1!');
        WHEN 2 THEN
            SELECT COUNT(*) INTO track_count FROM CD_Songs WHERE Track_ID = 2;
            SELECT CONCAT('Für ', artist_name, ' gibt es ', track_count,
                ' Titel mit Track Nummer 2!');
        WHEN 3 THEN
            SELECT COUNT(*) INTO track_count FROM CD_Songs WHERE Track_ID = 3;
            SELECT CONCAT('Für ', artist_name, ' gibt es ', track_count,
                ' Titel mit Track Nummer 3!');
        ELSE
            -- ELSE statement for everything else!
            SELECT 'Keine gültige Tracknummer angegeben!';
    END CASE;
END |
DELIMITER ;

-- Proc. for demonstrating LOOP
-- Yields even numbers as output
DELIMITER |
CREATE PROCEDURE cd_stpr_09 ()
BEGIN
    -- Declare int variable plus (potentially loong) Varchar
    DECLARE x INT;
    DECLARE str VARCHAR(255);
    -- Set starting values
    SET x = 1;
    SET str = '';
    -- Start the loop, with label
    loop_label:LOOP
        -- Stop at 100: if x gets to 101, this condition gets TRUE and the body
        -- will be executed. Here, it is the LEAVE command for terminating
        -- the loop.
        IF x > 100 THEN
            LEAVE loop_label;
        END IF;
        -- Count x up by 1
        SET x = x + 1;
        -- Modulo - Function gives the "leftover" of an integer division (here:
        -- x/2, take the leftover). Can obviously be 0 or 1 (for mod2 only!),
        -- which is interpreted by SQL as FALSE or TRUE (hence, we can save us
        -- the ("=0 / =1") at the end of the IF-Condition).  IF TRUE (1, x is
        -- NOT evenly divisible by 2), ITERATE will be executed.  This
        -- meansjumping back to the start of the LOOP (label!) and continuing
        -- from there for the next iteration
        IF (x mod 2) THEN
            ITERATE loop_label;
        -- if x is divisible by 2, construct the next step of the result string
        -- via CONCAT
        ELSE
            SET str = CONCAT(str,x,',');
        END IF;
    -- end the loop...
    END LOOP;
-- show final str with the even numbers
SELECT str;
END |
DELIMITER ;

-- Proc. for adding Dummy Tracks in CD_Songs
-- Do a "DELETE FROM CD_Songs WHERE Track_ID > 3;" afterwards to re-set
-- CD_Songs!
DELIMITER |
CREATE PROCEDURE cd_stpr_10 (cd_id INT)
BEGIN
    -- counter with Default value for demonstration purposes, not really
    -- necessary here because it will get a value right below.
    DECLARE counter INT DEFAULT 0;
    DECLARE max_songs INT;
    DECLARE title VARCHAR(50);
    -- initializing local variables
    SET counter = 4;
    SET max_songs = 25;
    SET title = 'Track ';
    -- WHILE loop: As long as counter < max_songs is TRUE, run the loop again.
    -- Stop the loop when condition gets FALSE.
    WHILE (counter < max_songs) DO
        -- Add the Track number to title text
        SET title = CONCAT(title, counter);
        -- ...and insert everything.
        INSERT INTO CD_Songs (CD_ID, Track_ID, Title)
            VALUES (cd_id, counter, title);
        -- increment counter by one. Note: "+= 1" doesn't work here!
        SET counter = counter + 1;
        -- re-set title string so the numbers added each time do not accumulate
        SET title = 'Track ';
    -- End of the WHILE loop
    END WHILE;
END |
DELIMITER ;

-- Another Proc. for adding Dummy Tracks in CD_Songs, now with a
-- REPEAT loop!
-- Do a "DELETE FROM CD_Songs WHERE Track_ID > 3;" afterwards to re-set
-- CD_Songs!
DELIMITER |
CREATE PROCEDURE cd_stpr_11 (cd_id INT)
BEGIN
    DECLARE counter INT DEFAULT 0;
    DECLARE max_songs INT;
    DECLARE title VARCHAR(50);

    SET counter = 4;
    SET max_songs = 25;
    SET title = 'Track ';
    -- REPEAT loop, main difference to WHILE: Runs through the body at least
    -- once (Then, the condition is checked for the first time!)
    REPEAT
        SET title = CONCAT(title, counter);
        INSERT INTO CD_Songs (CD_ID, Track_ID, Title)
            VALUES (cd_id, counter, title);
        SET counter = counter + 1;
         -- re-set title string
        SET title = 'Track ';
    -- >= (greater than or equal) necessary in order to get the same result
    -- as before!
    UNTIL (counter >= max_songs)
    END REPEAT;
END |
DELIMITER ;

-- Proc. for converting Song titles from a table to our CD_Songs
-- and to demonstrate cursors
DELIMITER |
-- Parameters: Name of the temporary table (for now: "sp_temp_songs",
-- Number of album (1 or 2 for now), actual cd_id from CD_Albums,
-- INOUT songlist to be declared with e.g. SET @listofsongs = '';.
CREATE PROCEDURE cd_stpr_12 (table_name VARCHAR(50), album_nr SMALLINT,
        cd_id INT, INOUT songlist VARCHAR(4000))
        -- above: Use an INOUT parameter (make it big for all song titles)
BEGIN
    -- Declaring and initializing variables; "finished" is for breaking a loop
    -- when cursor has read everything.
    DECLARE finished INT DEFAULT 0;
    DECLARE song_number SMALLINT DEFAULT 0;
    DECLARE song_title VARCHAR(50) DEFAULT '';
    -- Cursors have to be defined after all other declarations
    DECLARE cur_songs CURSOR FOR
        -- command to be iterated upon (run through, one by one)
        SELECT Track, Song FROM sp_temp_songs
            WHERE AlbumID = album_nr;
    -- declare NOT FOUND handler: What happens if nothing more is found?
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET finished = 1;

    -- open cursor
    OPEN cur_songs;
    -- LOOP for as long as finished isn't 1 - then LEAVE
    getSong: LOOP
        -- FETCH next dataset from cursor; each call gets the following one
        -- (as "pointed" to by the cursor)
        FETCH cur_songs INTO song_number, song_title;
        IF (finished = 1) THEN
            LEAVE getSong;
        END IF;
        -- Make a big string with all the found song titles
        SET songlist = CONCAT(song_title, ';', songlist);
        -- Insert each song into CD_Songs
        INSERT INTO CD_Songs (CD_ID, Track_ID, Title)
            VALUES (cd_id, song_number, song_title);
    END LOOP;
    -- closing the cursor should be good practice; should be closed after
    -- loss of connection anyways, however.
    CLOSE cur_songs;
END |
DELIMITER ;

-- Proc. with an exception handler (EXIT or CONTINUE)
-- Run:
-- CALL ('artist', @exit_stat);
-- SELECT @exit_stat;
DELIMITER |
-- this time with output variable to check if exception was caught
CREATE PROCEDURE cd_stpr_13 (artist_name VARCHAR(50), OUT exit_status INT)
BEGIN
    -- declare some dummy variable
    DECLARE test_no INT;
    -- declare the handler. Instead of EXIT, there could be
    -- a CONTINUE also, in order to handle non-critical
    -- exceptions gracefully
    -- Here: NOT FOUND catches various conditions: cursor row not found,
    -- SELECT..INTO..not found (which we will use below)
    -- For the various and numerous possible error conditions,
    -- see MariaDB/MySQL Documentation
    DECLARE EXIT HANDLER FOR NOT FOUND
    BEGIN
        -- Create a short message
        SELECT 'EXCEPTION!' AS Message;
        -- and set OUT variable
        SET exit_status = 1;
    END;
    -- a non-existent artist triggers the exception here
    SELECT Interpret_ID INTO test_no FROM CD_Artist WHERE Name = artist_name;
    -- if all good, set status to 0; otherwise, the EXIT handler
    -- has already terminated the procedure on the line above
    SET exit_status = 0;
END |
DELIMITER ;

-- Proc. which raises a user-defined exception (SIGNAL)
-- (which could be caught with an exception handler like the one
-- in the procedure before)
DELIMITER |
CREATE PROCEDURE cd_stpr_14 (artist_name VARCHAR(50))
BEGIN
    -- LEFT takes the leftmost characters of a string
    -- (here, only the 1st)
    IF (LEFT(artist_name, 1) = 'V') THEN
        -- SQLSTATE '45000' is a generic, user-defined exception
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Kein gültiger Band/Interpretenname!';
    END IF;
    -- should only be executed if argument DOESN'T start with a 'V'
    SELECT 'Ende der Prozedur. Mal schaun, ob wir hier her kommen...';
END |
DELIMITER ;

-- Proc. with a RESIGNAL plus handler for customized errors/warnings
-- Run by e.g.:
-- CALL cd_stpr_15(2,0,@ergebnis); <--- will raise an error
-- CALL cd_stpr_15(2,3,@ergebnis);
-- SELECT @ergebnis;
DELIMITER |
CREATE PROCEDURE cd_stpr_15 (IN numerator INT, IN denominator INT,
    OUT division double)
BEGIN
    -- declare a custom error condition
    DECLARE division_by_zero CONDITION FOR SQLSTATE '22012';
    -- declare handler for above condition
    DECLARE CONTINUE HANDLER FOR division_by_zero 
        -- RESIGNAL HAS to be used together with an error/warning handler
        -- contrary to SIGNAL which can be used anywhere
        -- (which we have done in the preceding procedure)
        -- RESIGNAL doesn't need an SQLSTATE per se and can be used for a
        -- further customized error/warning
        -- (with e.g. custom MESSAGE_TEXT here)
        RESIGNAL SET MESSAGE_TEXT =
                'Division by zero / Denominator cannot be zero';
    -- div by zero not allowed
    IF denominator = 0 THEN
        -- therefore, raise error, to be caught by above handler/RESIGNAL
        SIGNAL division_by_zero;
    ELSE
        -- just normal division
        SET division = numerator / denominator;
    END IF;
END | 
DELIMITER ;

