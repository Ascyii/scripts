#!/usr/bin/env bash

# Directories to search (default: current directory if none provided)
SEARCH_DIRS=("${@:-.}")

# Your preferred PDF viewer
PDF_VIEWER="zathura"

# Ensure fzf and the viewer exist
command -v fzf >/dev/null 2>&1 || { echo "fzf not found"; exit 1; }
command -v "$PDF_VIEWER" >/dev/null 2>&1 || { echo "$PDF_VIEWER not found"; exit 1; }

# Find all PDFs recursively, sorted by modification time (newest first)
find "${SEARCH_DIRS[@]}" -type f -iname '*.pdf' -printf '%T@ %p\n' | \
    sort -nr | cut -d' ' -f2- | \
    fzf --multi \
        --bind "enter:execute-silent($PDF_VIEWER {} &)" \
        --preview "pdftotext {} - | head -n 20" \
        --preview-window=down:wrap
