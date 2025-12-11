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
  
  local packages=(
    hyprland
    xdg-desktop-portal-hyprland
    blueman
    network-manager-applet
    hyprcursor
    cliphist
    wl-clipboard
    pavucontrol
    swaync
    cpio
    meson
    cmake
    wayland-protocols
    rofi
    hyprlock
    hyprpaper
    hyprland-qtutils
    hyprsysteminfo
    hyprutils
    hyprland-qt-support
    wlr-randr
    git
    lazygit
    neovim
    kitty
    base-devel
    yay
  )
  
  echo "The following packages will be installed:"
  printf ' - %s\n' "${packages[@]}"
  
  read -rp "Proceed? [y/N] " choice
  
  if [[ $choice =~ ^[Yy]$ ]]; then
    sudo pacman -Syu
    sleep 2
    sudo pacman -Syu --needed "${packages[@]}"
  else
    echo "Aborted."
    exit 1
  fi
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
    exit 1
fi


echo "Installation Completed!"
echo "Please, Reboot the System if Changes are not Applied."
