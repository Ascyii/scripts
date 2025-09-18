#!/bin/bash

SESSION_NAME="services"
PROJECTS_DIR="$HOME/projects"

################################

# autoscan for start.sh in the projects dir

# Array of [dirname startscript]
# Ony extra
entries=(
	"djangowebtrack" "./run.sh host"
)

###################################################

# Scan folders
for dir in "$PROJECTS_DIR"/*/; do
	dirname="$(basename "$dir")"

	if [[ -x "$dir/start.sh" ]]; then
		entries+=("$dirname" "./autostart.sh")
	fi
done

# No entries found
if [[ ${#entries[@]} -eq 0 ]]; then
	echo "No start scripts found in $PROJECTS_DIR."
	exit 1
fi

# Start tmux session if it does not exist
if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
	tmux new-session -d -s "$SESSION_NAME"
fi

# Get list of already existing windows
existing_windows=$(tmux list-windows -t "$SESSION_NAME" -F "#{window_name}")

# Create new windows only if they don't already exist
for ((i = 0; i < ${#entries[@]}; i += 2)); do
	dirname="${entries[i]}"
	startcmd="${entries[i + 1]}"

	if echo "$existing_windows" | grep -Fxq "$dirname"; then
		echo "Window '$dirname' already exists, skipping..."
	else
		echo "Starting '$dirname'..."
		tmux new-window -t "$SESSION_NAME" -n "$dirname" "cd \"$PROJECTS_DIR/$dirname\" && $startcmd"
	fi
done

# Kill default window if empty
if tmux list-windows -t "$SESSION_NAME" | grep -q "^1: bash"; then
	tmux kill-window -t "$SESSION_NAME:1" 2>/dev/null
fi

# Attach if not inside tmux
if [[ -z "$TMUX" ]]; then
	tmux attach-session -t "$SESSION_NAME"
else
	echo "Already inside tmux. Session '$SESSION_NAME' updated."
fi
