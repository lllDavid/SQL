-- Lösungen zum SQL Übungsblatt 15

-- Aufgabe 1)
DELIMITER |
CREATE PROCEDURE blatt15_1 (IN startyear INT, IN endyear INT)
BEGIN

    SELECT CD_ID, Title, Name, Release_Year FROM CD_Albums INNER JOIN CD_Artist
        ON CD_Albums.Interpret_ID = CD_Artist.Interpret_ID AND (Release_Year
        BETWEEN startyear AND endyear);
    
END |
DELIMITER ;

-- Aufgabe 2)
DELIMITER |
CREATE PROCEDURE blatt15_2 ()
BEGIN
    DECLARE num_songs INT;
    DECLARE num_albums INT;
    DECLARE durchschnitt FLOAT;

    SELECT COUNT(CD_Songs.Title) INTO num_songs FROM CD_Songs;
    SELECT COUNT(CD_Albums.Title) INTO num_albums FROM CD_Albums;

    SET durchschnitt = CAST(num_songs AS FLOAT)
                    / CAST(num_albums AS FLOAT);
    SET durchschnitt = ROUND(durchschnitt, 2);
    -- zwei INT werden auch nur ganzzahlig geteilt; Abhilfe: CASTing als
    -- Fließkommazahl von Dividend und/oder Divisor mittels CAST-Funktion
    -- (Veränderung des Datentyps, falls möglich)
    -- Dann noch nach Bedarf ROUNDen
                
    SELECT CONCAT('Die ', num_songs, ' Tracks sind auf ', num_albums,
        ' Alben verteilt. Dies ergibt einen Schnitt von ', durchschnitt,
        ' Songs pro Album!');
    
END |
DELIMITER ;

-- Aufgabe 3)
DELIMITER |
CREATE PROCEDURE blatt15_3 ()
BEGIN
    DECLARE artist_id INT;
    DECLARE artist_name VARCHAR(50);
    DECLARE albcount INT;
    DECLARE finished INT DEFAULT 0;

    -- Cursor notwendig zum Durchlauf der einzelnen Künstler; muss immer als
    -- letztes deklariert werden!
    DECLARE cur_artists CURSOR FOR
        -- sucht diese beiden Spalten pro Zeile
        SELECT Interpret_ID, Name FROM CD_Artist;
    -- CONTINUE Handler für das Ende der Suchergebnisse: Stelle finished-Var. um
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET finished = 1;
    
    -- Cursor öffnen
    OPEN cur_artists;
    -- Loop, mit Namen (damit wir später heraus springen können)
    getArtist: LOOP
        -- FETCH Zeile (nach obigem SELECT-Befehl); fülle Variablen
        FETCH cur_artists INTO artist_id, artist_name;
        
        -- Zähle Alben pro Künstler und schreibe in albcount
        SELECT COUNT(CD_ID) INTO albcount FROM CD_Albums
                WHERE Interpret_ID = artist_id;
    
        -- Falls wir am Ende der Tabelle sind, verlasse den Loop
        IF (finished = 1) THEN
            LEAVE getArtist;
        END IF;
        
        -- Nur Interpreten mit 2 oder mehr Alben sollen angezeigt werden
        IF (albcount >= 2) THEN
        
        -- Haupt-Ausgabe: Alle Interpreten mit albcount >=2; hier noch jeweils
        -- einzelne Select-Abfrage! Besser ginge es mit Anlage und INSERT von
        -- einer neuen Tabelle!
        SELECT artist_id, artist_name, albcount;
        
        END IF;
    
        
    END LOOP;
    
    -- Cursor schließen
    CLOSE cur_artists;
    
END |
DELIMITER ;

-- Aufgabe 4)

-- Tabelle erstellen - z.B.:
CREATE TABLE CD_Del_Backup (DelID INT NOT NULL AUTO_INCREMENT,
    DelTime DATETIME DEFAULT CURRENT_TIMESTAMP, B_CD_ID INT,
    B_Title VARCHAR(50), B_Interpret_ID INT, B_Release_Year INT,
    PRIMARY KEY (DelID))AUTO_INCREMENT = 1001;

-- dann Trigger:
DELIMITER |
CREATE TRIGGER blatt15_4 BEFORE DELETE ON CD_Albums
FOR EACH ROW 
BEGIN
    -- OLD: Hier der Key für die zu löschenden Daten (bei DELETE-Triggern gibt
    -- es kein NEW
    INSERT INTO CD_Del_Backup (B_CD_ID, B_Title, B_Interpret_ID, B_Release_Year)
        VALUES (OLD.CD_ID, OLD.Title, OLD.Interpret_ID, OLD.Release_Year); 
END |
DELIMITER ;

-- Dann können bei einer DELETE-Operation auf CD_Albums die automatischen
-- Einträge in CD_Del_Backup angesehen werden!
