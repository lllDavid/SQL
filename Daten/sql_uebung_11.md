# SQL INFO2 Übungsblatt 11

Wie immer wird wieder die 'northwind'-DB verwendet.

Bei den Aufgaben zu den Stringoperationen gibt es eventuell Konflikte bezüglich
des Datentyps des gefragten Feldes. Um Datentypen nach bestem Wissen und
Gewissen in eine brauchbare Version umzuwandeln, informiere dich über die
**CAST**-Funktion in SQL!

Weiterhin sind in diesem Blatt die entsprechenden Stringoperationen selbständig
zu suchen und anzuwenden.

## Aufgabe 1)

### a)
Was ergibt eine Substring-Anfrage nach __"low"__ in 'string_data' der Tabelle
'strings'; eingeschränkt auf den Datensatz mit der 'id' Nr. 13?

### b)
Ersetze alle Vorkommnisse des Wortes __"Order"__ mit __"ORDER"__ in den
Datensätzen 'string_data' in 'strings

### c)
Lasse dir nun die Zeichenkettenlänge(n) der Spalte 'string_data' anzeigen.

Bonus: Verbinde 'id' und 'string_data' mittels "string concatenation"
(nachschlagen!) und lasse dir davon nochmals die Zeichenkettenlängen anzeigen!

### d)
Finde einen Weg, dir nochmals 'string_data' auf zwei verschiedenen Arten
anzeigen zu lassen:

Alle Werte mit ungerader 'id' sollen in ALLCAPS (also komplett groß geschrieben)
angezeigt werden; alle Werte mit gerader 'id' ausschließlich in Kleinbuchstaben!

## Aufgabe 2)
Weiteres zur JOIN-Syntax:

### a)
LEFT JOIN: Erstelle eine Abfrage, bei der 'order_details' mit 'products' dieses
Mal per LEFT JOIN verknüpft wird. Wie immer braucht man dazu den passenden
Fremdschlüssel; überprüfe auch die Ausgabe genau!

### b)
INNER JOIN: Gefordert ist die Anzeige der Tabellen 'orders' und 'customers'
mittels INNER JOIN.

Bemerkung: INNER JOIN sollte identisch mit der "einfachen" Methode sein, die wir
zu Anfang eingeführt hatten!

### c)
RIGHT JOIN: Wie in Aufgaben __a)__ und __b)__, verbinde nun noch
'purchase_orders' mit 'purchase_orders_details' via RIGHT JOIN.

