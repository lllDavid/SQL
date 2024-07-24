-- Übungsblatt 12 Lösungen

-- Aufgabe 1)
DELIMITER |
CREATE PROCEDURE uebung_12_1 (prod VARCHAR(50))
BEGIN
    -- Variable für Flaschenanzahl
    DECLARE bottlecount SMALLINT DEFAULT 0;
    -- Nehme die Summe über die gefragten Producer, schreibe in die Variable
    SELECT SUM(bottles) INTO bottlecount FROM cellar
    WHERE producer = prod;
    -- Formatierter SELECT-Befehl
    SELECT CONCAT('Die Anzahl der vorrätigen Flaschen für ', prod,
        ' beträgt ', bottlecount);
END |
DELIMITER ;

-- Aufgabe 2)
DELIMITER |
CREATE PROCEDURE uebung_12_2 (prod VARCHAR(50), OUT bottlecount INT)
BEGIN
    -- Nehme die Summe über die gefragten Producer, schreibe in die Variable
    SELECT SUM(bottles) INTO bottlecount FROM cellar
    WHERE producer = prod;
    -- Formatierter SELECT-Befehl
    SELECT CONCAT('Die Anzahl der vorrätigen Flaschen für ', prod,
        ' beträgt ', bottlecount);
END |
DELIMITER ;

-- Aufgabe 3)
DELIMITER |
-- 'bin'-Spalte in "cellar" ist der Primärschlüssel; deshalb Angabe dieser IDs!
CREATE PROCEDURE uebung_12_3 (bin1 SMALLINT, bin2 SMALLINT)
BEGIN
    -- Variablen für Reifezeit und Weinnamen
    DECLARE ripe1 SMALLINT;
    DECLARE ripe2 SMALLINT;
    DECLARE wine1, wine2 VARCHAR(50);
    -- selbige bestimmen
    SELECT (ready - jahr) INTO ripe1 FROM cellar WHERE bin = bin1;
    SELECT (ready - jahr) INTO ripe2 FROM cellar WHERE bin = bin2;
    SELECT wine INTO wine1 FROM cellar WHERE bin = bin1;
    SELECT wine INTO wine2 FROM cellar where bin = bin2;
    -- Formatierte Ausgabe
    SELECT CONCAT(wine1, ' ist in ', ripe1, ' Jahren gereift; ', wine2,
        ' brauchte ', ripe2, ' Jahre.') AS Ergebnis;
END |
DELIMITER ;

-- Aufgabe 4)
DELIMITER |
CREATE PROCEDURE uebung_12_4 ()
BEGIN
    -- Variablen: End-Variable (Default 0 hier wichtig!),
    -- Einzel- und Summenvariable für die Buchstaben (0 als DEFAULT/Startwert
    -- bei letter_total wieder wichtig!)
    DECLARE finished INT DEFAULT 0;
    DECLARE letter_count SMALLINT;
    DECLARE letter_total INT DEFAULT 0;
    -- Cursor und continue-handler deklarieren; immer unter den "normalen"
    -- Variablen
    DECLARE cur_letters CURSOR FOR
        -- CHAR_LENGTH als Funktion für die Buchstabenanzahl
        SELECT CHAR_LENGTH(wine) FROM cellar;
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        -- Abbruchbedingung
        SET finished = 1;
    -- Cursor öffnen, Loop starten. Bei jedem Durchlauf wird obige char_length -
    -- Funktion auf die aktuelle Zeile angewandt und in letter_count geschrieben.
    OPEN cur_letters;
    getLetters: LOOP
        FETCH cur_letters INTO letter_count;
    -- Abbruchbedingung
    IF (finished = 1) THEN
        LEAVE getLetters;
    END IF;
    -- Aufsummieren der Gesamt-Buchstabenanzahl
    SET letter_total = letter_total + letter_count;
    END LOOP;
    -- Cursor schließen
    CLOSE cur_letters;
    -- Formatierte Ausgabe
    SELECT CONCAT('Die Gesamtanzahl der Buchstaben in der Spalte "wine" ',
        'beträgt ', letter_total, '.') AS Ergebnis;
END |
DELIMITER ;

-- Alternativ für Aufgabe 4):
DELIMITER |
CREATE PROCEDURE uebung_12_4 ()
BEGIN
    DECLARE letter_total;
    -- viel kürzer! Allerdings nicht anwendbar, falls Parameter übergeben
    -- werden müssten.
    SELECT SUM(LENGTH(wine)) INTO letter_total FROM cellar;
    SELECT CONCAT('Die Gesamtanzahl der Buchstaben in der Spalte "wine" ',
        'beträgt ', letter_total, '.') AS Ergebnis;   
END |
DELIMITER ;
END