DELIMITER //

DROP PROCEDURE IF EXISTS werkzeugeSP //
CREATE PROCEDURE werkzeugeSP(IN id INT, IN bestellmenge INT)
BEGIN
    DECLARE lager INT;

    -- Überprüfen, ob das Werkzeug existiert
    IF ((SELECT COUNT(*) FROM werkzeuge WHERE werkzeuge.id = id) = 0) THEN
        SELECT 'Keine matchenden Ergebnisse';
    ELSE
        -- Ausgabe des Werkzeugs
        SELECT * FROM werkzeuge WHERE werkzeuge.id = id;

        -- Lagerbestand des Werkzeugs abrufen
        SELECT Lager INTO lager FROM werkzeuge WHERE werkzeuge.id = id;

        -- Überprüfen, ob die Bestellmenge auf Lager ist
        SELECT Lager,
            IF(bestellmenge > Lager, 'So viel ist nicht auf Lager', 'Ok') AS Status
        FROM werkzeuge
        WHERE werkzeuge.id = id;

        -- Überprüfen, ob die Bestellmenge gleich dem Lagerbestand ist
        IF bestellmenge = lager THEN
            SELECT 'Bestellung Ok!';
        END IF;
    END IF;
END //

DELIMITER ;

CALL werkzeugeSP(1, 2);