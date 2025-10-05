# My Dotfiles

These are my personal dotfiles for Arch Linux, using `yay` as the package manager and `zsh` as the shell.

## Hyprland Users

If you are using Hyprland, it is recommended to run the `hyprInstaller.sh` script to install all the preferred packages and configurations:

```bash
./hyprInstaller.sh
```

## Dependencies

Install all the required dependencies with a single command:

```bash
yay -S git stow starship kitty nvim rofi waybar hyprlock hyprpaper swaync
```

## Installation

1.  Clone the repository to your home directory:

    ```bash
    git clone git@github.com:iampramodphuyal/dotfiles.git ~/dotfiles
    ```

2.  Navigate to the `dotfiles` directory:

    ```bash
    cd ~/dotfiles
    ```

3.  Use GNU Stow to create the necessary symlinks:

    ```bash
    stow .
    ```
