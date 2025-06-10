#!/bin/bash

# Update All Development Tools

echo "🔄 Updating all development tools..."

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "🍺 Updating Homebrew packages..."
    brew update && brew upgrade
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "📦 Updating apt packages..."
    sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
fi

echo "📦 Updating Node.js to latest LTS..."
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts --reinstall-packages-from=current
nvm use --lts
nvm alias default lts/*

echo "🏃 Updating Bun..."
curl -fsSL https://bun.sh/install | bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "📥 Updating Go..."
    GO_LATEST=$(curl -s https://api.github.com/repos/golang/go/releases/latest | grep -oP '"tag_name": "\K.*?(?=")' | sed 's/go//')
    wget "https://go.dev/dl/go${GO_LATEST}.linux-amd64.tar.gz" -O /tmp/go.tar.gz
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf /tmp/go.tar.gz
    rm /tmp/go.tar.gz
    
    echo "📥 Updating k9s..."
    wget "https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_amd64.tar.gz" -O /tmp/k9s.tar.gz
    mkdir -p /tmp/k9s
    tar -C /tmp/k9s -xzf /tmp/k9s.tar.gz
    sudo mv /tmp/k9s/k9s /usr/local/bin/
    rm -rf /tmp/k9s*
    
    echo "📥 Updating minikube..."
    curl -LO "https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64"
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
    rm minikube-linux-amd64
    
    echo "📥 Updating istioctl..."
    ISTIO_LATEST=$(curl -s https://api.github.com/repos/istio/istio/releases/latest | grep -oP '"tag_name": "\K.*?(?=")')
    wget "https://github.com/istio/istio/releases/latest/download/istio-${ISTIO_LATEST}-linux-amd64.tar.gz" -O /tmp/istio.tar.gz
    mkdir -p /tmp/istio
    tar -C /tmp/istio -xzf /tmp/istio.tar.gz
    sudo mv /tmp/istio/istio-*/bin/istioctl /usr/local/bin/
    rm -rf /tmp/istio*
fi

echo "✅ All updates complete!" 