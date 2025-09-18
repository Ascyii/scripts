#!/bin/bash

# Check if filename argument is provided
if [ -z "$1" ]; then
	echo "Usage: $0 <filename>"
	exit 1
fi
# Get the current directory
current_dir=$(pwd)
# Find the nearest Cabal file
cabal_file=$(find . -maxdepth 1 -type f -name "*.cabal" | head -n 1)
if [ -z "$cabal_file" ]; then
	echo "Error: No Cabal file found in the current directory."
	exit 1
fi
# Extract module name from the provided filename
module_name=$(basename "$1" .hs)

# Check if required variables are set
if [ -z "$cabal_file" ] || [ -z "$module_name" ]; then
	echo "Error: cabal_file and module_name variables are not set."
	exit 1
fi

# Find the line with "other-modules:"
other_modules_line=$(rg -e 'other-modules:' "$cabal_file")
line_number=$(rg -n -e 'other-modules:' "$cabal_file" | cut -d: -f1)

if [[ -z "$other_modules_line" ]]; then
	echo "other-modules: not found in $cabal_file"
	exit 1
fi

# Check if the line is commented
if [[ $other_modules_line == "    -- "* ]]; then
	# Remove the comment "-- "
	sed -i "${line_number}s/    -- other-modules:/    other-modules:/" "$cabal_file"
fi

# Append module_name with comma
sed -i "s/    other-modules:/    other-modules: $module_name,/" "$cabal_file"
# Create the .hs file in the app directory
hs_file="./app/$1.hs"
touch "$hs_file"
# Add boilerplate code to the .hs file
echo "module $module_name where" >"$hs_file"
echo "" >>"$hs_file"
# Open the file with neovim
nvim "$hs_file"
