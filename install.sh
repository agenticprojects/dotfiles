#!/bin/bash

# Dotfiles installation script
# This script sets up the development environment and installs dotfiles

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Xcode command line tools are installed
check_xcode_tools() {
    print_status "Checking for Xcode command line tools..."
    
    if xcode-select --print-path &> /dev/null; then
        print_status "Xcode command line tools are already installed at $(xcode-select --print-path)"
        return 0
    else
        print_warning "Xcode command line tools are not installed"
        return 1
    fi
}

# Install Xcode command line tools
install_xcode_tools() {
    print_status "Installing Xcode command line tools..."
    
    # Trigger the installation
    xcode-select --install
    
    print_status "Please complete the Xcode command line tools installation in the dialog that appeared."
    print_status "Press any key to continue once the installation is complete..."
    read -n 1 -s
    
    # Verify installation
    if xcode-select --print-path &> /dev/null; then
        print_status "Xcode command line tools installation verified!"
    else
        print_error "Xcode command line tools installation failed. Please try again manually."
        exit 1
    fi
}

# Check if Homebrew is installed
check_homebrew() {
    print_status "Checking for Homebrew..."
    
    if command -v brew &> /dev/null; then
        print_status "Homebrew is already installed at $(command -v brew)"
        return 0
    else
        print_warning "Homebrew is not installed"
        return 1
    fi
}

# Install Homebrew
install_homebrew() {
    print_status "Installing Homebrew..."
    
    # Download and run the official Homebrew installation script
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for current session
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        # Apple Silicon Mac
        eval "$(/opt/homebrew/bin/brew shellenv)"
        print_status "Added Homebrew to PATH (Apple Silicon)"
    elif [[ -f "/usr/local/bin/brew" ]]; then
        # Intel Mac
        eval "$(/usr/local/bin/brew shellenv)"
        print_status "Added Homebrew to PATH (Intel)"
    fi
    
    # Verify installation
    if command -v brew &> /dev/null; then
        print_status "Homebrew installation verified!"
    else
        print_error "Homebrew installation failed. Please try again manually."
        exit 1
    fi
}

# Install Homebrew dependencies
install_homebrew_deps() {
    print_status "Installing Homebrew dependencies..."
    brew bundle
}

# Main installation function
main() {
    print_status "Starting dotfiles installation..."
    
    # Check and install Xcode command line tools if needed
    if ! check_xcode_tools; then
        install_xcode_tools
    fi
    
    # Check and install Homebrew if needed
    if ! check_homebrew; then
        install_homebrew
    fi
    
    # Install Homebrew dependencies
    install_homebrew_deps
    
    print_status "Installation complete!"
    print_status "You can now use 'stow <package>' to install specific configurations."
    print_status "Example: stow zsh"
}

# Run main function
main "$@"