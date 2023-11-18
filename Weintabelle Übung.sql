-- Lösungen zum SQL Übungsblatt 2

-- Aufgabe 1) :Tabelle(n) kopieren

-- Aufgabe 2):
UPDATE cellar_copy SET bottles = 9 WHERE bottles >= 10;
SELECT * FROM cellar_copy;

-- Aufgabe 3):
UPDATE cellar_copy SET bottles = 7 WHERE ready > 84 AND bottles <= 7;
SELECT * FROM cellar_copy;

-- Aufgabe 4):
UPDATE cellar_copy SET producer = 'Terrorwein Inc.'
        WHERE producer = 'Ch.St.Jean';
UPDATE cellar_copy SET wine = 'Südtir. Schädelsprenger'
        WHERE wine = 'Fume Blanc';
SELECT * FROM cellar_copy;

-- Aufgabe 5):
UPDATE cellar_copy SET comments = 'vorher Fume Blanc'
        WHERE wine = 'Südtir. Schädelsprenger';
SELECT * FROM cellar_copy;

-- Aufgabe 6):
-- ACHTUNG: Ganzzahlige Division funktioniert in MariaDB nicht so
-- wie in MS SQL! DIV-Operator muss verwendet werden!
UPDATE cellar_copy SET bottles = bottles DIV 2 WHERE producer = 'Robt.Mondavi';
SELECT * FROM cellar_copy;

-- Aufgabe 7):
DELETE FROM cellar_copy WHERE producer = 'Mirassou';
SELECT * FROM cellar_copy;

-- Aufgabe 8):
SELECT wine, producer, (ready - jahr) FROM cellar_copy;
SELECT wine AS 'Weinname', producer AS 'Winzer',
    (ready - jahr) AS 'Reifezeit' FROM cellar_copy;

