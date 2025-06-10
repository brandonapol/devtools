#!/bin/bash

# Package Installation Script
OS="$1"

echo "Installing development packages..."

if [[ "$OS" == "macos" ]]; then
    echo "🍺 Installing Homebrew packages..."
    
    # Install packages via Homebrew
    brew install \
        ansible \
        arp-scan \
        bash \
        coreutils \
        docker \
        docker-compose \
        go \
        kubectl \
        helm \
        k9s \
        git \
        vim \
        curl \
        wget \
        tree \
        htop \
        jq \
        yq \
        make \
        minikube \
        istioctl
    
    echo "🖥️ Installing Homebrew cask applications..."
    brew install --cask \
        brave-browser \
        visual-studio-code \
        multipass \
        dotnet
        
elif [[ "$OS" == "linux" ]]; then
    echo "📦 Installing packages via apt..."
    
    # Install basic packages
    sudo apt install -y \
        ansible \
        arp-scan \
        bash \
        coreutils \
        git \
        vim \
        tree \
        htop \
        jq \
        make \
        curl \
        wget \
        brave-browser \
        code \
        kubectl \
        helm \
        docker.io \
        docker-compose
    
    echo "📥 Installing Go manually..."
    GO_VERSION="1.21.5"
    wget "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz" -O /tmp/go.tar.gz
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf /tmp/go.tar.gz
    rm /tmp/go.tar.gz
    
    echo "📥 Installing k9s manually..."
    wget "https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_amd64.tar.gz" -O /tmp/k9s.tar.gz
    mkdir -p /tmp/k9s
    tar -C /tmp/k9s -xzf /tmp/k9s.tar.gz
    sudo mv /tmp/k9s/k9s /usr/local/bin/
    rm -rf /tmp/k9s*
    
    echo "📥 Installing .NET SDK..."
    wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    rm packages-microsoft-prod.deb
    sudo apt update
    sudo apt install -y dotnet-sdk-8.0
    
    echo "📥 Installing minikube manually..."
    curl -LO "https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64"
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
    rm minikube-linux-amd64
    
    echo "📥 Installing istioctl manually..."
    curl -L https://istio.io/downloadIstio | sh -
    sudo mv istio-*/bin/istioctl /usr/local/bin/
    rm -rf istio-*
    
    echo "📥 Installing yq manually..."
    YQ_VERSION=$(curl -s https://api.github.com/repos/mikefarah/yq/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')
    wget "https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64" -O /tmp/yq
    sudo mv /tmp/yq /usr/local/bin/yq
    sudo chmod +x /usr/local/bin/yq
fi

echo "✅ Package installation complete" 