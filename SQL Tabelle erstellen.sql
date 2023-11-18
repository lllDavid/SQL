-- Lösungen zum SQL Übungsblatt 3

-- Aufgabe 1)
CREATE TABLE schulnoten (id INT NOT NULL, vorname VARCHAR(20),
        name VARCHAR(25), mathe DECIMAL(2,1), physik DECIMAL(2,1),
        deutsch DECIMAL(2,1), englisch DECIMAL(2,1), geschichte DECIMAL(2,1));
        
-- Aufgabe 2)
INSERT INTO schulnoten (id, vorname, name, mathe, physik, englisch)
        VALUES (1001, 'Jerry', 'Lewis', 2.5, 2.9, 3.1);
INSERT INTO schulnoten (id, vorname, name, physik, deutsch, geschichte)
        VALUES (1002, 'Heinz', 'Erhardt', 1.5, 1.3, 3.2);
INSERT INTO schulnoten (id, vorname, name, mathe, physik, deutsch, englisch)
        VALUES (1003, 'Otto', 'Waalkees', 1.0, 2.2, 4.1, 3.5);
INSERT INTO schulnoten (id, vorname, name, mathe, englisch, geschichte)
        VALUES (1004, 'Michael', 'Mittermaier', 2.9, 2.4, 4.4);
INSERT INTO schulnoten (id, vorname, name, physik, deutsch, englisch)
        VALUES (1005, 'Johnny', 'Controlletti', 4.6, 3.5, 3.3);
        
-- Aufgabe 3)
CREATE VIEW schulnoten_sicht AS
    SELECT id, name, mathe, physik FROM schulnoten;
-- oder
CREATE VIEW schulnoten_sicht2 AS
SELECT id, name, mathe, physik FROM schulnoten
    WHERE mathe IS NULL OR physik IS NULL;
-- Anzeigen:
SELECT * FROM schulnoten_sicht;

-- Aufgabe 4)
UPDATE schulnoten SET deutsch = 4.8, geschichte = 2.2 WHERE id = 1001;
UPDATE schulnoten SET mathe = 2.4, englisch = 3.4 WHERE id = 1002;
UPDATE schulnoten SET geschichte = 4.7 WHERE id = 1003;
UPDATE schulnoten SET physik = 3.6, deutsch = 1.2 WHERE id = 1004;
UPDATE schulnoten SET mathe = 4.1, geschichte = 2.1 WHERE id = 1005;
-- Anzeigen:
SELECT * FROM schulnoten_sicht;

-- Aufgabe 5)
CREATE VIEW schulnoten_fail_sicht
        AS SELECT * FROM schulnoten WHERE (mathe > 4.5 OR physik > 4.5 OR 
            deutsch > 4.5 OR englisch > 4.5 OR geschichte > 4.5);
-- Anzeigen:            
SELECT * FROM schulnoten_fail_sicht;
