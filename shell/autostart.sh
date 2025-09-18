#!/bin/bash

# Doing some default configurations
#/home/johah/scripts/mousecenter2.sh
#xdotool key Super+b
#/home/johah/scripts/mousecenter1.sh
#xdotool key Super+b

# Launching the st terminal with neofetch and spacing on startup
st -t "FocusDone" -e bash -c 'echo " " && echo " " && echo -e " Workstation\033[0m is\033[1;92m ready\033[0m!" && echo " " && echo " " && neofetch && echo " " && cd; bash'
xsetroot -name "ZeroSum"
