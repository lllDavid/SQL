DELIMITER $$

CREATE TRIGGER prevent_manual_loan_update
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    IF NEW.loan_amount <> OLD.loan_amount THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Manual update of loan_amount is not allowed.';
    END IF;
END $$

DELIMITER ;
