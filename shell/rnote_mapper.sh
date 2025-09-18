#!/bin/sh

echo "okay"

libinput debug-events | while read -r line; do
    if echo "$line" | grep -q 'TABLET_PAD_BUTTON.*10 pressed'; then
        echo "Tablet Button 6 pressed. Launching Rnote..."
         rnote &
        # optional: add `disown` if you don't want it tied to terminal
    fi
done

