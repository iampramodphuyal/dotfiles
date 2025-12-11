#!/bin/bash

if pgrep wofi > /dev/null
then
  pkill wofi
  wofi --show drun &
  wait $!
else
  wofi --show drun &
  wait $!
fi
