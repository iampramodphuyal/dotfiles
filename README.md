# Dotfiles

Cross-platform dotfiles for **Linux** (Arch/Fedora) and **macOS**, managed with GNU Stow.

![Platforms](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS-blue)
![Shell](https://img.shields.io/badge/Shell-Zsh-green)
![WM](https://img.shields.io/badge/WM-Hyprland-orange)

## Features

- **Cross-Platform**: Seamlessly works on both Linux and macOS
- **Modular Structure**: Organized into `common/`, `linux/`, and `macos/` directories
- **Automatic Setup**: Smart installer detects your platform and configures accordingly
- **Hyprland**: Complete Hyprland window manager setup for Linux
- **Shell**: Zsh with Oh My Zsh, Starship prompt, and useful plugins
- **Editor**: Neovim with NvChad framework
- **Terminal**: Kitty and Ghostty configurations
- **Multiplexer**: Tmux with Catppuccin theme and vim bindings

## Repository Structure

```
dotfiles/
├── common/              # Configs that work on both platforms
│   ├── .config/
│   │   ├── nvim/       # Neovim (NvChad)
│   │   ├── kitty/      # Kitty terminal
│   │   ├── ghostty/    # Ghostty terminal
│   │   └── starship.toml
│   ├── .zshrc          # Shell config with platform conditionals
│   ├── .tmux.conf      # Tmux config with platform conditionals
│   ├── alias/          # Shell aliases and utilities
│   └── vscode/         # VS Code settings
│
├── linux/              # Linux-specific (Hyprland, Wayland)
│   ├── .config/
│   │   ├── hypr/       # Hyprland window manager
│   │   ├── waybar/     # Status bar
│   │   ├── rofi/       # Application launcher
│   │   ├── swaync/     # Notification center
│   │   └── ...
│   ├── customs/        # Custom scripts for Hyprland
│   └── .resources/     # Additional resources
│
├── macos/              # macOS-specific
│   ├── Brewfile        # Homebrew packages
│   └── .macos          # macOS system preferences
│
├── scripts/            # Installation scripts
│   ├── linux/          # Linux installer scripts
│   └── macos/          # macOS installer scripts
│
└── install.sh          # Main installation script
```

## Quick Start

### Automated Installation (Recommended)

```bash
# Clone the repository
git clone https://github.com/iampramodphuyal/dotfiles.git ~/dotfiles

# Run the installer
cd ~/dotfiles
./install.sh
```

The installer will:
1. Detect your platform (Linux/macOS)
2. Install prerequisites (Homebrew on macOS, Stow, etc.)
3. Backup existing configurations
4. Symlink common configs
5. Symlink platform-specific configs
6. Optionally install packages
7. Set up Oh My Zsh and plugins

### Manual Installation

If you prefer manual control:

```bash
# Install GNU Stow
# macOS:
brew install stow

# Arch Linux:
sudo pacman -S stow

# Fedora:
sudo dnf install stow

# Install common configs
cd ~/dotfiles
stow -d . -t ~ common

# Install platform-specific configs
# On macOS:
stow -d . -t ~ macos

# On Linux:
stow -d . -t ~ linux
```

## Platform-Specific Setup

### macOS

#### Prerequisites
- **Homebrew**: Automatically installed by `install.sh`
- **Command Line Tools**: `xcode-select --install`

#### Install Packages
```bash
# Install all packages from Brewfile
brew bundle --file=~/dotfiles/macos/Brewfile
```

#### Apply System Preferences
```bash
# Configures keyboard, Finder, Dock, etc.
bash ~/dotfiles/macos/.macos
```

**Note**: Some preferences require logout/restart to take effect.

### Linux

#### Arch Linux (Hyprland)

For a complete Hyprland setup:
```bash
bash ~/dotfiles/scripts/linux/hypr-installer.sh
```

Manual installation:
```bash
# Using yay
yay -S hyprland hyprpaper waybar rofi-wayland \
       hyprlock swaync dunst kitty neovim \
       starship zoxide fzf bat

# Using pacman
sudo pacman -S git stow zsh tmux neovim kitty
```

#### Fedora

```bash
bash ~/dotfiles/scripts/linux/fedora-installer.sh
```

Or manually:
```bash
sudo dnf install zsh tmux neovim kitty starship \
                 zoxide fzf bat git stow
```

## What's Included

### Shell Configuration

**Zsh** with platform-specific configurations:
- **Oh My Zsh**: Plugin framework
- **Starship**: Cross-shell prompt
- **Plugins**: git, zsh-autosuggestions, zsh-syntax-highlighting, vi-mode, zoxide, fzf
- **Platform Detection**: Automatically adjusts PATH, aliases, and plugins

**Platform-specific features:**
- **macOS**: Homebrew paths (ARM/Intel), `brew` plugin, macOS-specific aliases
- **Linux**: Rofi scripts, Wayland clipboard (`pbcopy`/`pbpaste` aliases), systemd plugin

### Terminal

- **Kitty**: GPU-accelerated terminal with Catppuccin theme
- **Ghostty**: Alternative terminal emulator
- **Tmux**: Terminal multiplexer with:
  - Vim-style navigation
  - Catppuccin theme
  - Plugin manager (TPM)
  - Platform-specific clipboard integration
  - Custom popup terminal (Ctrl+Alt+I)

### Editor

**Neovim** with NvChad:
- LSP support via Mason
- Syntax highlighting with Treesitter
- File explorer, fuzzy finder
- Git integration
- Tmux navigation integration

### Linux-Only (Hyprland Setup)

- **Hyprland**: Wayland window manager
- **Waybar**: Status bar with system info
- **Rofi**: Application launcher with 160+ themes
- **Swaync**: Notification center
- **Hyprlock**: Lock screen
- **Hyprpaper**: Wallpaper manager

### macOS-Only

- **Brewfile**: Package management via Homebrew
- **.macos**: System preferences script:
  - Fast key repeat
  - Show hidden files
  - Finder preferences
  - Dock customization
  - Safari developer tools
  - Screenshot settings

## Common Aliases

```bash
# Navigation
cd         # Enhanced with zoxide

# File operations
ls         # Colorized (platform-specific)
bat        # Better cat with syntax highlighting
eza        # Better ls (modern replacement)

# Git
gst        # git status
gc         # git commit
gp         # git push
gl         # git pull
lazygit    # TUI for git

# Clipboard (Linux)
pbcopy     # Wayland/X11 clipboard copy
pbpaste    # Wayland/X11 clipboard paste

# Utilities
icat       # View images in kitty
myip       # Check IP information
dot        # Edit dotfiles
```

See `common/alias/alias` for the complete list.

## Configuration Files

### Location Map

| Config | Location | Platform |
|--------|----------|----------|
| Zsh | `~/.zshrc` | Both |
| Tmux | `~/.tmux.conf` | Both |
| Neovim | `~/.config/nvim/` | Both |
| Kitty | `~/.config/kitty/` | Both |
| Starship | `~/.config/starship.toml` | Both |
| Hyprland | `~/.config/hypr/` | Linux |
| Waybar | `~/.config/waybar/` | Linux |
| Rofi | `~/.config/rofi/` | Linux |

### Customization

All configs are symlinked. To customize:
1. Edit files in `~/dotfiles/`
2. Changes take effect immediately (or restart the app)
3. Commit changes: `cd ~/dotfiles && git add . && git commit`

## Updating

### Update Dotfiles
```bash
cd ~/dotfiles
git pull
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

## Uninstallation

To remove symlinks:
```bash
cd ~/dotfiles

# Remove common configs
stow -D common

# Remove platform-specific configs
stow -D macos  # or stow -D linux
```

This only removes symlinks; your dotfiles directory remains intact.

## Troubleshooting

### Stow Conflicts

If stow reports conflicts:
```bash
# Move conflicting files
mv ~/.zshrc ~/.zshrc.backup
mv ~/.tmux.conf ~/.tmux.conf.backup

# Re-run stow
stow -d ~/dotfiles -t ~ common
```

### Missing Zsh Plugins

```bash
# Install manually
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

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

### Linux Wayland Issues

If clipboard doesn't work:
```bash
# Wayland
sudo pacman -S wl-clipboard   # Arch
sudo dnf install wl-clipboard # Fedora

# X11
sudo pacman -S xclip          # Arch
sudo dnf install xclip        # Fedora
```

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
- wl-clipboard

### macOS-Specific
- Homebrew
- Command Line Tools

See `macos/Brewfile` or `scripts/linux/` for complete lists.

## Screenshots

### Linux (Hyprland)
- Tiling window manager with Waybar
- Rofi application launcher
- Custom themes and wallpapers

### macOS
- Same terminal and editor experience
- Native window management
- Homebrew package management

## Credits

- **Window Manager**: [Hyprland](https://hyprland.org/)
- **Terminal**: [Kitty](https://sw.kovidgoyal.net/kitty/)
- **Editor**: [Neovim](https://neovim.io/) with [NvChad](https://nvchad.com/)
- **Shell**: [Zsh](https://www.zsh.org/) with [Oh My Zsh](https://ohmyz.sh/)
- **Prompt**: [Starship](https://starship.rs/)
- **Theme**: [Catppuccin](https://github.com/catppuccin)
- **Dotfile Management**: [GNU Stow](https://www.gnu.org/software/stow/)

## License

These are personal dotfiles. Feel free to use, modify, and share.

## Contributing

If you find issues or have suggestions:
1. Open an issue
2. Submit a pull request
3. Share your customizations

---

**Maintained by**: [@iampramodphuyal](https://github.com/iampramodphuyal)

**Repository**: [dotfiles](https://github.com/iampramodphuyal/dotfiles)
