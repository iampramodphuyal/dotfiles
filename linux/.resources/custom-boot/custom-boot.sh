#!/usr/bin/env bash

# Clear the console
clear


# Optional: ASCII art or logo

source $HOME/dotfiles/.resources/name.sh

echo
echo "												      Booting into Arch-Linux"
echo

# Check for failed services and print them
systemctl --failed --type=service --no-legend | awk '{printf "%-20s → FAILED\n", $1}' >&2


echo
echo "												 	  Boot complete!"
sleep 1
