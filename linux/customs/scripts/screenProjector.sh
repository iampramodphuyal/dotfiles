#! /bin/bash

LAPTOP='eDP-1'
EXTERNAL_MONITOR='HDMI-A-1'


# CONNECTED_DISPLAY=$(wlr-randr --json | jq length)
CONNECTED_DISPLAY=$(wlr-randr --json)

COUNT=$(echo "$CONNECTED_DISPLAY" | jq length)

main_menu(){
  if [ $COUNT -gt 1 ] ; then
    echo "Multiple Display found"
    echo "$CONNECTED_DISPLAY" | jq '.[].name'
  else
    echo " No Multiple Display Found"
  fi
}

main_menu
