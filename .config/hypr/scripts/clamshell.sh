#! /bin/bash

INTERNAL="eDP-1"
EXTERNAL="HDMI-A-1"
SCALE_EXTERNAL=1
# SCALE_EXTERNAL=1.2

hyprctl keyword monitor "$EXTERNAL,preferred,auto,$SCALE_EXTERNAL"

sleep 1

# List all workspaces on the internal display
internal_workspaces=$(hyprctl workspaces -j | jq -r ".[] | select(.monitor == \"$INTERNAL\") | .id")

# Move each workspace to the external display
for ws in $internal_workspaces; do
  hyprctl dispatch moveworkspacetomonitor "$ws $EXTERNAL"
done

# sleep 1 && hyprctl dispatch dpms off eDP-1
hyprctl keyword monitor "eDP-1,disable" 

hyprctl notify 1 2000 "rgb(511ec1)" "fontsize:25 Moved workspaces from $INTERNAL to $EXTERNAL"

