#!/bin/sh

# This is a script to always have only one instance of kitty running
# You can run another one if you wish if you use the menu manager
# Use tmux or the 

if hyprctl clients | grep -q 'class: kitty'; then
    # Focus existing kitty
    hyprctl dispatch focuswindow class:kitty
else
    # No kitty window found, launch kitty
    kitty &
fi
