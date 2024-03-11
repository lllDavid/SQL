# SQL Info2 Übungsblatt 12

Hier geht's zunächst um die alte "cellar"-Tabelle. Wer die (noch) nicht in der
DB hat, sollte sie neu anlegen mittels der Datei "tab_cellar.sql"!

## Aufgabe 1)
Als Erstes soll eine Stored Procedure (im Folgenden immer mit "SP" abgekürzt)
erstellt werden, die einen Input-Parameter bezüglich der Spalte "producer"
nimmt. Anhand dessen sollen die vorhandenen Flaschen ("bottles") zusammengezählt
und in einem möglichst schön formatiertem SQL-Statement ausgegeben werden!

## Aufgabe 2)
Wandle die obige SP so ab, dass die Ausgabe (Anzahl der jeweiligen Flaschen) als
User-Variable weiterverarbeitet werden kann!

## Aufgabe 3)
Berechne die Zeit zur Reife zwischen dem "ready"-Jahr und dem "jahr" (Wert
sollte natürlich immer positiv sein!) Das soll dieses Mal für zwei Weinarten
ausgegeben werden; man braucht also auch zwei Parameter!

## Aufgabe 4)
Zähle alle Buchstaben der Weinnamen (Spalte "wine") zusammen und gib sie dann
aus. Hier ist eventuell ein "cursor"-Konstrukt nötig!
Anmerkung: In diesem Fall, wo, laut der Aufgabe, kein Parameter übergeben werden
muss, gibt es auch eine im Gegensatz zur "cursor"-Variante eine sehr kurze
Lösungsmöglichkeit. Grundsätzlich ist aber die "cursor"-Version flexibler, v.a.
dann, wenn Parameter ins Spiel kommen!
