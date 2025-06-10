#!/bin/bash

# Git Configuration

echo "Configuring Git..."

git config --global user.name "Brandon Apol"
git config --global user.email "brandonapol@cedarville.edu"
git config --global core.editor "vim"
git config --global init.defaultBranch "main"
git config --global pull.rebase "false"
git config --global push.default "simple"

echo "✅ Git configuration complete" 