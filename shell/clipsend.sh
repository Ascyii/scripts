#!/bin/sh

REMOTE_FILE="~/clip"
SEPARATOR='---xx---'

case "$1" in
append)
	clipboard_content=$(wl-paste)
	formatted_content="$SEPARATOR\n$clipboard_content\n"
	echo -e "$formatted_content" | ssh bi "cat >> $REMOTE_FILE"
	echo "Clipboard contents appended to remote file."
	;;
retrieve)
	lines=$(ssh bi "tac $REMOTE_FILE | awk '/$SEPARATOR/ {exit} {print}' | tac")
	echo -e "$lines" | wl-copy
	echo "Last entry copied to clipboard."
	wtype $lines
	;;
*)
	echo "Usage: $0 {append|retrieve}"
	;;
esac
