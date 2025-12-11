# /bin/bash

LID_STATE=$(cat /proc/acpi/button/lid/LID0/state | awk '{print $2}')
CLAMSHELL_SCRIPT=~/.config/hypr/scripts/clamshell.sh


if [[ "$LID_STATE" == "closed" ]]; then
  hyprctl notify 1 2000 "rgba(43ff64d9)" "fontsize:25 Enabling ClamShell Mode"
  sh $CLAMSHELL_SCRIPT
fi
