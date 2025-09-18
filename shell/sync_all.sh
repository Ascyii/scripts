#!/bin/sh

# Path to the file containing the list of paths
file="$HOME/.syncs"

# Iterate over each line in the file
while IFS= read -r path; do
	# Process each path
	cd ~/$path
	# Check arguments
	if [ "$1" = "out" ]; then
		echo "Syncing OUT to $path ..."
		bash ./sync.sh out
	elif [ "$1" = "in" ]; then
		echo "Syncing OUT to $path ..."
		bash ./sync.sh out
	else
		echo "Usage: $0 [out|in]"
		exit 1
	fi

	cd ~

done <"$file"
