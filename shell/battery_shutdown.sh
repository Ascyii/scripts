#!/bin/sh

# Get battery percentage from /sys/class/power_supply/BAT0/capacity
BATTERY=$(cat /sys/class/power_supply/BAT0/capacity)
STATUS=$(cat /sys/class/power_supply/BAT0/status)

echo $BATTERY
echo $STATUS

# Only shutdown if on battery (discharging) and low
if [ "$STATUS" = "Discharging" ] && [ "$BATTERY" -lt 15 ]; then
	systemctl poweroff
fi
