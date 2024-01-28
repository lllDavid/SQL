# SQL INFO2 Übungsblatt 5

Wir bewegen uns in der DB 'northwind'; es geht immer um die Tabelle
'orders'!

## Aufgabe 1)
Lasse dir die Tabelle 'orders' sortiert nach 'customer_id' anzeigen. Einmal
aufsteigend, dann absteigend sortiert!

## Aufgabe 2)
Lasse dir die Summe der Werte in der Spalte 'shipping_fee' anzeigen. Zunächst
einmal komplett, dann nur die Summe der Versandgebühren in die Empfängerstädte
('ship_city'):

-Las Vegas
-Chicago
-Milwaukee

Lasse dir außerdem noch die Summe der Versandgebühren für alle drei Städte
zusammen anzeigen.

## Aufgabe 3)
Nun soll der Durchschittswert der Versandgebühren angezeigt werden. Zuerst
wieder der Schnitt über die gesamte Tabelle, dann noch der Durchschnittswert der
Gebühren, die der Mitarbeiter mit der ID 9 verschickt hat ('employee_id')!

## Aufgabe 4)
Jetzt soll dier maximale und der Minimal-Wert von 'shipping_fee' gefunden
werden. Erst wieder über die gesamte Tabelle; finde dann das Maximum und das
Minimum der Gebühren, die in den US-Bundesstaat 'NY' (New York, Spalte
'ship_state_province') verschickt wurden.

## Aufgabe 5)
Zum Abschluß soll noch die Gesamt-Anzahl der Bestellungen in 'orders'
gefunden werden. Wie vorher soll es zunächst über die gesamte Tabelle
gehen. Dann sollen noch testweise nur die Anzahl der Datensätze in der Spalte
'customer_id' ermittelt werden. Ist die Tabelle vollständig geführt, sollte
natürlich das gleiche Ergebnis herauskommen!
