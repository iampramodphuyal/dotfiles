#! /bin/bash

FILE_PATH="$HOME/dotfiles/.config/hypr/custom/monitors.conf"

if grep -q "^\s*monitor=,disabled" "$FILE_PATH"; then
  sed -i "s/^\s*monitor=,disabled/# monitor=,disabled/" "$FILE_PATH"
  hyprctl notify -1 4000 "rgb(ff1ea3)" "fontsize:12 Enabling the in-built monitor"
elif grep -q "^\s*\#\s*monitor=,disabled" "$FILE_PATH"; then
  sed -i "s/^\s*\#\s*monitor=,disabled/monitor=,disabled/" "$FILE_PATH"
  hyprctl notify -1 4000 "rgb(ff1ea3)" "fontsize:12 Disabling the in-built monitor"
else
  echo "monitor=,disabled" >> "$FILE_PATH"
  hyprctl notify -1 4000 "rgb(ff1ea3)" "fontsize:12 Disabling the in-built monitor"
fi

hyprctl reload
