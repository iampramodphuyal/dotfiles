#!/usr/bin/env sh

# Count updates
UPDATES=$(checkupdates 2>/dev/null | wc -l)
AUR_UPDATES=$(yay -Qua 2>/dev/null | wc -l)
TOTAL=$((UPDATES + AUR_UPDATES))

if [ "$TOTAL" -eq 0 ]; then
    echo '{"text": "", "tooltip": "System is up to date", "class": "updated"}'
elif [ "$TOTAL" -lt 10 ]; then
    echo "{\"text\": \"  $TOTAL\", \"tooltip\": \"$UPDATES official + $AUR_UPDATES AUR updates available\", \"class\": \"pending\"}"
else
    echo "{\"text\": \"  $TOTAL\", \"tooltip\": \"$UPDATES official + $AUR_UPDATES AUR updates available\", \"class\": \"urgent\"}"
fi
