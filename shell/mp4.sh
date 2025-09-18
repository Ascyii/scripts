#!/bin/bash

# Find all .mp4 files in the current directory and subdirectories
media_files=$(find . -type f \( -name "*.mp4" -o -name "*.mp3" \))

# Use fzf to allow the user to select a file
selected_file=$(echo "$media_files" | fzf)

# Check if a file was selected
if [[ -n $selected_file ]]; then
	# Play the selected file with mpv
	mpv "$selected_file" --save-position-on-quit
else
	echo "No file selected."
fi
