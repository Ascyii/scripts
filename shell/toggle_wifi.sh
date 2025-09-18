#!/bin/bash

# Check if an interface name is provided
#if [ -z "$1" ]; then
#  echo "Usage: $0 <interface_name>"
#  exit 1
#fi

INTERFACE="wlo1"

# Parse the interface state from `ip a`
STATE=$(ip a show "$INTERFACE" 2>/dev/null | grep -oP '(?<=state )\w+')

# Check if the interface exists
if [ $STATE = "UP" ]; then
	sudo ip link set $INTERFACE down
else
	sudo ip link set $INTERFACE up
fi
