#!/bin/bash
# Install VS Code extensions from extensions.txt

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v code &> /dev/null; then
    echo "Error: VS Code CLI 'code' not found"
    exit 1
fi

echo "Installing VS Code extensions..."
while IFS= read -r ext; do
    echo "  Installing $ext..."
    code --install-extension "$ext" --force 2>/dev/null
done < "$SCRIPT_DIR/extensions.txt"
echo "Done."
