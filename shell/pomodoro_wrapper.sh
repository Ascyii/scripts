#!/usr/bin/env bash

# Starting pomodoro timer
~/bin/tomatoshell $1

# When started without argument, then clear the console (make it visible again)
if [ "$#" -eq 0 ]; then
	tput reset
fi

