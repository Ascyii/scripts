#!/usr/bin/env bash

# Directory to search (default: current directory or given argument)
SEARCH_DIR="${1:-.}"

# Your Rnote file viewer (default command to open .rnote files)
RNOTE_VIEWER="rnote"

# Ensure fzf and the viewer exist
command -v fzf >/dev/null 2>&1 || { echo "fzf not found"; exit 1; }
command -v "$RNOTE_VIEWER" >/dev/null 2>&1 || { echo "$RNOTE_VIEWER not found"; exit 1; }

# Find all .rnote files recursively and open them interactively with fzf
find "$SEARCH_DIR" -type f -iname '*.rnote' | sort | \
fzf --multi \
    --bind "enter:execute-silent($RNOTE_VIEWER {} &)" \
