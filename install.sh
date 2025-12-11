#!/usr/bin/env bash

# Dotfiles Installation Script
# Cross-platform support for Linux (Arch/Fedora) and macOS

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Detect platform
detect_platform() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        PLATFORM="macos"
        print_info "Detected macOS"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        PLATFORM="linux"

        # Detect Linux distribution
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            DISTRO=$ID
            print_info "Detected Linux ($DISTRO)"
        else
            print_error "Cannot detect Linux distribution"
            exit 1
        fi
    else
        print_error "Unsupported operating system: $OSTYPE"
        exit 1
    fi
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install prerequisites
install_prerequisites() {
    print_info "Installing prerequisites..."

    # Check for git (required for cloning plugins later)
    if ! command_exists git; then
        print_error "Git is not installed. Please install git and try again."
        exit 1
    fi

    if [[ "$PLATFORM" == "macos" ]]; then
        # Check for Homebrew
        if ! command_exists brew; then
            print_info "Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

            # Add Homebrew to PATH for this script
            if [[ $(uname -m) == "arm64" ]]; then
                eval "$(/opt/homebrew/bin/brew shellenv)"
            else
                eval "$(/usr/local/bin/brew shellenv)"
            fi
        fi

        # Check for stow
        if ! command_exists stow; then
            print_info "Installing GNU Stow..."
            brew install stow
        fi

    elif [[ "$PLATFORM" == "linux" ]]; then
        if ! command_exists stow; then
            print_info "Installing GNU Stow..."

            if [[ "$DISTRO" == "arch" ]] || [[ "$DISTRO" == "manjaro" ]]; then
                sudo pacman -S --noconfirm stow
            elif [[ "$DISTRO" == "fedora" ]]; then
                sudo dnf install -y stow
            elif [[ "$DISTRO" == "ubuntu" ]] || [[ "$DISTRO" == "debian" ]]; then
                sudo apt-get update && sudo apt-get install -y stow
            fi
        fi
    fi

    print_success "Prerequisites installed"
}

# Backup existing configs
backup_configs() {
    print_info "Backing up existing configurations..."

    BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$BACKUP_DIR"

    # List of files to backup
    FILES_TO_BACKUP=(
        ".zshrc"
        ".tmux.conf"
        ".prettierrc"
        ".custom_keybindings"
    )

    for file in "${FILES_TO_BACKUP[@]}"; do
        if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
            print_info "Backing up $file"
            cp "$HOME/$file" "$BACKUP_DIR/"
        fi
    done

    if [ "$(ls -A "$BACKUP_DIR")" ]; then
        print_success "Backup created at $BACKUP_DIR"
    else
        rmdir "$BACKUP_DIR"
        print_info "No existing configs to backup"
    fi
}

# Install common configs
install_common() {
    print_info "Installing common configurations..."

    cd "$(dirname "$0")"

    # Check for conflicts and handle them
    if ! stow -n -d . -t "$HOME" common 2>/dev/null; then
        print_warning "Stow conflicts detected. Attempting to resolve..."

        # Use restow to handle existing symlinks
        if stow -R -d . -t "$HOME" common 2>/dev/null; then
            print_success "Conflicts resolved with restow"
        else
            print_error "Failed to install common configs due to conflicts."
            print_info "Please manually remove conflicting files or use: stow -D common && stow common"
            return 1
        fi
    else
        stow -d . -t "$HOME" common
    fi

    print_success "Common configs installed"
}

# Install platform-specific configs
install_platform_specific() {
    print_info "Installing $PLATFORM-specific configurations..."

    cd "$(dirname "$0")"

    # Check for conflicts and handle them
    if ! stow -n -d . -t "$HOME" "$PLATFORM" 2>/dev/null; then
        print_warning "Stow conflicts detected. Attempting to resolve..."

        # Use restow to handle existing symlinks
        if stow -R -d . -t "$HOME" "$PLATFORM" 2>/dev/null; then
            print_success "Conflicts resolved with restow"
        else
            print_error "Failed to install $PLATFORM configs due to conflicts."
            print_info "Please manually remove conflicting files or use: stow -D $PLATFORM && stow $PLATFORM"
            return 1
        fi
    else
        stow -d . -t "$HOME" "$PLATFORM"
    fi

    print_success "$PLATFORM configs installed"
}

