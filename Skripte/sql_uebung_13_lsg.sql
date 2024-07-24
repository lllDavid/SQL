-- Übungsblatt 13 Lösungen

-- Aufgabe 1)
-- a)
DELIMITER |
-- Country Codes bestehen strikt aus 3 Buchstaben; deshalb hier nur VARCHAR(3)
CREATE PROCEDURE uebung_13_1a (c_code VARCHAR(3))
BEGIN
    -- Bevölkerungs-Summe und Ländername - Variablen deklarieren
    DECLARE pop_total INT;
    DECLARE c_name VARCHAR(50);
    -- Summieren über den angegebenen Country Code
    SELECT SUM(Population) INTO pop_total FROM city WHERE CountryCode = c_code;
    -- Herausfinden des ausgeschriebenen Ländernamens aus der "country" -
    -- Tabelle
    SELECT Name INTO c_name FROM country WHERE Code = c_code;
    -- Formatierte Ausgabe
    SELECT CONCAT('Die Städte in ', c_name, ' haben zusammengerechnet ',
        pop_total, ' Einwohner.') AS Ergebnis;
END |
DELIMITER ;

-- b)
DELIMITER |
CREATE PROCEDURE uebung_13_1b ()
BEGIN
    -- Abbruchbedingung: BOOLEAN Synonym für TINYINT(1); TRUE/FALSE
    -- und true/false Synonyme für 1 resp. 0 bei diesem Datentyp
    -- Default für finished natürlich wieder wichtig
    DECLARE finished BOOLEAN DEFAULT FALSE;
    DECLARE pop_count INT;
    -- Default auch hier wichtig; BIGINT notwendig, weil INT die erwarteten
    -- Zahlen von bis zu 6.000.000.000 nicht mehr handhaben kann!
    DECLARE pop_total BIGINT DEFAULT 0;
    -- Zeile für Zeile die Population auslesen...
    DECLARE cur_population CURSOR FOR
        SELECT Population FROM country;
    -- ...bis nichts mehr gefunden wird
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET finished = TRUE; 
    -- cursor öffnen, loop starten, pop_count in jedem Durchlauf füllen
    OPEN cur_population;
    getPop: LOOP
        FETCH cur_population INTO pop_count;
        -- Abbruch der Schleife, wenn Bedingung (oben) erfüllt
        IF (finished = TRUE) THEN
            LEAVE getPop;
        END IF;
        -- Zusammenrechnen der Populationen
        SET pop_total = pop_total + pop_count;
    END LOOP;
    -- Cursor schließen (!)
    CLOSE cur_population;
    -- Ausgabe
    SELECT CONCAT('Die Gesamtbevölkerung aller (angegebenen) Länder beträgt ',
        pop_total) AS Ergebnis;   
END |
DELIMITER ;

-- Aufgabe 2)
DELIMITER |
CREATE PROCEDURE uebung_13_2 (c_code VARCHAR(3))
BEGIN
    -- gebrauchte Variablen: Stadtname, Landname, (Stadt)Bevölkerung
    DECLARE cityname VARCHAR(20);
    DECLARE countryname VARCHAR(20);
    DECLARE c_maxpop INT;
    -- Größte Stadt-Bevölkerung herausfinden
    SELECT MAX(Population) INTO c_maxpop FROM city WHERE CountryCode = c_code;
    -- Den Stadtnamen dazu bestimmen; diese beiden Befehle würden wohl auch
    -- als geschachtelte SELECT-Abfrage realisierbar sein!
    SELECT Name INTO cityname FROM city WHERE CountryCode = c_code AND 
        Population = c_maxpop;
    -- "Lang"namen aus "country" herausfinden
    SELECT Name INTO countryname FROM country WHERE Code = c_code;
    -- Ausgabe
    SELECT CONCAT('Die größte Stadt von ', countryname, ' ist ', cityname,
        ' mit ', c_maxpop, ' Einwohnern!');
END |
DELIMITER ;

-- Aufgabe 3)
DELIMITER |
-- target_area war als INOUT verlangt
CREATE PROCEDURE uebung_13_3 (INOUT target_area INT, area_tolerance INT)
BEGIN
    -- eine SELECT-Abfrage reicht hier; ginge noch kürzer mit z.B. BETWEEN!
    SELECT Code, Name, Population FROM country where 
        (SurfaceArea > (target_area - area_tolerance)) AND 
        (SurfaceArea < (target_area + area_tolerance));
END |
DELIMITER ;

-- Aufgabe 4)
DELIMITER |
CREATE PROCEDURE uebung_13_4 ()
BEGIN
    -- benötigte Variablen
    DECLARE pop_sum BIGINT;
    DECLARE gnp_sum BIGINT;
    DECLARE gnp_per_person DOUBLE;
    -- Gesamtbevölkerung und GNP-Gesamtsumme auslesen
    SELECT SUM(Population), SUM(GNP) INTO pop_sum, gnp_sum FROM country;
    -- Mathematik...
    SET gnp_per_person = gnp_sum / pop_sum;
    SET gnp_per_person = gnp_per_person * 1000000;
    -- Ausgabe
    SELECT CONCAT('Die Sozialleistung eines jeden Menschen auf der Erde ',
        'beträgt im Durchschnitt ', gnp_per_person, ' Dollar.');
END |
DELIMITER ;