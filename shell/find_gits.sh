#!/bin/sh

# Global vars
file_n="all_git_projects"

# First get the project dirs
project_dirs=$(cat ../data/projects)

# Get the folder name of a git project and store it in a variable
cd ~
if [ -e "/tmp/$file_n" ]; then
	folder=$(fzf <"/tmp/$file_n")
else
	# Store the result
	# #################### Exclusion
	git_repos=$(find . -type d \( -path ./.cache -o -path ./.local -o -path ./SCRATCH -o -path ./BACKUP_YESTERDAY \) -prune -o -name '.git' -print | sed 's|^\./||; s|/.git||')
	combined_repos=$(echo -e "$git_repos\n$project_dirs")
	echo "$combined_repos" >"/tmp/$file_n"
	folder=$(echo "$combined_repos" | fzf)
fi

# Ensure folder is not empty
if [ -n "$folder" ]; then
	#session_name=$(basename "$folder")  # Use only the last part of the path as session name
	session_name=$(echo "$folder" | sed 's/\.\([^ ]*\)/_\1/g')

	if tmux has-session -t "$session_name" 2>/dev/null; then
		if [ -n "$TMUX" ]; then
			tmux switch-client -t "$session_name" # If inside tmux, switch session
		else
			tmux attach-session -t "$session_name" # If outside tmux, attach session
		fi
	else
		cd $folder
		tmux new-session -d -s "$session_name"
		if [ -n "$TMUX" ]; then
			tmux switch-client -t "$session_name" # If inside tmux, switch session
		else
			tmux attach-session -t "$session_name" # If outside tmux, attach session
		fi
	fi
else
	echo "No selection made."
fi

exit