# Install packages
install_packages() {
    print_info "Installing packages..."

    if [[ "$PLATFORM" == "macos" ]]; then
        if [ -f "macos/Brewfile" ]; then
            print_info "Installing packages from Brewfile..."
            brew bundle --file=macos/Brewfile
            print_success "Packages installed via Homebrew"
        fi

    elif [[ "$PLATFORM" == "linux" ]]; then
        # Check for existing installer scripts
        if [[ "$DISTRO" == "arch" ]] && [ -f "scripts/linux/hypr-installer.sh" ]; then
            read -p "Run Hyprland installer for Arch? (y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                bash scripts/linux/hypr-installer.sh
            fi
        elif [[ "$DISTRO" == "fedora" ]] && [ -f "scripts/linux/fedora-installer.sh" ]; then
            read -p "Run Fedora installer? (y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                bash scripts/linux/fedora-installer.sh
            fi
        fi
    fi
}

# Post-installation setup
post_install() {
    print_info "Running post-installation setup..."

    # Install oh-my-zsh if not present
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        print_info "Installing Oh My Zsh..."
        RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

        if [ -d "$HOME/.oh-my-zsh" ]; then
            print_success "Oh My Zsh installed"
        else
            print_warning "Oh My Zsh installation may have failed"
        fi
    fi

    # Install zsh plugins
    if [ -d "$HOME/.oh-my-zsh/custom/plugins" ]; then
        if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
            print_info "Installing zsh-autosuggestions..."
            if git clone https://github.com/zsh-users/zsh-autosuggestions \
                "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" 2>/dev/null; then
                print_success "zsh-autosuggestions installed"
            else
                print_warning "Failed to install zsh-autosuggestions"
            fi
        fi

        if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
            print_info "Installing zsh-syntax-highlighting..."
            if git clone https://github.com/zsh-users/zsh-syntax-highlighting \
                "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" 2>/dev/null; then
                print_success "zsh-syntax-highlighting installed"
            else
                print_warning "Failed to install zsh-syntax-highlighting"
            fi
        fi
    fi

    # Install tmux plugin manager
    if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
        print_info "Installing TPM (Tmux Plugin Manager)..."
        if git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm" 2>/dev/null; then
            print_success "TPM installed"
            print_info "Run 'prefix + I' in tmux to install plugins"
        else
            print_warning "Failed to install TPM"
        fi
    fi

    # macOS-specific post-install
    if [[ "$PLATFORM" == "macos" ]]; then
        read -p "Apply macOS system preferences? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            if [ -f "macos/.macos" ]; then
                bash macos/.macos
            fi
        fi
    fi

    print_success "Post-installation complete"
}

# Main installation flow
main() {
    echo ""
    echo "╔════════════════════════════════════════╗"
    echo "║   Dotfiles Installation Script         ║"
    echo "║   Cross-platform Setup                 ║"
    echo "╚════════════════════════════════════════╝"
    echo ""

    detect_platform
    echo ""

    print_warning "This will symlink dotfiles to your home directory."
    read -p "Continue? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Installation cancelled"
        exit 0
    fi

    echo ""
    install_prerequisites
    echo ""
    backup_configs
    echo ""
    install_common
    echo ""
    install_platform_specific
    echo ""

    read -p "Install packages? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        install_packages
    fi

    echo ""
    post_install
    echo ""

    print_success "═════════════════════════════════════════"
    print_success "Installation complete! 🎉"
    print_success "═════════════════════════════════════════"
    echo ""
    print_info "Next steps:"
    echo "  1. Restart your terminal or run: source ~/.zshrc"
    echo "  2. In tmux, press 'prefix + I' to install plugins"
    if [[ "$PLATFORM" == "macos" ]]; then
        echo "  3. Configure system preferences with: bash macos/.macos"
    fi
    echo ""
}

# Run main function
main "$@"
