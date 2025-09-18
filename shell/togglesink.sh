#!/bin/bash

# Execute the initial command and capture the output
sink_output=$(pacmd list-sinks | awk '/\*/ {getline; print $2}')

# Check the output and set the default sink accordingly
if [ "$sink_output" == "<alsa_output.pci-0000_00_1f.3.analog-stereo>" ]; then
	pacmd set-default-sink 0
	echo "Default sink set to 0"
elif [ "$sink_output" == "<alsa_output.pci-0000_01_00.1.hdmi-stereo>" ]; then
	pacmd set-default-sink 1
	echo "Default sink set to 1"
else
	echo "Unknown sink output: $sink_output"
fi
