#!/bin/sh

#set -eu

# need a way to use curl and rsync here
exit

# Try to fetch a webpage
curl -Is https://www.duckduckgo.com | head -n 1 &> /dev/null

# Check if the request was successful
if [ $? -eq 0 ]; then
	# Define the local and remote directories
	LOCAL_DIR="$HOME/management"
	REMOTE_USER="gui"                # Replace with the remote username
	REMOTE_SERVER="localhost"     # Replace with the remote server address
	REMOTE_DIR="management"   # Replace with the remote directory path

	# Log the current date and time
	echo "Sync started at $(date)"

	# Use rsync to sync the local directory to the remote server
	rsync -adt --update "$LOCAL_DIR/" "$REMOTE_USER@$REMOTE_SERVER:$REMOTE_DIR"

	# Check if rsync succeeded
	if [ $? -eq 0 ]; then
	  echo "Sync completed successfully at $(date)"
	else
	  echo "Sync failed at $(date)"
	  exit 1
	fi
else
  echo "No internet connection."
fi



