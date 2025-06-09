#!/bin/bash

# Simple script to run individual playbooks
# Usage: ./run.sh <playbook_name>
# Example: ./run.sh shell

if [ $# -eq 0 ]; then
    echo "🔧 Available playbooks:"
    ls playbooks/*.yml | sed 's/playbooks\///g' | sed 's/\.yml//g' | sort
    echo
    echo "Usage: ./run.sh <playbook_name>"
    echo "Example: ./run.sh shell"
    echo
    echo "Or run everything: ./run.sh all"
    exit 1
fi

PLAYBOOK="$1"

if [ "$PLAYBOOK" = "all" ]; then
    echo "🚀 Running complete setup..."
    ansible-playbook -i inventory.yml site.yml
elif [ -f "playbooks/${PLAYBOOK}.yml" ]; then
    echo "🎯 Running ${PLAYBOOK} setup..."
    ansible-playbook -i inventory.yml "playbooks/${PLAYBOOK}.yml"
else
    echo "❌ Playbook '${PLAYBOOK}' not found"
    echo "Available playbooks:"
    ls playbooks/*.yml | sed 's/playbooks\///g' | sed 's/\.yml//g' | sort
    exit 1
fi 