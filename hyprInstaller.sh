#! /bin/bash

echo "Installing Hyprland..."
yay -Syu
yay hyprland
sudo pacman -S xdg-desktop-portal-hyprland
yay blueman
yay network-manager-applet
yay hyprcursor
yay cliphist
yay wl-clipboard
yay pavucontrol
yay swaync
yay cpio
yay meson
yay cmake
yay wayland-protocols
yay rofi
yay hyprlock
yay hyprpaper
yay hyprland-qtutils
yay hyprsysteminfo
yay hyprutils
yay hyprland-qt-support
yay wlr-randr

echo "Installation Completed! Reboot the System."
