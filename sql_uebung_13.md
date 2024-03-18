# SQL Info2 Übungsblatt 13

Im Folgenden soll es um die Datenbank "world" und die darin enthaltenen Tabellen
gehen. Die DB muss erst mit dem File "tab_world.sql" unter der Server-Connection
"localhost" (in DBeaver in der Menüleiste oben einstellen!) installiert werden!

## Aufgabe 1)

### a)
In der Tabelle "city" soll zunächst eine SP erstellt werden, mit der man bei
Angabe eines "Country Code"s die gesamte, zusammengerechnete, Zahl der Einwohner
der aufgeführten Städte ("Population") für dieses Land ausgegeben bekommt

### b)
Nun soll das gleiche für **alle** Länder passieren. Ein Cursor könnte hier
wieder nützlich sein!

## Aufgabe 2)
Nach Angabe eines "Country Code"s, finde die größte Stadt dieses Landes und
formatiere eine ansprechende Ausgabe (CONCAT!), die auch den ausgeschriebenen
Namen des Landes beinhaltet. Dieser ist zu finden in der Tabelle "country"
("Name")!.

## Aufgabe 3)
Eine Prozedur soll einen INOUT-Parameter annehmen, der eine "gewünschte"
Ziel-Landesfläche ("SurfaceArea" in "country") angibt. Zusammen mit einem
zweiten (regulären?) Parameter, der die mögliche Abweichung "nach unten und
oben" angibt (z.B. 1000, 10000, 50000 etc.) sollen dann die Länder, die in
diesen flächenmäßigen Größenbereich fallen, ausgegeben werden.
Der INOUT-Parameter muss natürlich vor dem Procedure Call angegeben werden;
vergewissere dich außerdem, dass er auch nach dem Call auslesbar ist/bleibt.

## Aufgabe 4)
Mathematik: Summiere alle Bruttosozialprodukte in "country" (Spalte "GNP";
"Gross National Product", in Mio. Dollar(?)) auf und mache das gleiche mit den
Bevölkerungszahlen ("Population" in "country"). Teile dann das summierte GNP
durch die summierte Population, um eine ungefähre Angabe zur Arbeitsleistung
eines Menschen, gemittelt über die ganze Weltbevölkerung, zu bekommen.
Das Ganze ist aber dann immer noch in Mio. Dollar(?) zu sehen. Deshalb multipliziere
das Ergebnis noch mit 1000000, um eine Dollar-Angabe zu erhalten und gib dieses
dann, schön formatiert, zusammen mit den Zwischenergebnissen (SumGNP und SumPop)
aus!
