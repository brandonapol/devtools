#!/bin/bash

# Local Hosts Configuration
OS="$1"

echo "Configuring local development domains..."

# Backup existing hosts file
sudo cp /etc/hosts /etc/hosts.backup

# Add development domains to hosts file
sudo tee -a /etc/hosts > /dev/null << 'EOF'

# Local development domains
127.0.0.1   local.dev
127.0.0.1   api.local.dev
127.0.0.1   app.local.dev
127.0.0.1   admin.local.dev
127.0.0.1   dashboard.local.dev
127.0.0.1   staging.local.dev
127.0.0.1   test.local.dev

# Docker development
127.0.0.1   docker.local
127.0.0.1   postgres.local
127.0.0.1   redis.local
127.0.0.1   mongo.local

# Kubernetes development
127.0.0.1   k8s.local
127.0.0.1   registry.local
EOF

# Flush DNS cache
if [[ "$OS" == "macos" ]]; then
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
elif [[ "$OS" == "linux" ]]; then
    sudo systemctl restart systemd-resolved 2>/dev/null || sudo service networking restart
fi

echo "✅ Hosts configuration complete" 