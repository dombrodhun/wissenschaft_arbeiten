#!/bin/sh

# Definiere den Namen deiner Haupt-TEX-Datei ohne Endung
MAIN_FILE="main"
BUILD_DIR="build"

# 1. Build-Verzeichnis erstellen und erster LaTeX-Lauf
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"
lualatex -output-directory="$BUILD_DIR" -interaction=nonstopmode "$MAIN_FILE".tex

# 2. Glossar erstellen
# Die Option -d sagt makeglossaries, wo die Hilfsdateien liegen
makeglossaries -d "$BUILD_DIR" "$MAIN_FILE"

# 3. Bibliographie erstellen
# Wir geben biber den Pfad zur .bcf-Datei direkt mit
biber "$BUILD_DIR/$MAIN_FILE"

# 4. & 5. Abschließende LaTeX-Läufe
lualatex -output-directory="$BUILD_DIR" -interaction=nonstopmode "$MAIN_FILE".tex
lualatex -output-directory="$BUILD_DIR" -interaction=nonstopmode "$MAIN_FILE".tex

echo "✅ Kompilierung abgeschlossen. Die PDF ist in '$BUILD_DIR/$MAIN_FILE.pdf'"
