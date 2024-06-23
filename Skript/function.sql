-- Funktion AddNumbers
COMMENT ON FUNCTION AddNumbers(INT, INT) IS 'Funktion zum Addieren von zwei Zahlen';

CREATE FUNCTION AddNumbers(num1 INT, num2 INT)
RETURNS INT
BEGIN
    DECLARE result INT;
    SET result = num1 + num2;
    RETURN result;
END;



-- Funktion CalculateSquare
COMMENT ON FUNCTION CalculateSquare(INT) IS 'Funktion zur Berechnung des Quadrats einer Zahl';

CREATE FUNCTION CalculateSquare(input_number INT)
RETURNS INT
BEGIN
    DECLARE square INT;
    SET square = input_number * input_number;
    RETURN square;
END;



-- Funktion CalculateCircleArea
COMMENT ON FUNCTION CalculateCircleArea(DECIMAL(10, 2)) IS 'Funktion zur Berechnung der Fläche eines Kreises';

CREATE FUNCTION CalculateCircleArea(radius DECIMAL(10, 2))
RETURNS DECIMAL(15, 2)
BEGIN
    DECLARE area DECIMAL(15, 2);
    SET area = PI() * radius * radius;
    RETURN area;
END;



-- Funktion IsEven
COMMENT ON FUNCTION IsEven(INT) IS 'Funktion zur Überprüfung, ob eine Zahl gerade oder ungerade ist';

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
END;
