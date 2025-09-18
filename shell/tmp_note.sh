#!/usr/bin/env zsh
# This is for nixos specific

# simple script to create and use a temporary note file

# Create new temporary file if not already exists for this date
if [ ! -f /tmp/notes.md ]; then
	echo -e "# $(date)\n\n" >/tmp/notes.md
fi

# Instantly enter the insert mode at the bottom for less friction
nvim -c "e /tmp/notes.md" -c "normal G" -c "normal k" -c "normal o" -c "startinsert"
