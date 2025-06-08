#! /bin/bash

echo "Installing Hyprland With Configs..."
echo "...................................."

on_interrupt() {
    echo "Script interrupted with Ctrl+C. Cleaning up..."
    # Add any cleanup code here
    exit 1
}

pkgArch(){
  echo "Detected Arch Linux..."
  yay -Syu
  sudo pacman -S hyprland xdg-desktop-portal-hyprland blueman network-manager-applet hyprcursor cliphist wl-clipboard pavucontrol swaync cpio meson cmake wayland-protocols rofi hyprlock hyprpaper hyprland-qtutils hyprsysteminfo hyprutils hyprland-qt-support wlr-randr
}


pkgFedora(){
  echo "Detected Fedora Linux..."
  sudo dnf update
  sudo dnf copr enable solopasha/hyprland 
  sudo dnf install hyprland hyprpaper network-manager-applet hyprcursor wl-clipboard swaync waybar cmake meson rofi hyprlock hyprland-qtutils hyprland-qt-support hyprutils wlr-randr xdg-desktop-portal-hyprland blueman cliphist --skip-unavailable
}


# Trap SIGINT (Ctrl+C)
trap on_interrupt SIGINT

if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
        arch)
          pkgArch
            ;;
        fedora)
          pkgFedora
            ;;
        *)
            echo "You are on an unsupported or different distribution: $NAME"
            ;;
    esac
else
    echo "Cannot detect OS. /etc/os-release not found."
fi


echo "Installation Completed!"
echo "Please, Reboot the System if Changes are not Applied."
