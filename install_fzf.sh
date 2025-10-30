#!/usr/bin/env bash
# =============================================================================
# FZF Installation Script
# =============================================================================
# Installs the latest fzf binary to ~/.local/bin
# Idempotent: only installs if missing or outdated
# The apt version of fzf is often outdated and incompatible with latest shell scripts

set -e

FZF_BIN="$HOME/.local/bin/fzf"
MIN_VERSION="0.50.0"  # Minimum compatible version for antidote fzf scripts

# Create ~/.local/bin if it doesn't exist
mkdir -p "$HOME/.local/bin"

# Check if fzf exists and get version
if [ -f "$FZF_BIN" ]; then
    CURRENT_VERSION=$($FZF_BIN --version 2>/dev/null | cut -d' ' -f1 || echo "0.0.0")
    echo "Current fzf version: $CURRENT_VERSION"
else
    CURRENT_VERSION="0.0.0"
    echo "fzf not found in ~/.local/bin"
fi

# Simple version comparison: if current version >= min version, skip install
if [ "$CURRENT_VERSION" != "0.0.0" ] && \
   [ "$(printf '%s\n' "$MIN_VERSION" "$CURRENT_VERSION" | sort -V | head -n1)" = "$MIN_VERSION" ]; then
    echo "✓ fzf is up to date ($CURRENT_VERSION >= $MIN_VERSION)"
    exit 0
fi

echo "Installing latest fzf..."

# Download and install latest fzf
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"

# Detect architecture
ARCH=$(uname -m)
case $ARCH in
    x86_64)  FZF_ARCH="amd64" ;;
    aarch64) FZF_ARCH="arm64" ;;
    armv7l)  FZF_ARCH="armv7" ;;
    *)
        echo "Error: Unsupported architecture: $ARCH"
        echo "Please install fzf manually from: https://github.com/junegunn/fzf"
        exit 1
        ;;
esac

# Get latest release URL from GitHub API
echo "Fetching latest fzf release..."
DOWNLOAD_URL=$(curl -s https://api.github.com/repos/junegunn/fzf/releases/latest | \
    grep "browser_download_url.*linux_${FZF_ARCH}.tar.gz\"" | \
    cut -d '"' -f 4)

if [ -z "$DOWNLOAD_URL" ]; then
    echo "Error: Could not find download URL for linux_${FZF_ARCH}"
    exit 1
fi

echo "Downloading fzf from: $DOWNLOAD_URL"
if ! curl -fsSL "$DOWNLOAD_URL" -o fzf.tar.gz; then
    echo "Error: Failed to download fzf"
    exit 1
fi

tar -xzf fzf.tar.gz
mv fzf "$FZF_BIN"
chmod +x "$FZF_BIN"

# Cleanup
cd - > /dev/null
rm -rf "$TMP_DIR"

NEW_VERSION=$($FZF_BIN --version | cut -d' ' -f1)
echo "✓ Successfully installed fzf $NEW_VERSION to ~/.local/bin/fzf"
