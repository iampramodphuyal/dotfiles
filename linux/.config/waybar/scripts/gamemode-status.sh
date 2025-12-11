#!/usr/bin/env sh
HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')

if [ "$HYPRGAMEMODE" = 0 ] ; then
    echo '{"text": "", "tooltip": "Game Mode: ON", "class": "on"}'
else
    echo '{"text": "", "tooltip": "Game Mode: OFF", "class": "off"}'
fi
