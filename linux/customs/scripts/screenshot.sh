#!/usr/bin/env bash

# Save directory
SAVE_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SAVE_DIR"

# Timestamped filename
FILENAME="screenshot-$(date +'%Y-%m-%d-%s').png"
FULL_PATH="$SAVE_DIR/$FILENAME"

# Check if "-r" flag is passed
if [[ "$1" == "-r" ]]; then
    # Capture a selected region
    grim -g "$(slurp -d)" "$FULL_PATH"
else
    # Capture the whole screen
    grim "$FULL_PATH"
fi

# Also copy to clipboard
wl-copy < "$FULL_PATH"

# Notify user (optional, needs `notify-send`)
if command -v notify-send &>/dev/null; then
    notify-send "Screenshot saved" "$FULL_PATH" --icon=applications-graphics
fi

# echo "Screenshot saved to: $FULL_PATH"
