# postbank_pdf2qif.sh

Dieses Repository enthält eine Sammlung von Skripten, mit deren Hilfe die Umsätze aus Kontoauszügen im PDF-Format im [QIF-Format](https://en.wikipedia.org/wiki/Quicken_Interchange_Format) extrahiert werden können.

Momentan werden Postbank-Kontoauszüge, wie die Postbank sie seit Mitte 2023 zur Verfügung stellt, unterstützt.

Ich verwende diese Skripte, um die Postbank-Umsätze in [HomeBank](https://www.gethomebank.org) zu importieren.
Ich habe damit alle Umsätze für 2024 importieren können.

Das PDF-Format der Postbank ist ein "moving target", weswegen z. B. [FlatheadV8/Postbank_PDF2CSV](https://github.com/FlatheadV8/Postbank_PDF2CSV) nicht mehr funktioniert.
Mal schauen, wie lange diese Version kompatibel bleibt.
(Ich schreibe das im Februar 2025.)

Ich habe verschiedene Ansätze ausprobiert, u. a. `pdftoppm` in Kombination mit [Tesseract](https://github.com/tesseract-ocr/tesseract).
Der Schlüssel war letzten Endes der `-fixed`-Modus von `pdftotext`, der die Tabellenstruktur der PDFs bestmöglich bewahrt.
Die AWK-Skripte zum Konvertieren in ein CSV-Format habe ich mir von ChatGPT schreiben lassen - das kann ich empfehlen!

## Verwendung

Es handelt sich um eine Sammlung von Skripten, die, sobald die Abhängigkeiten (s. u.) erfüllt sind, auf jedem Unix-Derivat (macOS, Linux etc.) verwendet werden können sollten.
Bei mir liegen sie unter `~/.local/bin`, ein Verzeichnis, das ich meiner `PATH`-Variable hinzugefügt habe.

Das Hauptskript `postbank_pdf2qif.sh` erwartet als Argument den Dateinamen eines Kontoauszugs im PDF-Format.
Es erzeugt dann eine `.qif`-Datei gleichen Namens im gleichen Vezeichnis:

```shell
for i in *.pdf; do postbank_pdf2qif.sh $i; done
ls -l *.qif
```

Die anderen Skripte lesen von `stdin` bzw. schreiben nach `stdout`.
Sie können ggf. auch einzeln sinnvoll verwendet werden, insbesondere, wenn etwas nicht funktioniert wie erwartet.

- `postbank_pdf2txt.sh` rendert das PDF als Text
- `postbank_txt2table.awk` extrahiert die Tabelle der Umsätze
- `postbank_table2csv.awk` konvertiert die Tabelle in ein CSV-Format
- `postbank_csv2qif.py` konvertiert das CSV-Format ins QIF-Format

## Abhängigkeiten

Ich dokumentiere die Installation per [Homebrew](https://brew.sh/) für macOS, die Linux-Varianten überlasse ich dem geneigten Leser.

### `pdftotext`

`pdftotext` ist der Text-Renderer der PDF-Rendering-Bibliothek [Poppler](https://poppler.freedesktop.org/).
Diese Skripte funktionieren für mich mit Version 25.02.0.

Installation mit `brew`:

```shell
brew install poppler
```

### awk

`awk` sollte bei jedem Unix-Derivat an Bord sein.
Ich verwende die Version, die mit dem macOS mitkommt, ich nehme an, die GNU-Version sollte auch funktionieren.

### Python3

Für die CSV-zu-QIF-Konvertierun habe ich ein kleines Python-Skript geschrieben, das ausschließlich Standard-Bibliotheken von Python3 verwendet.
Python3 kann mit `brew` folgendermaßen installiert werden:

```shell
brew install python3
````

## Andere Kontoauszüge im PDF-Format

Ich gehe davon aus, dass die meisten Kontoauszüge ähnlich formatiert sind.
Sollten die Formate anderer Banken ähnlich zu verarbeiten sein, sammle ich die angepassten Skripte gerne hier.
Macht gerne einen Pull Request auf.
