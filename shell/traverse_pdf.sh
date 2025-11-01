#!/usr/bin/env bash

# Directory to search (default: current directory or given argument)
SEARCH_DIR="${1:-.}"

# Your preferred PDF viewer (adjust as needed)
PDF_VIEWER="zathura"

# Ensure fzf and the viewer exist
command -v fzf >/dev/null 2>&1 || { echo "fzf not found"; exit 1; }
command -v "$PDF_VIEWER" >/dev/null 2>&1 || { echo "$PDF_VIEWER not found"; exit 1; }

# Find all PDFs recursively and feed them to fzf in a loop
find "$SEARCH_DIR" -type f -iname '*.pdf' | sort | fzf --multi --bind "enter:execute-silent($PDF_VIEWER {} &)" --preview "pdftotext {} - | head -n 20" --preview-window=down:wrap
