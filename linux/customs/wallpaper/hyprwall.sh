#! /bin/bash
#this will use hyprctl hyprpaper to set wallpaper instantly and save/override to hyprpaper config file to avoid reset on reboot. 
hyprctl hyprpaper preload $1 | hyprctl hyprpaper wallpaper ", $1"
sleep 1
cat << EOF > ~/dotfiles/.config/hypr/hyprpaper.conf
preload = $1
wallpaper = , $1
EOF

hyprctl notify -1 4000 "rgb(ff1ea3)" "fontsize:11 Wallpaper Changed Successfully!"

