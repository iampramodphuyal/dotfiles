#!/bin/bash

# Path to your Hyprland config
# CONFIG="$HOME/.config/hypr/hyprland.conf"
CONFIG="$HOME/.config/hypr/"

# Extract keybindings, format nicely
# Example output: "SUPER+RETURN → exec → alacritty"
# grep '^bind' "$CONFIG" | awk -F', ' '{gsub("bind = ", "", $1); print $1" → "$2" → "$3}' 

# grep -h '^bind' "$CONFIG_DIR"/**/*.conf 2>/dev/null | \
# awk -F', ' '{sub(".*bind = ", "", $1); print $1 " → " $2 " → " $3}'
#

find "$CONFIG" -type f -name "*.conf" -exec grep -h '^bind' {} + \
-exec grep -i -E '^[[:space:]]*bind[a-z]*[[:space:]]*=' {} + \
| awk -F',[[:space:]]*' '{
    gsub(/^[[:space:]]*bind[a-z]*[[:space:]]*=[[:space:]]*/, "", $1)
    print $1 " → " $2 " → " $3
}'
# | awk -F', ' '{sub("bind = ", "", $1); print $1 " → " $2 " → " $3}'
