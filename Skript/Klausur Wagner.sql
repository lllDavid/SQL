#David Wagner


# Aufgabe1
#a)
# Ein Left Join verknüpft linke mit rechter Tabelle und enthält alle Datenätze aus linker und rechter Tabelle 
# auch wenn rechte Tabelle keine übereinstimmenden Werte/Datensätze hat. Die nicht gemachten Felder werden leer bleiben.

#b)
#SELECT * FROM werkzeuge LEFT JOIN herstellerdaten ON werkzeuge.Hersteller  = herstellerdaten.HID;

# Das Kommando lautet LEFT JOIN 



# Aufgabe2
#a)
#SELECT * FROM herstellerdaten RIGHT JOIN werkzeuge ON werkzeuge.Hersteller = herstellerdaten.HID;

#b)
# Es verknüpft die matchenden Records aus rechter Tabelle selbst wenn es keine matches in der linken gibt



# Aufgabe3
#a) Ein Primärschlüssel erlaubt eine eindeutige Identifizierung von Tabellen und ist notwendig für die Beziehungen zwischen Tabellen
# Der Primärschlüssel muss einmalig sein und darf keine Nullwerte enthalten. Z.B In Tabelle Kunde ist er KundeID

#b) Ein Primärschlüssel besteht normalerweise aus einem Attribut ein zusammengesetzer aus mehreren Attributen. z.B in Tabelle Personen könnte er vor und nachname sein



# Aufgabe4
DELIMITER //

DROP PROCEDURE IF EXISTS werkzeugeSP //
CREATE PROCEDURE werkzeugeSP(id INT, bestellmenge INT)
BEGIN
	IF ((SELECT COUNT(werkzeuge.id) FROM werkzeuge WHERE werkzeuge.id = id) = 0) THEN
	SELECT "Keine matchenden Ergebnisse";
	ELSE
		SELECT * FROM werkzeuge WHERE werkzeuge.id = id;
	END IF;

	SELECT Lager,
	IF(bestellmenge > Lager, "So viel ist nicht auf Lager","Ok")
	FROM werkzeuge;

	IF id = werkzeuge.id AND bestellmenge = werkzeuge.Lager THEN
	SELECT "Bestellung Ok!";
	END IF;
	
	
END //

DELIMITER ;

CALL werkzeugeSP(1,2);


# Aufgabe 5
 CREATE TABLE neueTabelle (id int,name varchar(20), lager int, preis int, hersteller varchar(20), changelogID int);

DELIMITER $$

CREATE TRIGGER werkzeugeTrigger
BEFORE UPDATE ON werkzeuge
FOR EACH ROW
BEGIN
   INSERT INTO neueTabelle(id,name,lager,preis,hersteller,changelogID)
        VALUES (OLD.id, OLD.name, OLD.lager, OLD.preis, OLD.hersteller, OLD.changelogID); 
   END IF;
END $$

DELIMITER ;



