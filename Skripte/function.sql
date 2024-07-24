-- Addieren
DELIMITER $$

DROP FUNCTION IF EXISTS addNumbers $$
CREATE FUNCTION addNumbers(num1 INT, num2 INT)
RETURNS INT
BEGIN
    DECLARE ergebnis INT;
    SET ergebnis = num1 + num2;
    RETURN ergebnis;
END$$

DELIMITER ;

select addNumbers(2,2) as Ergebnis;



-- Quadratzahl
DELIMITER //

DROP FUNCTION IF EXISTS calculateSquare //

CREATE FUNCTION calculateSquare(number INT)
RETURNS INT
BEGIN
    DECLARE square INT;
    SET square = number * number;
    RETURN square;
END //

DELIMITER ;

SELECT calculateSquare(3) AS Ergebnis;



-- Kreisfläche
DELIMITER //

DROP FUNCTION IF EXISTS CalculateCircleArea //
CREATE FUNCTION CalculateCircleArea(radius DECIMAL(10, 2))

RETURNS DECIMAL(15, 2)
BEGIN
    DECLARE area DECIMAL(15, 2);
    SET area = PI() * radius * radius;
    RETURN area;
END //

DELIMITER ;

SELECT CalculateCircleArea(2.3) as Ergebnis;



-- Gleichheit prüfen
DELIMITER //

DROP FUNCTION IF EXISTS IsEven //
CREATE FUNCTION IsEven(number INT)
RETURNS VARCHAR(10)
BEGIN
    DECLARE result VARCHAR(10);
    IF number % 2 = 0 THEN
        SET result = 'Even';
    ELSE
        SET result = 'Odd';
    END IF;
    RETURN result;
END //

DELIMITER ;

SELECT IsEven(3) as Ergebnis ;
