#!/bin/bash

# Set the directory path
dir_path="app/"

# Check if the directory exists and contains at least one .hs file
if [ -d "$dir_path" ] && [ "$(ls -A $dir_path/*.hs 2>/dev/null)" ]; then
	# If the directory exists and contains .hs files, execute ghci with them
	ghci "$dir_path"*.hs
else
	# If the directory doesn't exist or doesn't contain .hs files, execute ghci without them
	ghci
fi
