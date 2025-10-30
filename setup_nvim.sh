#!/bin/bash

# Setup script for Neovim with LazyVim
# This script installs Neovim 0.9.0+ from the unstable PPA
# Idempotent: skips installation if neovim is already installed

set -e  # Exit on error

# Check if neovim is already installed
if command -v nvim &> /dev/null; then
    echo "✓ Neovim already installed: $(nvim --version | head -n 1)"
    exit 0
fi

echo "======================================"
echo "Neovim + LazyVim Setup"
echo "======================================"
echo ""

# Install Neovim 0.11+ from unstable PPA
echo "Installing Neovim from unstable PPA..."
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install -y neovim

# Verify installation
nvim --version | head -n 1
echo "✓ Neovim installed successfully"
echo ""

# Display usage instructions
echo "======================================"
echo "Setup Complete!"
echo "======================================"
echo ""
echo "LazyVim is configured to auto-install plugins on first run."
echo ""
echo "To get started:"
echo "  1. Create your Neovim config directory (if needed):"
echo "     mkdir -p ~/.config/nvim"
echo ""
echo "  2. Clone or copy your LazyVim config to ~/.config/nvim"
echo ""
echo "  3. Launch Neovim:"
echo "     nvim"
echo ""
echo "  4. LazyVim will automatically download and install all plugins"
echo ""
echo "For more information on LazyVim, visit:"
echo "  https://www.lazyvim.org"
echo ""
