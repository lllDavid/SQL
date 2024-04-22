# SQL Info2 Übungsblatt 14

Wir verwenden wiederum die neue "world"-Database!

## Aufgabe 1)
Erstelle eine SQL-Funktion, die, unter Angabe des "CountryCode"s als
Rückgabewert den Durchschnittswert der "Percentage"-Spalte aus "countrylanguage"
gibt. Lasse dir anschließend mit hilfe dieser Funktion alle Sprachen des
jeweiligen Landes (evtl. wieder mit Landeskürzel) anzeigen, die unter und/oder
auch über diesem Durchschnittswert liegen!

## Aufgabe 2)
Eine Funktion soll als Return-Wert folgende Wörter zurückgeben, abhängig von der
Landes-Fläche ("SurfaceArea" in "country"), wiederum abhängig vom Landeskürzel:
WINZIG      für SA < 1000
KLEIN       für 1000 < SA < 250.000
MITTEL      für 250.000 < SA < 2.500.000
GROSS       für 2.500.000 < SA < 10.000.000
RIESIG      für SA > 10.000.000
Gib dann die ganze Tabelle aus mit 2-3 sinnvollen Spalten und der eben
erstellten "Größen-Angabe" (nochmals "SurfaceArea" auszugeben kann man evtl. zum
Vergleich auch machen).

## Aufgabe 3)
Erstelle einen SQL-Trigger, der mit-loggt, wenn Datensätze in "countrylanguage"
gelöscht werden, so dass der Datensatz komplett wieder hergestellt werden
könnte, falls gewünscht. Vergiss auch einen Zeitstempel nicht!
Dazu ist eine Log-Tabelle nötig, die in etwa folgende Spalten braucht:
* DeleteID
* Zeit
* CountryCode
* Language
* IsOfficial
* Percentage

## Aufgabe 4)
Bilde eine Kurzversion der Tabelle "country" nach, mit den Spalten:
* Code
* Name
* Population
* CountrySize
Dabei soll mittels eines SQL-Triggers automatisch die Wörter aus der Aufgabe 2
(WINZIG, KLEIN etc., je nach "SurfaceArea") in die Spalte "CountrySize"
eingefügt werden, wenn man in der Tabelle neue Datensätze einträgt.
