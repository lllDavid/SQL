DELIMITER //

DROP PROCEDURE IF EXISTS simpleCursorExample //
CREATE PROCEDURE simpleCursorExample()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE emp_name VARCHAR(100);
    DECLARE emp_cursor CURSOR FOR SELECT name FROM employees;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Erstellen einer temporären Tabelle, um die Ergebnisse zu speichern
    CREATE TEMPORARY TABLE temp_employee_names (name VARCHAR(100));

    OPEN emp_cursor;

    read_loop: LOOP
        FETCH emp_cursor INTO emp_name;
        IF done THEN
            LEAVE read_loop;
        END IF;
        -- Speichern des aktuellen Namens in der temporären Tabelle
        INSERT INTO temp_employee_names (name) VALUES (emp_name);
    END LOOP;

    CLOSE emp_cursor;

    -- Zurückgeben aller gesammelten Namen
    SELECT name FROM temp_employee_names;

    -- Löschen der temporären Tabelle
    DROP TEMPORARY TABLE temp_employee_names;
END //

DELIMITER ;

CALL simpleCursorExample();