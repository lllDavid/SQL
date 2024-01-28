# SQL INFO2 Übungsblatt 9

Wir benutzen weiter die Datenbank 'northwind'.

## Aufgabe 1)
In der Tabelle 'orders' sind einige Daten mit dem Datentyp **DATETIME**
formatiert. Lasse dir folgendes anzeigen:

### a)
die Bestellungen, die ab dem Januar 2006 bis einen Monat später aufgegeben
wurden (Spalte 'order_date').

Tip: Es gibt eine Funktion, genau das bewerkstelligen kann - also zum aktuellen
DATETIME-Zeitstempel eine bestimmte Zeitspanne dazu rechnen kann. Suche danach
im Internet! Alternativ kann man natürlich auch "per hand" einen passenden neuen
Zeitstempel eingeben.

### b)
die Bestellungen, die von Anfang Februar 2006 an bis ein viertel Jahr später (3
Monate) aufgegeben wurden. Siehe hierzu auch den Tip von 1a).

### c)
die Bestellungen, die ab dem 01.04.2006 bis eine Woche später versandt wurden
('shipped_date')

### d)
Lasse dir eine (oder auch zwei!) Methode/n einfallen, wie man den Zeitraum von
Bestellung ('order_date') bis Versand ('shipped_date') anzeigen kann! Sieh
wieder im Internet nach, ob es dafür eine geeignete Funktion gibt.

### e)
Bonus: Wie lange liegen die Bestelldaten ('order_date') zurück? Berechne die
Zeit bis heute!


Bei allen Aufgaben sollen die Ergebnisse sortiert und auch eventuelle
NULL-Werte herausgefiltert werden!

## Aufgabe 2)
Numerische/mathematische Funktionen: Auch wenn die nachstehenden Aufgaben
mangels mathematischer oder technischer Datensätze wenig Sinn machen, wollen wir
trotzdem etwas damit üben.

### a)
Tabelle 'order_details':
-Berechne den Gesamtpreis von 'id' Nr. 40 aus 'unit_price' und 'quantity'
-ziehe davon den Gesamtpreis von 'id' 42 ab
-lasse dir den Absolutbetrag des obigen Ergebnisses anzeigen.

### b)
Berechne mittels SUM() die gesamte Stückzahl der Bestellungen ('quantity').

### c)
Die Tabelle 'products' beinhaltet 'standard_cost' und 'reorder_level'. Lasse dir
den minimalen Einkaufswert der Waren anzeigen, die mindestens vorrätig sein
sollten - ab 'id' 40 bis 'id' 80 und auf verschieden Arten:
-aufgerundet auf den nächsthöheren $/€
-abgerundet zum nächstkleineren $/€
-nach den üblichen Regeln gerundet (also aufrunden ab x.5!)

### d)
Überprüfe, ob gerade eine ungerade Anzahl im 'reorder_level' eingetragen ist (es
dürfte wieder mehrere Methoden geben!). Ab hier sollen wieder alle Datensätze
mit einbezogen werden.

### e)
Weitere Rechnungen: Berechne aus der 'products'-Tabelle, was das Versandhaus bei
einer knapperen Vorratshaltung sparen könnte. Nimm dazu den minimalen
Einkaufswert von oben und ziehe ihn von ('target_level' * 'standard_cost') ab.

