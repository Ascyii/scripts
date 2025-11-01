#!/usr/bin/env bash

# Directory to search (default: current directory or given argument)
SEARCH_DIR="${1:-.}"

# Your Typst viewer or editor — adjust as needed
TYPST_VIEWER="alacritty -e nvim "   # or "typst preview", "helix", "nvim", etc.

# Ensure required commands exist
command -v fzf >/dev/null 2>&1 || { echo "fzf not found"; exit 1; }

# Find all .typ files recursively and open them interactively with fzf
find "$SEARCH_DIR" -type f -iname '*.typ' | sort | \
fzf --multi \
    --bind "enter:execute-silent($TYPST_VIEWER {} &)"
