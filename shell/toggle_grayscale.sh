#!/usr/bin/env bash

HOUR=$(date +%H)
if [ "$HOUR" -ge 19 ] || [ "$HOUR" -lt 7 ]; then
  #hyprshade on grayscale-custom
  dunstctl set-paused true
else
  hyprshade off
  dunstctl set-paused false
fi
