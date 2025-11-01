#!/usr/bin/env bash

HOUR=$(date +%H)
if [ "$HOUR" -ge 19 ] || [ "$HOUR" -lt 7 ]; then
  hyprshade on grayscale-custom
else
  hyprshade off grayscale-custom
fi
