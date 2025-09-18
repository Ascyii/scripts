#!/bin/sh

OLD="$1"
NEW="$2"
MERGED="$3" # Optional
BASE="$4"   # Optional

#shift 4  # Shift all four known arguments
PATHS="$@" # Everything left are additional paths/options

# Quoting and checking empty variables safely
if [ -d "$OLD" ]; then
	# Directory diff
	nvim -d -c "DiffviewFileHistory"
	if [ -z "$PATHS" ]; then
		# nvim -d "$OLD" "$NEW" -c "DiffviewFileHistory"
		echo "starting diff view wrapper with no paths"

	else
		#nvim -d "$OLD" "$NEW" -c "DiffviewFileHistory $PATHS"
		echo "starting diff view wrapper with paths"
	fi
else
	# File diff
	if [ -z "$MERGED" ]; then
		nvim -d "$OLD" "$NEW"
	else
		nvim -d -c "DiffviewOpen"
		if [ -z "$PATHS" ]; then
			#nvim -d "$OLD" "$NEW" -c "DiffviewOpen"
			echo "starting diff view wrapper with no paths"
		else
			#nvim -d "$OLD" "$NEW" -c "DiffviewOpen $PATHS"
			echo "starting diff view wrapper with paths"
		fi
	fi
fi
