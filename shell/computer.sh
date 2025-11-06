#!/usr/bin/env bash

# Detect machine by hostname
HOST=$(hostname)

case "$HOST" in
    "minoxy")
        # Apps for workstation
        firefox --browser &
        sleep 2
        hyprctl dispatch workspace 1
        ;;
    "thinix")
        # Apps for laptop
        #thunderbird &
        #nm-connection-editor &
        ;;
    *)
        echo "Unknown host: $HOST"
        ;;
esac

# Optional: background processes should detach from terminal
disown
