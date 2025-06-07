#!/bin/bash

set -e

echo "🔄 Updating development environment..."

# Check if Ansible is available
if ! command -v ansible-playbook &>/dev/null; then
    echo "❌ Ansible not found. Please run ./setup.sh first."
    exit 1
fi

# Run the update playbook
echo "📦 Upgrading packages and tools..."
ansible-playbook -i inventory.yml update.yml --ask-become-pass

echo "✨ Development environment update complete!"
echo "🔄 Please restart your terminal to ensure all updates are active" 