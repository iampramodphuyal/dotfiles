#!/bin/bash

if pgrep wofi
then
  pkill wofi
else
  wofi --show drun
fi