DELIMITER $$

DROP PROCEDURE IF EXISTS IncreaseLoanAmounts$$
CREATE PROCEDURE IncreaseLoanAmounts()
BEGIN
    DECLARE done INT DEFAULT 0;  
    DECLARE employee_id INT;     
    DECLARE employee_loan DECIMAL(10, 2);  

 	DECLARE employee_cursor CURSOR FOR SELECT id, loan_amount FROM employees;

   
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN employee_cursor;

    read_loop: LOOP
        FETCH employee_cursor INTO employee_id, employee_loan;  
        IF done THEN  
            LEAVE read_loop;
        END IF;
		
        
        SET employee_loan = employee_loan * 1.10;

        UPDATE employees SET loan_amount = employee_loan WHERE id = employee_id;
    END LOOP;

    CLOSE employee_cursor;
END $$

DELIMITER ;




call IncreaseLoanAmounts();

select * from employees;
