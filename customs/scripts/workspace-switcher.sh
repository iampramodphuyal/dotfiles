#! /bin/bash

INTERNAL_MONITOR="eDP-1"
EXTERNAL_MONITOR="HDMI-A-1"

switch_to_external(){
  CHECK_DPMS=$(hyprctl monitors -j | jq '.[] | select(.dpmsStatus == true and .id==0) | .name' | awk '{$1=$1;print}')
  if [ -n "$CHECK_DPMS" ]; then
    hyprctl notify -1 4000 "rgb(ff1ea3)" "fontsize:12 Switching Workspaces to external monitor"
    for ws in {1..10}; do
      hyprctl dispatch moveworkspacetomonitor "$ws" "$EXTERNAL_MONITOR"
    done
    hyprctl dispatch dpms off $INTERNAL_MONITOR
  else 
    hyprctl notify -1 4000 "rgb(ff1ea3)" "fontsize:11 No Screen available, maybe monitor already disabled"
  fi
}

switch_to_internal(){
  CHECK_DPMS=$(hyprctl monitors -j | jq '.[] | select(.dpmsStatus == true and .id==0) | .name' | awk '{$1=$1;print}')
    if [ -z "$CHECK_DPMS" ]; then
      hyprctl notify -1 4000 "rgb(ff1ea3)" "fontsize:12 Switching Workspaces to internal monitor"
      hyprctl dispatch dpms on $INTERNAL_MONITOR
      for ws in {1..10}; do
        hyprctl dispatch moveworkspacetomonitor "$ws" "$INTERNAL_MONITOR"
      done
    else
      hyprctl notify -1 4000 "rgb(ff1ea3)" "fontsize:12 Already on Laptop Screen"
    fi
}

main(){
  if [ "$1" == 'ste' ]; then
    switch_to_external
  elif [ "$1" == 'sti' ]; then
    switch_to_internal
  else
    hyprctl notify -1 4000 "rgb(ff1ea3)" "fontsize:12 No valid argument found"
  fi
hyprctl reload
}

main "$1"
