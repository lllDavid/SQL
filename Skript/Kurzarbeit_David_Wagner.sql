-- Kurzarbeit SQL David Wagner Info2 01.12.23

-- Aufgabe 1

USE SQLInfo;

CREATE TABLE karitOrg ( reg_nr SMALLINT, name VARCHAR(50), eingetr_verein BOOLEAN, typ TINYTEXT, gruendungs_jahr SMALLINT, kontostand_EUR BIGINT);

INSERT INTO karitOrg (reg_nr, name, eingetr_verein, typ, gruendungs_jahr, kontostand_EUR)
        VALUES (4001,"Baumschmuser",TRUE,"Schutz von gefährdeten Pflanzen",1962,15296392.34);
INSERT INTO karitOrg (reg_nr, name, eingetr_verein, typ, gruendungs_jahr, kontostand_EUR)
        VALUES (4002,"Club zur Erhaltung des wilden Zwergkaninchens",FALSE,"Schutz von Zwergkaninchen und anderer Kleintierspezies",2003,863621.03);
INSERT INTO karitOrg (reg_nr, name, eingetr_verein, typ, gruendungs_jahr, kontostand_EUR)
        VALUES (4003,"Green Goblins",FALSE,"Militante Kämpfer für den Anarcho-Primitivismus",2011,74.62);
INSERT INTO karitOrg (reg_nr, name, eingetr_verein, typ, gruendungs_jahr, kontostand_EUR)
        VALUES (4004,"Sehr graue Wölfe",TRUE,"Unterstützung des würdigen Älter-werdens",1972,62268112.97);
INSERT INTO karitOrg (reg_nr, name, eingetr_verein, typ, gruendungs_jahr, kontostand_EUR)
        VALUES (4005,"Eulen Spiegel",TRUE,"Versorgung und Aufheiterung kraker Kinder",1988,826276.88);

-- Aufgabe 2
       
INSERT INTO karitOrg (reg_nr, name, eingetr_verein, typ, gruendungs_jahr, kontostand_EUR)
        VALUES (4006,"Bonsai Boys",TRUE,"Aufzucht und Pflege japanischer Bonsai-Bäume",1986,122932.12);
INSERT INTO karitOrg (reg_nr, name, typ,kontostand_EUR)
        VALUES (4007,"501ste Legion","Ausrüstung und Reenactment der Taktiken imperialer Sturmtruppen",2367226.01);
       
-- Aufgabe 3
       
CREATE VIEW auskunft AS SELECT reg_nr,name,kontostand_EUR FROM karitOrg;
SELECT * FROM auskunft

-- Aufgabe 4 

-- a 
UPDATE karitOrg SET eingetr_verein=FALSE,gruendungs_jahr = 1995 WHERE reg_nr = 4007;

-- b
UPDATE karitOrg SET kontostand_EUR = kontostand_EUR - 1000 WHERE reg_nr = 4001 OR reg_nr = 4004;

-- Aufgabe 5
CREATE VIEW zuschuß AS SELECT reg_nr,name,gruendungs_jahr,kontostand_EUR FROM karitOrg WHERE gruendungs_jahr < 1990 AND kontostand_EUR < 1000000;
SELECT * from zuschuß;





