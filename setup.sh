#!/bin/bash

set -e

echo "🚀 Setting up development environment with Ansible..."

# Clone the devtools repository if it doesn't exist
DEVTOOLS_DIR="$HOME/devtools"
if [ ! -d "$DEVTOOLS_DIR" ]; then
    echo "📦 Cloning devtools repository..."
    git clone https://github.com/brandonapol/devtools.git "$DEVTOOLS_DIR"
    if [ $? -ne 0 ]; then
        echo "❌ Failed to clone repository. Please check your internet connection and try again."
        exit 1
    fi
else
    echo "✅ devtools repository already exists"
fi

# Change to the devtools directory
cd "$DEVTOOLS_DIR"
echo "📁 Working from: $(pwd)"

# Detect OS
OS=""
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    echo "🍎 Detected macOS"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if command -v apt-get &>/dev/null; then
        OS="ubuntu"
        echo "🐧 Detected Ubuntu Linux"
    else
        echo "❌ This script supports Ubuntu Linux only"
        exit 1
    fi
else
    echo "❌ Unsupported operating system. This script supports macOS and Ubuntu Linux only."
    exit 1
fi

# OS-specific setup
if [[ "$OS" == "macos" ]]; then
    # Install Xcode Command Line Tools if not present
    if ! xcode-select -p &>/dev/null; then
        echo "📦 Installing Xcode Command Line Tools..."
        xcode-select --install
        echo "⚠️  Please complete the Xcode Command Line Tools installation and run this script again"
        exit 1
    fi

    # Install Homebrew if not present
    if ! command -v brew &>/dev/null; then
        echo "🍺 Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for Apple Silicon Macs
        if [[ $(uname -m) == "arm64" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    else
        echo "✅ Homebrew already installed"
    fi

    # Install Ansible if not present
    if ! command -v ansible-playbook &>/dev/null; then
        echo "📋 Installing Ansible..."
        brew install ansible
    else
        echo "✅ Ansible already installed"
    fi

elif [[ "$OS" == "ubuntu" ]]; then
    # Update package lists
    echo "📦 Updating package lists..."
    sudo apt-get update

    # Install required packages
    echo "📋 Installing required packages..."
    sudo apt-get install -y software-properties-common apt-transport-https wget curl git

    # Install Ansible if not present
    if ! command -v ansible-playbook &>/dev/null; then
        echo "📋 Installing Ansible..."
        sudo apt-add-repository --yes --update ppa:ansible/ansible
        sudo apt-get install -y ansible
    else
        echo "✅ Ansible already installed"
    fi
fi

# Run the main playbook
echo "🎭 Running Ansible playbook..."
# You can use either inventory format:
# ansible-playbook -i inventory.yml playbook.yml --ask-become-pass  # YAML format
# ansible-playbook -i hosts playbook.yml --ask-become-pass         # Traditional format

ansible-playbook -i inventory.yml playbook.yml --ask-become-pass

echo "✨ Development environment setup complete!"
echo "🔄 Please restart your terminal or run 'source ~/.bashrc' to apply all changes" 