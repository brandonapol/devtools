# Development Environment Setup with Ansible

This repository contains Ansible scripts to automatically set up a comprehensive development environment on macOS and Ubuntu Linux, inspired by Primeagen's approach to environment automation.

## 🚀 Quick Start

### Prerequisites

- **macOS**: Xcode Command Line Tools will be installed automatically
- **Ubuntu**: `sudo` access for package installation

### Installation

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd devtools
   ```

2. Run the setup script:
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

3. Restart your terminal or run:
   ```bash
   source ~/.bashrc
   ```

## 📦 What Gets Installed

### Package Managers & Core Tools
- **macOS**: Homebrew
- **Ubuntu**: Updates apt packages
- **Both**: Ansible (automatically installed by setup script)

### Development Tools
- **Languages & Runtimes**:
  - Node.js (via NVM) with LTS version
  - Bun (modern JavaScript runtime)
  - Go programming language
  - Python development tools

- **Version Control**:
  - Git with pre-configured settings
  - GitHub CLI tools

- **Container & Orchestration**:
  - Docker and Docker Compose
  - Kubernetes (kubectl)
  - Helm
  - k9s (Kubernetes CLI management tool)

- **Editor & IDE**:
  - Visual Studio Code with comprehensive extension pack
  - Vim/Neovim configuration

### Applications
- **Browsers**: Brave Browser
- **Development**: Visual Studio Code
- **Utilities**: Various command-line tools (jq, yq, htop, tree, etc.)

### VS Code Extensions

The setup includes 50+ carefully curated extensions:

**Language Support**:
- TypeScript/JavaScript (with React, Vue, Angular, Svelte)
- Go, Python, C#
- HTML/CSS with Tailwind support

**Development Tools**:
- GitLens, Docker, Kubernetes
- Prettier, ESLint, SonarLint
- Remote development (SSH, Containers, WSL)
- Thunder Client (REST API testing)

**Productivity**:
- Better Comments, Todo Tree
- CodeSnap (screenshots)
- Import Cost, Bracket Pair Colorizer

## 🎨 Shell Configuration

### Custom Bash Prompt
- 🐻 Emoji-based prompt with hostname
- Git branch information  
- Kubernetes context display
- Color-coded directory and status

### Aliases & Functions
- **Kubernetes workflows**: `point_minikube`, `point_rsf`, `point_pir`, `letsArgo`
- **Git workflows**: `gcd`, `gadd`, `gpoh`, `gacp()`, `gac()`
- **Minikube helpers**: `fixEnv`, `exitEnv`, `goodmorning()`, `r_goodmorning()`
- **Navigation**: `..`, `...`, enhanced `ls` aliases
- **SonarQube scanning**: `sonarScan`
- **Development servers**: Prioritizes Bun over npm

### Environment Variables
- Configured PATH for Go, Node.js, Bun
- Development-friendly editor settings
- Custom project directory configurations

## 🔧 Customization

### Git Configuration
The setup configures Git with:
- User: Brandon Apol
- Email: brandonapol@cedarville.edu (update in `tasks/git.yml`)
- Default branch: main
- Sensible defaults for pull/push behavior

### VS Code Settings
Pre-configured with:
- Solarized Dark theme
- Auto-save enabled
- Sidebar on the right
- Prettier as default formatter
- Enhanced IntelliSense for TypeScript/JavaScript

### macOS System Preferences
- Auto-hide Dock with fast animations
- Show hidden files in Finder
- Disable auto-correct and smart quotes
- Enable tap-to-click on trackpad
- Optimized screenshot settings

## 📁 Project Structure

```
.
├── setup.sh              # Main entry point script
├── update.sh              # Update/upgrade script
├── inventory.yml          # Ansible inventory (YAML format)
├── hosts                  # Ansible inventory (traditional format)
├── playbook.yml          # Main Ansible playbook
├── update.yml            # Update/upgrade playbook
├── tasks/
│   ├── core.yml          # Core system setup (Linux repositories, apt updates)
│   ├── homebrew.yml      # Package installation (Homebrew/apt packages)
│   ├── nodejs.yml        # Node.js, NVM, and Bun setup
│   ├── vscode.yml        # VS Code extensions and settings
│   ├── git.yml           # Git configuration
│   ├── shell.yml         # Bash shell setup and completion
│   ├── macos.yml         # macOS system preferences
│   ├── hosts.yml         # Local development hosts configuration
│   └── updates.yml       # Updates and upgrades for all tools
└── README.md             # This file
```

## 🛠 Advanced Usage

### Running Specific Tasks

**Update only specific components:**

```bash
# Update only system packages
ansible-playbook -i inventory.yml update.yml --ask-become-pass --tags "packages"

# Update only development tools (Node.js, Go, etc.)
ansible-playbook -i inventory.yml update.yml --ask-become-pass --tags "tools"
```

**Run specific setup tasks:**

```bash
# Only install packages
ansible-playbook -i inventory.yml playbook.yml --ask-become-pass --limit "localhost" -e "task=packages"

# Only configure shell
ansible-playbook -i inventory.yml playbook.yml --ask-become-pass --limit "localhost" -e "task=shell"
```

### Dry Run

To see what would be changed without making changes:

```bash
ansible-playbook -i inventory.yml playbook.yml --check
```

### Updating Your Environment

**To upgrade all tools to latest versions:**

```bash
./update.sh
```

This will update:
- 🍺 Homebrew packages / apt packages
- 🟨 Node.js to latest LTS (preserving global packages)
- ⚡ Bun to latest version
- 🐹 Go to latest version
- ☸️ kubectl, Helm, k9s to latest versions
- 📦 Global npm packages
- 💻 VS Code extensions
- 🐚 Bash completion files

**To re-run the full setup:**

```bash
ansible-playbook -i inventory.yml playbook.yml --ask-become-pass
```

## 🔍 Troubleshooting

### Common Issues

1. **VS Code extensions fail to install**:
   - Ensure VS Code is in your PATH
   - Try running: `code --version`

2. **Node.js/NVM not working**:
   - Restart your terminal
   - Source the shell profile: `source ~/.zshrc`

3. **Homebrew permission issues (macOS)**:
   - Check Homebrew ownership: `brew doctor`

4. **Ubuntu package installation fails**:
   - Update package lists: `sudo apt update`
   - Check internet connection

### Getting Help

- Check Ansible logs for detailed error messages
- Verify your OS is supported (macOS or Ubuntu)
- Ensure you have the required permissions

## 🔄 Update Strategy

The setup separates concerns for better maintainability:

- **`tasks/core.yml`**: Linux system preparation (apt updates, repositories)
- **`tasks/homebrew.yml`**: Package installation (clean, no system modifications)
- **`tasks/updates.yml`**: LTS/latest version upgrades for all tools
- **`update.yml`**: Dedicated update playbook
- **`update.sh`**: Simple update script

## 🎯 Functional Programming Approach

This setup follows functional programming principles where possible:
- **Immutable configurations**: Version-controlled, reproducible setups
- **Pure functions**: Shell scripts with no side effects
- **Declarative tasks**: Ansible's idempotent operations
- **Composable tools**: Modular task organization
- **Separation of concerns**: Core setup vs. updates vs. configuration

## 📝 License

This project is open source. Feel free to modify and adapt it to your needs.

---

**Inspired by**: Primeagen's development environment automation approach 