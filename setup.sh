#!/bin/bash

# Development Environment Setup Script
# Converts from Ansible to pure bash

set -e

echo "🚀 Starting Development Environment Setup..."

# Detect OS
OS=""
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
    echo "📦 Detected Linux system"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    echo "🍎 Detected macOS system"
else
    echo "❌ Unsupported operating system: $OSTYPE"
    exit 1
fi

# Create scripts directory if it doesn't exist
mkdir -p scripts

# Run setup scripts in order
echo "🔧 Running core system setup..."
./scripts/setup-core.sh "$OS"

echo "📦 Installing packages..."
./scripts/setup-packages.sh "$OS"

echo "🌐 Setting up Node.js and development tools..."
./scripts/setup-nodejs.sh

echo "🔧 Configuring Git..."
./scripts/setup-git.sh

echo "💻 Setting up VS Code..."
./scripts/setup-vscode.sh "$OS"

echo "🐚 Configuring shell..."
./scripts/setup-shell.sh

if [[ "$OS" == "macos" ]]; then
    echo "🍎 Configuring macOS preferences..."
    ./scripts/setup-macos.sh
fi

echo "🌐 Configuring hosts file..."
./scripts/setup-hosts.sh "$OS"

echo "✅ Development environment setup complete!"
echo "🔄 Please restart your terminal or run 'source ~/.bashrc' to apply changes" 