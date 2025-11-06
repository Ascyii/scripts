#!/usr/bin/env bash

# Try to kill
killall .rnote-wrapped
killall .sioyek-wrapped
killall .zathura-wrapped

# Select a parent folder using fzf
parent_folder=$(find ~/Nextcloud/University -mindepth 1 -type d | fzf --prompt="What to work on? Or exit work. ") || exit
folder_name=$(basename "$parent_folder")
alt_path=~/projects/university/S3/"$folder_name"/VL

# Find latest modified PDF and .rnote in that folder (non-recursive)
latest_pdf=$(find "$parent_folder" -maxdepth 1 -type f -name "*.pdf" -printf '%T@ %p\n' | sort -n | tail -1 | cut -d' ' -f2-)
latest_rnote=$(find "$parent_folder" -maxdepth 1 -type f -name "*.rnote" -printf '%T@ %p\n' | sort -n | tail -1 | cut -d' ' -f2-)
latest_vl=$(find "$alt_path" -maxdepth 1 -type f -name "*.pdf" -printf '%T@ %p\n' | sort -n | tail -1 | cut -d' ' -f2-)

# Open .rnote
[[ -n "$latest_rnote" ]] && xdg-open "$latest_rnote" > /dev/null 2>&1 &

# Open PDF
[[ -n "$latest_pdf" ]] && sioyek "$latest_pdf" > /dev/null 2>&1 &

# Open VL file in Sioyek if found
[[ -n "$latest_vl" ]] && zathura "$latest_vl" > /dev/null 2>&1 &

# Open Firefox only if it's already running
if pidof firefox > /dev/null; then
    firefox https://ecampus.uni-goettingen.de
    #firefox https://wikipedia.com
else
    echo "Firefox is not running, not starting a new instance."
fi

# Workspace logic
sleep 2
hyprctl dispatch workspace 3
hyprctl dispatch movetoworkspace 5
hyprctl dispatch workspace 4
sleep 0.1
hyprctl dispatch workspace 3
hyprctl dispatch movetoworkspace 8
hyprctl dispatch workspace 4

#sleep 0.5
#for i in {1..10}; do
#    ydotool key 29:1 13:1 13:0 29:0 # 29: ctrl 13: equal :1 down :0 up
#    sleep 0.005
#done
