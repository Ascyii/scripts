#!/usr/bin/env bash

# Select a parent folder using fzf
parent_folder=$(find ~/Nextcloud/University -mindepth 1 -type d | fzf --prompt="Select parent folder: ") || exit

# Find latest modified PDF and .rnote in that folder (non-recursive)
latest_pdf=$(find "$parent_folder" -maxdepth 1 -type f -name "*.pdf" -printf '%T@ %p\n' | sort -n | tail -1 | cut -d' ' -f2-)
latest_rnote=$(find "$parent_folder" -maxdepth 1 -type f -name "*.rnote" -printf '%T@ %p\n' | sort -n | tail -1 | cut -d' ' -f2-)

# Open them with default apps
[[ -n "$latest_pdf" ]] && xdg-open "$latest_pdf" > /dev/zero 2>&1 &
[[ -n "$latest_rnote" ]] && xdg-open "$latest_rnote" > /dev/zero 2>&1 &
