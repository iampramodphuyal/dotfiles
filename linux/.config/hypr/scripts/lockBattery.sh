# !/bin/bash
#

ICONS=(" " " " " " " " " " " ")
charging_icon="  "

# Get the current battery percentage
battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)

# Get the battery status (Charging or Discharging)
battery_status=$(cat /sys/class/power_supply/BAT0/status)

icon_index=$((battery_percentage / 20))

# Get the corresponding icon
battery_icon=${ICONS[icon_index]}

[ "$battery_status" = "Charging" ] && echo "$charging_icon$battery_icon$battery_percentage% " || echo "$battery_icon$battery_percentage%"

