DELIMITER //

DROP PROCEDURE IF EXISTS werkzeugeSP //
CREATE PROCEDURE werkzeugeSP(IN id INT, IN bestellmenge INT)
BEGIN
    DECLARE lager INT;

    -- Überprüfen, ob das Werkzeug existiert
    IF ((SELECT COUNT(*) FROM werkzeuge WHERE werkzeuge.id = id) = 0) THEN
        SELECT 'Keine matchenden Ergebnisse' AS Nachricht;
    ELSE
        -- Ausgabe des Werkzeugs
        SELECT * FROM werkzeuge WHERE werkzeuge.id = id;

        -- Lagerbestand des Werkzeugs abrufen
        SELECT Lager INTO lager FROM werkzeuge WHERE werkzeuge.id = id;

        -- Überprüfen, ob die Bestellmenge gleich oder kleiner als der Lagerbestand ist
        IF bestellmenge <= lager THEN
            SELECT 'Bestellung Ok!' AS Nachricht;
        ELSE
            SELECT 'So viel ist nicht auf Lager' AS Nachricht;
        END IF;
    END IF;
END //

DELIMITER ;

CALL werkzeugeSP(1, 2);
