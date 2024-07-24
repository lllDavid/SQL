-- Abschlussprüfung David Wagner 08.07.2024

###1.)
##a)

# Eine relationelle Datenbank ist eine Sammlung von Tabellen. Sie speichert Daten strukturiert in Tabellen, Zeilen und Spalten.
# Die Datensätze werden mit Datentypen versehen und haben eine eigene ID um sie eindeutig zuzuordnen.
# Außerdem hat jede Tabelle einen Primärschlüssel der Zeilen eindeutig kennzeichnet.

##b)

# INT = Integer Ist eine Ganzzahl
# CHAR(n) Zeichenfolge mit fester Größe. (n) Muss wert zwischen 1 und 8000 sein.
# VARCHAR(n) Zeichenfolge mit variabler Größe. (n) Gibt Größe in Byte an 
# DECIMAL(p, s) Zahl mit fester Genauigkeit. (p) ist die maximale Gesamtanzhal der Dezimalstellen zwischen 1 und 38.
# (s) ist der Dezimalstellenwert. Anzahl wird vom (p) subtrahiert. Wert muss zwischen 0 und (p) sein.

# Eine Tabellenspalte kann nur einen Datentypen haben
# Datensätze müssen einzigartig sein. Man kann sie aber z.B durch Joins verknüpfen.

##c)

# Ein Primärschlüssel ist für die eindeutige Identifizierung von Tabellen und ist notwendig für die Beziehungen zwischen den  Tabellen
# Der Primärschlüssel muss einmalig sein und darf keine Nullwerte enthalten.
# Ein Fremdschlüssel ist eine Spalte die mit der Spalte Primärschlüssel in anderer Tabelle verknüpft ist. z.B in Tabelle Customer ist der Primär ID und in der Tabelle Orders ist der Fremdschlüssel Orders.Customer_ID


###2.)
##a)

# Die Tabelle ist noch in keiner Normalform da sie weiter aufteilbar ist 
# Tabellen werden in Normalform gebracht um Redundanzen zu vermeiden und Daten Inkonsistenzen zu vermeiden, außerdem kann es einer besseren Übersicht dienlich sein.

##b)

#1 Normalform
# ID | Buchreihe | Autor | Geb.Jahr Autor | Erscheinungsjahr des 1. Buches der Reihe | Buchtitel

#2 Normalform 
# Aufteilung in 2 Tabellen

# Tabelle Autor
# Autor | Geb.Jahr Autor 

# Tabelle Buch
# ID | Buchreihe | Erscheinungsjahr des 1. Buches der Reihe | Buchtitel

#3 Normalform siehe 2 Normalform

###3.)
##a)


CREATE TABLE regionalvereine (reg_nr smallINT NOT NULL, name varchar(30), eingetr_verein boolean, typ varchar(30), gruendungs_jahr smallint, kontostand_EUR bigint, primary key(reg_nr));

INSERT INTO regionalvereine (reg_nr, name, eingetr_verein, typ, gruendungs_jahr, kontostand_EUR)
        VALUES (4001,"Glonntaler Schützen",TRUE,"Schützenverein",1886,1296392.34);
 
INSERT INTO regionalvereine (reg_nr, name, eingetr_verein, typ, gruendungs_jahr, kontostand_EUR)
        VALUES (4002,"Verein der Gartenfreunde",FALSE,"Gartenbau",1975,163621.03);
       
INSERT INTO regionalvereine (reg_nr, name, eingetr_verein, typ, gruendungs_jahr, kontostand_EUR)
        VALUES (4005,"Chiemgauer Kickers",TRUE,"Fussballverein",1986,414276.88);

##b)
       
INSERT INTO regionalvereine (reg_nr, name, eingetr_verein, typ, gruendungs_jahr, kontostand_EUR)
        VALUES (4006,"AllezHop!",TRUE,"Turnverein",2001,1337.12);
       
INSERT INTO regionalvereine (reg_nr, name, typ, kontostand_EUR)
        VALUES (4007,"Faschingsgilde Alpenland","Faschingsverein",75226.01);
       
##c) 
#i)
UPDATE regionalvereine SET eingetr_verein = false where reg_nr = 4007;

UPDATE regionalvereine SET gruendungs_jahr = 1989 where reg_nr = 4007;

#ii)
UPDATE regionalvereine SET kontostand_EUR = kontostand_EUR - 1000 where reg_nr = 4001 or reg_nr = 4005;


##d)

CREATE VIEW kontostaende AS SELECT reg_nr, name, kontostand_EUR FROM regionalvereine;
SELECT * from kontostaende;


##e) 

CREATE VIEW bonus  AS SELECT reg_nr,name,gruendungs_jahr,kontostand_EUR FROM regionalvereine WHERE gruendungs_jahr < 1990 AND kontostand_EUR < 1000000;
SELECT * from bonus;


##f)
SELECT COUNT(*) from regionalvereine;

SELECT MAX(kontostand_EUR), MIN(kontostand_EUR) FROM regionalvereine ;

SELECT AVG(kontostand_EUR) from regionalvereine ;

SELECT SUM(kontostand_EUR) from regionalvereine;


###4.)
# SP funktioniert mit IDs in meiner Tabelle
# SP wurde in anderem Skript ausgeführt

DELIMITER //

DROP PROCEDURE IF EXISTS regionalvereineSP //
CREATE PROCEDURE regionalvereineSP(IN reg_nrSP smallint, IN mitgliederAnzahl int)
BEGIN
DECLARE kontostand bigint;
DECLARE auszahlung bigint;
    IF ((SELECT COUNT(*) FROM regionalvereine  WHERE reg_nr = reg_nrSP) = 0) THEN
        SELECT 'Keine matchenden Ergebnisse!' AS Nachricht;
      ELSE
        SELECT * FROM regionalvereine  WHERE reg_nr = reg_nrSP ;
END IF;

SELECT kontostand_EUR into kontostand from regionalvereine where reg_nr  = reg_nrSP;
SET auszahlung = kontostand/mitgliederAnzahl;
SELECT CONCAT("Das auszahlbare Geld pro Mitglied ist: ", auszahlung , "€");

END //

DELIMITER ;

CALL regionalvereineSP(4001,2);


###5.)
CREATE TABLE changeLogTable (
reg_nr smallINT NOT NULL, 
name varchar(30),
kontostand_EUR bigint,
changeID int AUTO_INCREMENT,
changeTime TIMESTAMP DEFAULT current_timestamp,
primary key(changeID)
);

DELIMITER $$

CREATE TRIGGER kontostandTrigger
BEFORE UPDATE ON regionalvereine
FOR EACH ROW
BEGIN
	INSERT INTO changeLogTable (reg_nr, name, kontostand_EUR, changeID, changeTime)
	VALUES (OLD.reg_nr, OLD.name, NEW.kontostand_EUR, NULL , Null); 
END $$

DELIMITER ;

# Beispiel um zu testen ob es funktioniert
Update regionalvereine set kontostand_EUR = 333 where reg_nr = 4005;
Update regionalvereine set kontostand_EUR = 555 where reg_nr = 4







    