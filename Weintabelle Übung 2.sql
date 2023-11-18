-- Lösungen zum SQL Übungsblatt 4

-- Aufgabe 1
SELECT wine, bottles, jahr FROM cellar_copy2 WHERE bottles > 3 AND 
    jahr < 80;

-- Aufgabe 2
SELECT * FROM cellar_copy2 WHERE comments IS NOT NULL;
-- oder:
SELECT * FROM cellar_copy2 WHERE comments <> 'NULL';
SELECT * FROM cellar_copy2 WHERE comments != 'NULL';
SELECT * FROM cellar_copy2 WHERE comments <> '';
-- oder für Tabellen, bei denen die leeren comments mit "''" angegeben wurden:
SELECT * FROM cellar_copy2 WHERE NOT (NULLIF(comments, ''));

-- Aufgabe 3
UPDATE cellar_copy2 SET bottles = bottles + 6 WHERE
        producer = 'Buena Vista';
        
-- Aufgabe 4
UPDATE cellar_copy2 SET bottles = bottles DIV 2 
        WHERE producer = 'Buena Vista';
        
-- Aufgabe 5
UPDATE cellar_copy2 SET bottles = bottles - 1 
        WHERE jahr >= 79 AND jahr <= 81;
-- Anzeige, z.B.:
SELECT wine, producer, bottles FROM cellar_copy2 
    WHERE jahr >= 79 AND jahr <= 81;
    
-- Aufgabe 6
SELECT bin, wine, producer FROM cellar_copy2
    WHERE wine BETWEEN 'A' AND 'M';
-- oder
SELECT bin, wine, producer FROM cellar_copy2
    WHERE wine >= 'A' AND <= 'M';
-- oder einfach nur
SELECT bin, wine FROM cellar_copy2 WHERE
    wine <= 'M';
    
-- Aufgabe 7
SELECT * FROM cellar_copy2 WHERE comments IS NULL;
-- plus evtl. obige Varianten (??)
