#!/usr/bin/env bash
# filepath: install.sh
# Neovim Configuration Installation Script

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper functions
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

check_command() {
    if command -v "$1" &> /dev/null; then
        print_info "$1 is already installed"
        return 0
    else
        print_warn "$1 is not installed"
        return 1
    fi
}

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ -f /etc/debian_version ]; then
            OS="debian"
        elif [ -f /etc/redhat-release ]; then
            OS="redhat"
        elif [ -f /etc/arch-release ]; then
            OS="arch"
        else
            OS="linux"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    else
        OS="unknown"
    fi
    print_info "Detected OS: $OS"
}

# Install dependencies based on OS
install_dependencies() {
    print_info "Installing dependencies..."
    
    case $OS in
        macos)
            # Check if Homebrew is installed
            if ! check_command brew; then
                print_info "Installing Homebrew..."
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            fi
            
            # Install dependencies
            brew install neovim git gcc make cmake python3 node npm
            
            # Install Java 21 for jdtls
            if ! check_command java; then
                print_info "Installing OpenJDK 21..."
                brew install openjdk@21
                echo 'export JAVA_HOME="/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"' >> ~/.zshrc
                export JAVA_HOME="/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"
            fi
            ;;
            
        debian)
            sudo apt update
            sudo apt install -y neovim git gcc g++ make cmake python3 python3-pip \
                nodejs npm ripgrep fd-find curl wget unzip
            
            # Install yarn
            sudo npm install -g yarn
            
            # Install Java 21
            if ! check_command java; then
                sudo apt install -y openjdk-21-jdk
            fi
            ;;
        *)
            print_error "Unsupported OS. Please install dependencies manually:"
            echo "  - Neovim >= 0.9"
            echo "  - git, build-essential, unzip, curl,"
            echo "  - python3-venv, python3-pip"
            echo "  - npm"
            echo "  - Java 21+ (for jdtls)"
            exit 1
            ;;
    esac
}

# Verify Neovim version
check_neovim_version() {
    print_info "Checking Neovim version..."
    if ! check_command nvim; then
        print_error "Neovim is not installed!"
        exit 1
    fi
    
    nvim_version=$(nvim --version | head -n1 | grep -oP 'v\K[0-9]+\.[0-9]+')
    required_version="0.9"
    
    if [ "$(printf '%s\n' "$required_version" "$nvim_version" | sort -V | head -n1)" = "$required_version" ]; then
        print_info "Neovim version $nvim_version meets requirements (>= $required_version)"
    else
        print_error "Neovim version $nvim_version is too old. Please upgrade to >= $required_version"
        exit 1
    fi
}

# Backup existing configuration
backup_existing_config() {
    local nvim_config_dir="$HOME/.config/nvim"
    local backup_dir="$HOME/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)"
    
    if [ -d "$nvim_config_dir" ]; then
        print_warn "Existing Neovim configuration found"
        read -p "Do you want to backup existing config? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            print_info "Backing up to $backup_dir"
            mv "$nvim_config_dir" "$backup_dir"
        else
            print_warn "Removing existing configuration..."
            rm -rf "$nvim_config_dir"
        fi
    fi
}

# Install Neovim configuration
install_config() {
    local nvim_config_dir="$HOME/.config/nvim"
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    print_info "Installing Neovim configuration..."
    
    # Create .config directory if it doesn't exist
    mkdir -p "$HOME/.config"
    
    # Copy configuration files
    if [ "$script_dir" = "$nvim_config_dir" ]; then
        print_info "Already in correct location"
    else
        print_info "Copying configuration to $nvim_config_dir"
        cp -r "$script_dir" "$nvim_config_dir"
    fi
}

# Install Python packages
install_python_packages() {
    print_info "Installing Python packages..."
    python3 -m pip install --user --upgrade pynvim black isort ruff
}

# Post-installation message
print_post_install() {
    echo
    print_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    print_info "Installation complete! 🎉"
    print_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo
    echo "Next steps:"
    echo "  1. Launch Neovim: nvim"
    echo "  2. Lazy.nvim will automatically install plugins"
    echo "  3. Run :checkhealth to verify installation"
    echo "  4. Run :Mason to manage LSP servers"
    echo
    echo "Optional:"
    echo "  - Set JAVA_HOME if not already set (for jdtls)"
    echo "  - Install additional LSP servers via :Mason"
    echo
    print_info "For more information, see the README.md"
}

# Main installation flow
main() {
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "  Neovim Configuration Installer"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo
    
    detect_os
    
    # Ask for dependency installation
    read -p "Install/update dependencies? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        install_dependencies
    fi
    
    check_neovim_version
    backup_existing_config
    install_config
    install_python_packages
    
    print_post_install
}

# Run main function
main