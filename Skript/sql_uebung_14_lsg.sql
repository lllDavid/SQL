-- Übungsblatt 14 Lösungen

-- Aufgabe 1
DELIMITER |
-- cCode: Strikt nur 3 Buchstaben
CREATE FUNCTION blatt14_1_func(cCode VARCHAR(3))
RETURNS DECIMAL(4,2)  -- DECIMAL wie in der Tabelle
DETERMINISTIC
BEGIN
    DECLARE perc DECIMAL(4,2); -- zurückzugebende Variable

    -- Durchschnitt herausfinden mittels AVG, in perc schreiben
    SELECT ROUND(AVG(Percentage), 2) INTO perc FROM countrylanguage
        WHERE CountryCode = cCode;
    -- Rückgabe
    RETURN perc;
END |
DELIMITER ;

-- Anwendung z.B. mit:
SELECT Language, IsOfficial FROM countrylanguage WHERE CountryCode = 'ABW' AND 
    Percentage < blatt14_1_func('ABW');
    
-- Aufgabe 2
DELIMITER |
CREATE FUNCTION blatt14_2_func(cCode VARCHAR(3))
RETURNS VARCHAR(8)
DETERMINISTIC
BEGIN
    DECLARE surArea INT DEFAULT 0;
    DECLARE ausgabe VARCHAR(8);
    SELECT SurfaceArea INTO surArea FROM country WHERE Code = cCode;

    IF (surArea < 1000) THEN
        SET ausgabe = 'WINZIG';
    ELSEIF (surArea BETWEEN 1000 AND 249000) THEN
        SET ausgabe = 'KLEIN';
    ELSEIF (surArea BETWEEN 250000 AND 2490000) THEN
        SET ausgabe = 'MITTEL';
    ELSEIF (surArea BETWEEN 2500000 AND 10000000) THEN
        SET ausgabe = 'GROSS';
    ELSE
        SET ausgabe = 'RIESIG';
    END IF;


   RETURN ausgabe;
    
END |
DELIMITER ;

-- Anwendung mit z.B.
SELECT Name, Population, SurfaceArea, blatt14_2_func(country.Code) FROM country;

-- Aufgabe 3
-- Erstellen der Log-Tabelle, z.B.:
CREATE TABLE clang_log (delID INT NOT NULL AUTO_INCREMENT, delTime DATETIME
    DEFAULT CURRENT_TIMESTAMP NOT NULL, cCode VARCHAR(3), Lang VARCHAR(30),
    official ENUM('T', 'F'),perc DECIMAL(4,1), PRIMARY KEY(delID))
    AUTO_INCREMENT = 10001;
-- Trigger:
DELIMITER |
CREATE TRIGGER b14_aufg3_trg BEFORE DELETE ON countrylanguage
FOR EACH ROW
BEGIN
    INSERT INTO clang_log(cCode, Lang, official, perc)
        VALUES (OLD.CountryCode, OLD.Language, OLD.IsOfficial, OLD.Percentage);
END |
DELIMITER ;
-- Trigger auslösen mit z.B.
DELETE FROM countrylanguage WHERE CountryCode = 'ABW';
-- Daten wieder zurückschreiben in Originaltabelle mit:
INSERT INTO countrylanguage (CountryCode, Language, IsOfficial, Percentage)
SELECT cCode, Lang, official, perc FROM clang_log;

-- Aufgabe 4
-- Tabelle erstellen, z.B.
CREATE TABLE country_short (Code VARCHAR(3), Name VARCHAR(52),
    Population INT(11), CountrySize VARCHAR(10),PRIMARY KEY(Code));

DELIMITER |
CREATE TRIGGER b14_aufg4 BEFORE INSERT ON country_short
FOR EACH ROW
BEGIN
    SET NEW.CountrySize = blatt14_2_func(NEW.Code);
END |
DELIMITER ;

-- Eintragen von Werten mit z.B.:
INSERT INTO country_short VALUES ('TCD', 'Chad', 7651000, 0);
-- Die "0" für CountrySize wird dann per Trigger und Funktion durch den entspr.
-- Wert ersetzt!
