#!/bin/bash

# Get the current active sink
active_sink=$(pactl info | grep 'Default Sink:' | awk '{print $3}')

# Check which sink is active and get its volume
if [ "$active_sink" == "alsa_output.pci-0000_01_00.1.hdmi-stereo" ] || [ "$active_sink" == "alsa_output.pci-0000_00_1f.3.analog-stereo" ]; then
	volume=$(pactl list sinks | grep -A 10 "Name: $active_sink" | grep -m 1 'Volume:' | awk '{print $5}')

	pre=''
	if [ "$active_sink" == "alsa_output.pci-0000_01_00.1.hdmi-stereo" ]; then pre='M'; elif [ "$active_sink" == "alsa_output.pci-0000_00_1f.3.analog-stereo" ]; then pre='H'; fi

	if [ $(pulsemixer --get-mute) -eq 0 ]; then echo "($pre) $volume"; else echo "($pre) Muted"; fi

else
	echo "Active sink not recognized."
fi
