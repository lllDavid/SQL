CREATE TABLE neueTabelle (
    id INT,
    name VARCHAR(20),
    lager INT,
    preis INT,
    hersteller VARCHAR(20),
    changelogID INT
);

DELIMITER $$

CREATE TRIGGER werkzeugeTrigger
BEFORE UPDATE ON werkzeuge
FOR EACH ROW
BEGIN
    INSERT INTO neueTabelle(id, name, lager, preis, hersteller, changelogID)
    VALUES (OLD.id, OLD.name, OLD.lager, OLD.preis, OLD.hersteller, NULL); 
END $$

DELIMITER ;
