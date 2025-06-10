#!/bin/bash

# Shell Configuration Setup Script

echo "Setting up custom shell configuration..."

# Backup existing bashrc if it exists
if [ -f ~/.bashrc ]; then
    echo "Backing up existing ~/.bashrc to ~/.bashrc.backup"
    cp ~/.bashrc ~/.bashrc.backup
fi

# Create new bashrc configuration
cat > ~/.bashrc << 'EOF'
# Repository and Environment Setup
export REPO=~/repo
# Source local development overrides if they exist
if [ -f "$HOME/.bashrc-dev" ]; then
    source "$HOME/.bashrc-dev"
fi

# Custom Prompt and Git Functions
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/' -e 's/^\(.\{9\}\).*/(\1)/'
}
parse_git_branch_full() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

# Custom Bash Prompt (not zsh)
PS1='🐻 \[\033[01;32m\]$(hostname)\[\033[00m\] \[\033[01;35m\]$(kubectl config current-context 2>/dev/null)\[\033[01;32m\] \[\033[01;36m\]\W\[\033[01;32m\] \[\033[01;33m\]$(parse_git_branch_full)\[\033[01;32m\] $\[\033[00m\] '

# Kubernetes Context Switching
alias point_minikube='export KUBECONFIG=/home/brandon/.kube/config'

# Git Workflow Aliases
alias gcd='git checkout develop'
alias gadd='git add .'
alias gpoh='git push origin HEAD'

# Navigation
alias ".."="cd ../"
alias "..."="cd ../.."
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Minikube Docker Environment
alias fixEnv='eval $(minikube docker-env)'
alias exitEnv='eval $(minikube docker-env -u)'
alias eod="minikube stop && shutdown now"

# Git Workflow Functions
gacp() {
  if [ -z "$1" ]; then
    echo "Error: No commit message provided."
    echo "Usage: gacp <commit_message>"
    return 1
  fi
  git add .
  if [ $? -ne 0 ]; then
    echo "Failed to add changes."
    return 1
  fi
  git commit -m "$1"
  if [ $? -ne 0 ]; then
    echo "Commit failed."
    return 1
  fi
  git push origin HEAD
  if [ $? -ne 0 ]; then
    echo "Push failed."
    return 1
  fi
  echo "Git add, commit, and push completed successfully."
}

gac() {
  if [ -z "$1" ]; then
    echo "Error: No commit message provided."
    echo "Usage: gac <commit_message>"
    return 1
  fi
  git add .
  if [ $? -ne 0 ]; then
    echo "Failed to add changes."
    return 1
  fi
  git commit -m "$1"
  if [ $? -ne 0 ]; then
    echo "Commit failed."
    return 1
  fi
  echo "Git add and commit completed successfully."
}

# Development Environment Functions
function goodmorning() {
    echo " __    __     _                              ___                     _             "
    echo "/ / /\\ \\ \\___| | ___ ___  _ __ ___   ___    / __\\_ __ __ _ _ __   __| | ___  _ __  "
    echo "\\ \\/  \\/ / _ \\ |/ __/ _ \\| '_ \` _ \\ / _ \\  /__/\\// '__/ _\` | '_ \\ / _\` |/ _ \\| '_ \\ "
    echo " \\  /\\  /  __/ | (_| (_) | | | | | |  __/ / \\/  \\| | (_| | | | | (_| | (_) | | | |"
    echo "  \\/  \\/ \\___|_|\\___\\___/|_| |_| |_|\\___| \\_____/|_|  \\__,_|_| |_|\\__,_|\\___/|_| |_|"
    echo "                                                                                   "
    minikube start
    gnome-terminal --tab -- bash -c "minikube tunnel" 2>/dev/null || echo "Note: gnome-terminal not available on macOS"
}

# Network Configuration Function
update_resolv_conf() {
  echo "nameserver 127.0.0.53
nameserver 10.10.10.49
nameserver 1.1.1.1
options edns0 trust-ad
search mshome.net" | sudo tee /etc/resolv.conf > /dev/null
}

# Path Configurations
export PATH="$PATH:/usr/local/go/bin"
export PATH="$HOME/atlassian-plugin-sdk-8.2.7/bin:$PATH"
export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH=$PWD/bin:$PATH
export PATH=$PATH:/Users/$USER/go/bin/
export PATH="$PATH:/usr/local/bin"

# macOS specific path
if [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH="$(brew --prefix)/opt/make/libexec/gnubin:$PATH"
fi

# Environment Variables
export EDITOR=vim

# Development helpers with Bun priority
function dev_server() {
    if command -v bun &> /dev/null; then
        echo "Starting development server with Bun..."
        bun dev
    elif command -v npm &> /dev/null; then
        echo "Starting development server with npm..."
        npm run dev
    else
        echo "No package manager found"
    fi
}

function build_project() {
    if command -v bun &> /dev/null; then
        echo "Building project with Bun..."
        bun run build
    elif command -v npm &> /dev/null; then
        echo "Building project with npm..."
        npm run build
    else
        echo "No package manager found"
    fi
}

# Enable bash completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
EOF

echo "Created new ~/.bashrc configuration"

# Detect OS and install bash completion
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Detected Linux system"
    
    # Check if we're on Ubuntu/Debian
    if command -v apt-get &> /dev/null; then
        echo "Installing bash-completion..."
        sudo apt-get update && sudo apt-get install -y bash-completion
    elif command -v yum &> /dev/null; then
        echo "Installing bash-completion..."
        sudo yum install -y bash-completion
    elif command -v dnf &> /dev/null; then
        echo "Installing bash-completion..."
        sudo dnf install -y bash-completion
    fi
    
    # Set bash as default shell
    if [ "$SHELL" != "$(which bash)" ]; then
        echo "Setting bash as default shell..."
        chsh -s $(which bash)
        echo "Shell changed to bash. Please log out and back in for the change to take effect."
    fi
    
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Detected macOS system"
    if command -v brew &> /dev/null; then
        echo "Installing bash-completion via Homebrew..."
        brew install bash-completion
    else
        echo "Homebrew not found. Please install Homebrew first or install bash-completion manually."
    fi
fi

# Install kubectl completion if kubectl is available
if command -v kubectl &> /dev/null; then
    echo "Installing kubectl bash completion..."
    sudo mkdir -p /etc/bash_completion.d/
    kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null
fi

# Install helm completion if helm is available
if command -v helm &> /dev/null; then
    echo "Installing helm bash completion..."
    sudo mkdir -p /etc/bash_completion.d/
    helm completion bash | sudo tee /etc/bash_completion.d/helm > /dev/null
fi

# Install minikube completion if minikube is available
if command -v minikube &> /dev/null; then
    echo "Installing minikube bash completion..."
    sudo mkdir -p /etc/bash_completion.d/
    minikube completion bash | sudo tee /etc/bash_completion.d/minikube > /dev/null
fi

# Install istioctl completion if istioctl is available
if command -v istioctl &> /dev/null; then
    echo "Installing istioctl bash completion..."
    sudo mkdir -p /etc/bash_completion.d/
    istioctl completion bash | sudo tee /etc/bash_completion.d/istioctl > /dev/null
fi

echo "Shell setup complete!"
echo "Run 'source ~/.bashrc' to apply changes to your current session"
echo "Or open a new terminal window" 