#!/bin/sh

dunstify 'Sync Start' "Started to sync this to ⭐ hub"

# Capture Unison output
OUTPUT=$(~/projects/scripts/run_unison.sh 2>&1)
LAST_LINE=$(echo "$OUTPUT" | tail -n 1)

# Notify with last line
dunstify 'Sync Finished ✅' "$LAST_LINE"
