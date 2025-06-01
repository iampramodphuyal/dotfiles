#!/bin/bash


INTERNAL_MONITOR="eDP-1"
EXTERNAL_MONITOR="HDMI-A-1"

INTERNAL_MONITOR_HEIGHT=$(hyprctl monitors -j | jq 'to_entries[] | select(.value.name == "eDP-1") | .value.height')

hyprctl dispatch setoutputposition $EXTERNAL_MONITOR 0 -$INTERNAL_MONITOR_HEIGHT
