# Dotfiles Cross-Platform Setup Guide

**Date**: December 11, 2024
**Reorganized by**: Claude (Anthropic)
**Commit**: e89567b

## Overview

This repository has been reorganized to support both **Linux** (Arch/Fedora with Hyprland) and **macOS** seamlessly. The configuration files are split into platform-specific and shared directories.

---

## Repository Structure

```
dotfiles/
├── common/              # Cross-platform configs (works on both Linux & macOS)
│   ├── .config/
│   │   ├── nvim/       # Neovim (NvChad)
│   │   ├── kitty/      # Kitty terminal
│   │   ├── ghostty/    # Ghostty terminal
│   │   └── starship.toml
│   ├── .zshrc          # Shell config with platform conditionals
│   ├── .tmux.conf      # Tmux config with platform conditionals
│   ├── alias/          # Shell aliases
│   └── wallpapers/     # Wallpaper collection
│
├── linux/              # Linux-only (Hyprland, Wayland tools)
│   ├── .config/
│   │   ├── hypr/       # Hyprland window manager
│   │   ├── waybar/     # Status bar
│   │   ├── rofi/       # Application launcher
│   │   ├── swaync/     # Notification center
│   │   └── ...
│   ├── customs/        # Custom scripts
│   └── .resources/     # Resources
│
├── macos/              # macOS-only
│   ├── Brewfile        # Homebrew packages
│   └── .macos          # System preferences script
│
├── scripts/            # Installation scripts
│   ├── linux/          # Linux installers
│   ├── macos/          # macOS installers
│   └── utils/          # Utility scripts
│
├── install.sh          # Main cross-platform installer
├── .stow-local-ignore  # Files to ignore during stowing
└── .stowrc             # Stow configuration
```

---

## Quick Start

### First Time Setup

#### On macOS:
```bash
# Clone the repository
git clone https://github.com/iampramodphuyal/dotfiles.git ~/dotfiles

# Run the installer
cd ~/dotfiles
./install.sh
```

#### On Linux:
```bash
# Clone the repository
git clone git@github.com:iampramodphuyal/dotfiles.git ~/dotfiles

# Run the installer
cd ~/dotfiles
./install.sh
```

The installer will:
1. ✅ Detect your platform (macOS or Linux)
2. ✅ Install prerequisites (Homebrew on macOS, Stow on Linux)
3. ✅ Backup existing configurations
4. ✅ Symlink common configs
5. ✅ Symlink platform-specific configs
6. ✅ Optionally install packages
7. ✅ Set up Oh My Zsh, zsh plugins, and TPM

---

## Manual Installation

If you prefer manual control:

### 1. Install GNU Stow

**macOS:**
```bash
brew install stow
```

**Arch Linux:**
```bash
sudo pacman -S stow
```

**Fedora:**
```bash
sudo dnf install stow
```

### 2. Symlink Configurations

```bash
cd ~/dotfiles

# Install common configs (both platforms)
stow -d . -t ~ common

# Install platform-specific configs
# On macOS:
stow -d . -t ~ macos

# On Linux:
stow -d . -t ~ linux
```

### 3. Install Packages

**macOS:**
```bash
brew bundle --file=~/dotfiles/macos/Brewfile
```

**Linux (Arch with Hyprland):**
```bash
bash ~/dotfiles/scripts/linux/hypr-installer.sh
```

**Linux (Fedora):**
```bash
bash ~/dotfiles/scripts/linux/fedora-installer.sh
```

---

## Platform-Specific Features

### Common (Both Platforms)
- Zsh with Oh My Zsh
- Starship prompt
- Neovim with NvChad
- Kitty & Ghostty terminals
- Tmux with Catppuccin theme
- Git configurations
- Shell aliases and utilities

### Linux-Only
- Hyprland window manager
- Waybar status bar
- Rofi application launcher
- Swaync notification center
- Hyprlock lock screen
- Hyprpaper wallpaper manager
- Wayland clipboard tools

### macOS-Only
- Homebrew package management
- macOS system preferences automation
- Native macOS window management

---

## Platform Detection

The `.zshrc` and `.tmux.conf` files automatically detect your platform and adjust:

### macOS Adjustments:
- Homebrew paths (ARM: `/opt/homebrew`, Intel: `/usr/local`)
- macOS-specific aliases (`ls -G`, `update` for brew)
- Clipboard: `pbcopy` / `pbpaste`
- Plugins: `macos`, `brew`

### Linux Adjustments:
- Rofi scripts in PATH
- Wayland clipboard aliases (`pbcopy` → `wl-copy`)
- Plugins: `dnf`, `systemd`

---

## Updating

### Update Dotfiles from GitHub
```bash
cd ~/dotfiles
git pull origin main
```

### Update Packages

**macOS:**
```bash
brew update && brew upgrade && brew cleanup
# Or use the alias:
update
```

**Arch Linux:**
```bash
yay -Syu
# Or use the updater script:
bash ~/dotfiles/scripts/utils/arch-updater.sh
```

**Fedora:**
```bash
sudo dnf upgrade
```

---

## Making Changes

All configs are symlinked from `~/dotfiles/` to your home directory:

1. **Edit files** in `~/dotfiles/`
2. Changes take effect **immediately** (or restart the app)
3. **Commit your changes**:
   ```bash
   cd ~/dotfiles
   git add .
   git commit -m "Your commit message"
   git push origin main
   ```

