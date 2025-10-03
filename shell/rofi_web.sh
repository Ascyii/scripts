#!/bin/sh

# Prompt user for search query
query=$(nix-shell -p rofi xdg-utils --run "rofi -dmenu -p 'WebSearch: '")

if [[ -n "$query" ]]; then
    xdg-open "https://duckduckgo.com/?q=$(echo $query | sed 's/ /+/g')"
fi
