#!/bin/bash

# Get the directory and file of the current Typst file
FILE="$1"
echo $FILE
DIR=$(dirname "$FILE")
echo $DIR
PDF_FILE="${DIR}/$(basename "$FILE" .typ).pdf"

#swaymsg workspace 2

# Start typst watch in the background
typst watch "$FILE" --root ../ &>/dev/null &

sleep 1
#swaymsg workspace 1
sioyek --new-window "$PDF_FILE" &>/dev/null &
# Open a new workspace in Sway (workspace number 2 in this example)
# Change this workspace number as needed

# Print process information for debugging
echo "Started typst watch and opened PDF in sioyek on workspace 2."
