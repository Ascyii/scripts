#!/usr/bin/env bash

# Directories to search (default: current directory if none provided)
SEARCH_DIRS=("${@:-.}")

# Your Rnote file viewer
RNOTE_VIEWER="rnote"

# Ensure fzf and the viewer exist
command -v fzf >/dev/null 2>&1 || { echo "fzf not found"; exit 1; }
command -v "$RNOTE_VIEWER" >/dev/null 2>&1 || { echo "$RNOTE_VIEWER not found"; exit 1; }

# Find all .rnote files recursively, sorted by modification time (newest first)
find "${SEARCH_DIRS[@]}" -type f -iname '*.rnote' -printf '%T@ %p\n' | \
    sort -nr | cut -d' ' -f2- | \
    fzf --multi \
        --bind "enter:execute-silent($RNOTE_VIEWER {} &)"
