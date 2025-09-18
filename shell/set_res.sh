#!/bin/bash

# Get the list of connected displays with their modes
connected_displays=$(xrandr | grep " connected" | awk '{print $1}')

# Extract the primary display (first in the list)
primary_display=$(echo "$connected_displays" | sed -n '1p')

# Extract the secondary display (second in the list, if it exists)
secondary_display=$(echo "$connected_displays" | sed -n '2p')

# Extract the highest resolution for the primary display
primary_resolution=$(xrandr | grep -A1 "^$primary_display connected" | tail -n1 | awk '{print $1}')
echo $primary_display $secondary_display $primary_resolution

# If there's a secondary display, extract its highest resolution
if [ -n "$secondary_display" ]; then
	secondary_resolution=$(xrandr | grep -A1 "^$secondary_display connected" | tail -n1 | awk '{print $1}')

	# Extract the width of the primary display to calculate the correct offset
	primary_width=$(echo "$primary_resolution" | cut -d'x' -f1)
	echo $primary_width

	# Set up xrandr with the detected displays, resolutions, and correct positioning
	xrandr --output "$primary_display" --primary --mode "$primary_resolution" --pos 0x0 --rotate normal \
		--output "$secondary_display" --mode "$secondary_resolution" --pos "${primary_width}x0" --rotate normal
else
	# If there's only one display, just set it as primary with the highest resolution
	xrandr --output "$primary_display" --primary --mode "$primary_resolution" --pos 0x0 --rotate normal
fi
