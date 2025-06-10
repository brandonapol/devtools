#!/bin/bash

# Node.js and Development Tools Setup

echo "Setting up Node.js development environment..."

# Install NVM if not already installed
if [ ! -d "$HOME/.nvm" ]; then
    echo "📥 Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
fi

# Source NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

echo "📦 Installing Node.js LTS..."
nvm install --lts
nvm use --lts
nvm alias default lts/*

echo "🏃 Installing Bun..."
curl -fsSL https://bun.sh/install | bash

echo "📦 Installing global npm packages..."
npm install -g \
    typescript \
    ts-node \
    @vue/cli \
    @angular/cli \
    create-react-app \
    prettier \
    eslint \
    nodemon \
    pm2 \
    vercel \
    netlify-cli

# Update bashrc with NVM and Bun configuration
cat >> ~/.bashrc << 'EOF'

# NVM Configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Bun Configuration
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
EOF

echo "✅ Node.js setup complete" 