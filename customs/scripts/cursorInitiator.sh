#! /bin/bash

#This Script is used to make alias for opening cursor via appImage file

APPIMAGE="$HOME/Documents/Cursor-0.48.6-x86_64.AppImage"
DIR="${1:-$(pwd)}"

if [[ ! -f "$APPIMAGE" ]]; then
    echo "Error: AppImage not found at $APPIMAGE"
    exit 1
fi

# Run the IDE with the given directory
"$APPIMAGE" "$DIR" 