---

## Switching Between Platforms

When moving from Linux to macOS or vice versa:

1. **Pull latest changes:**
   ```bash
   cd ~/dotfiles
   git pull
   ```

2. **Run the installer:**
   ```bash
   ./install.sh
   ```

The installer detects your platform and installs the appropriate configs automatically.

---

## Uninstallation

To remove symlinks:

```bash
cd ~/dotfiles

# Remove common configs
stow -D common

# Remove platform-specific configs
stow -D macos  # on macOS
stow -D linux  # on Linux
```

This only removes symlinks; your dotfiles directory remains intact.

---

## Troubleshooting

### Stow Conflicts

If stow reports conflicts with existing files:

```bash
# Move conflicting files
mv ~/.zshrc ~/.zshrc.backup
mv ~/.tmux.conf ~/.tmux.conf.backup

# Re-run stow
cd ~/dotfiles
stow -d . -t ~ common
```

### Missing Zsh Plugins

Install manually:

```bash
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
```

### Tmux Plugins Not Loading

```bash
# Install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# In tmux, press: Ctrl+Space + I (capital i)
```

### macOS Homebrew Path Issues

For ARM Macs, ensure Homebrew is in PATH:

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Linux Wayland Clipboard

If clipboard doesn't work:

```bash
# Wayland
sudo pacman -S wl-clipboard   # Arch
sudo dnf install wl-clipboard # Fedora

# X11
sudo pacman -S xclip          # Arch
sudo dnf install xclip        # Fedora
```

---

## Important Files

### Configuration Files
- `common/.zshrc` - Shell configuration with platform conditionals
- `common/.tmux.conf` - Tmux configuration with clipboard detection
- `common/.config/nvim/` - Neovim with NvChad
- `common/.config/kitty/` - Kitty terminal config
- `common/.config/starship.toml` - Starship prompt

### Platform-Specific
- `macos/Brewfile` - Homebrew packages for macOS
- `macos/.macos` - macOS system preferences
- `linux/.config/hypr/` - Hyprland configuration
- `linux/.config/waybar/` - Waybar status bar

### Installation
- `install.sh` - Main cross-platform installer
- `scripts/linux/hypr-installer.sh` - Arch Hyprland setup
- `scripts/linux/fedora-installer.sh` - Fedora setup

---

## Dependencies

### Common (Both Platforms)
- Git
- Zsh
- Tmux
- Neovim
- Kitty or Ghostty
- Starship
- Fzf
- Zoxide
- GNU Stow

### Linux-Specific (Hyprland)
- Hyprland
- Waybar
- Rofi
- Hyprlock
- Hyprpaper
- Swaync
- Dunst
- wl-clipboard (Wayland) or xclip (X11)

### macOS-Specific
- Homebrew
- Command Line Tools (`xcode-select --install`)

---

## Testing the Setup

### After Installation

1. **Restart your terminal** or run:
   ```bash
   source ~/.zshrc
   ```

2. **Test Oh My Zsh plugins:**
   ```bash
   # Should show suggestions as you type
   # Should have syntax highlighting
   ```

3. **Test Tmux:**
   ```bash
   tmux
   # Press Ctrl+Space + I to install plugins
   ```

4. **Test Neovim:**
   ```bash
   nvim
   # NvChad should load
   ```

---

## macOS System Preferences

To apply macOS system preferences:

```bash
bash ~/dotfiles/macos/.macos
```

This configures:
- Fast key repeat
- Show hidden files in Finder
- Finder preferences (status bar, path bar, search scope)
- Dock settings (size, autohide)
- Safari developer tools
- Screenshot settings
- Activity Monitor preferences

**Note**: Some preferences require logout/restart to take effect.

---

## Additional Resources

### Documentation
- Main README: `~/dotfiles/README.md`
- This guide: `~/dotfiles/claude.md`

### Repository
- GitHub: https://github.com/iampramodphuyal/dotfiles
- Latest commit: e89567b

### Credits
- Window Manager: [Hyprland](https://hyprland.org/)
- Terminal: [Kitty](https://sw.kovidgoyal.net/kitty/)
- Editor: [Neovim](https://neovim.io/) with [NvChad](https://nvchad.com/)
- Shell: [Zsh](https://www.zsh.org/) with [Oh My Zsh](https://ohmyz.sh/)
- Prompt: [Starship](https://starship.rs/)
- Theme: [Catppuccin](https://github.com/catppuccin)
- Dotfile Management: [GNU Stow](https://www.gnu.org/software/stow/)

---

## Quick Reference

### Essential Commands

```bash
# Clone repository
git clone https://github.com/iampramodphuyal/dotfiles.git ~/dotfiles

# Install everything
cd ~/dotfiles && ./install.sh

# Update dotfiles
cd ~/dotfiles && git pull

# Update packages (macOS)
brew update && brew upgrade && brew cleanup

# Update packages (Arch)
yay -Syu

# Commit changes
cd ~/dotfiles && git add . && git commit -m "message" && git push

# Uninstall symlinks
cd ~/dotfiles && stow -D common && stow -D macos  # or linux
```

---

## Support

If you encounter issues:
1. Check the Troubleshooting section above
2. Review the main README.md
3. Check GitHub issues: https://github.com/iampramodphuyal/dotfiles/issues

---

**Last Updated**: December 11, 2024
**Reorganization Complete**: ✅
