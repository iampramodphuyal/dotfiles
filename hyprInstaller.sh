#! /bin/bash

echo "Installing Hyprland With Configs..."
echo "...................................."
yay -Syu
sudo pacman -S hyprland xdg-desktop-portal-hyprland blueman network-manager-applet hyprcursor cliphist wl-clipboard pavucontrol swaync cpio meson cmake wayland-protocols rofi hyprlock hyprpaper hyprland-qtutils hyprsysteminfo hyprutils hyprland-qt-support wlr-randr

echo "Installation Completed!"
echo "Please, Reboot the System."
