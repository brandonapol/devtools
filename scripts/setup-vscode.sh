#!/bin/bash

# VS Code Configuration
OS="$1"

echo "Setting up VS Code..."

# Install extensions
echo "📦 Installing VS Code extensions..."
extensions=(
    "aaron-bond.better-comments"
    "adpyke.codesnap"
    "angular.ng-template"
    "arjun.swagger-viewer"
    "bradlc.vscode-tailwindcss"
    "chakrounanas.turbo-console-log"
    "christian-kohler.npm-intellisense"
    "docker.docker"
    "dsznajder.es7-react-js-snippets"
    "eamodio.gitlens"
    "esbenp.prettier-vscode"
    "github.vscode-github-actions"
    "golang.go"
    "gruntfuggly.todo-tree"
    "janjoerke.jenkins-pipeline-linter-connector"
    "lucafalasco.matcha"
    "ms-azuretools.vscode-containers"
    "ms-azuretools.vscode-docker"
    "ms-dotnettools.csharp"
    "ms-dotnettools.vscode-dotnet-runtime"
    "ms-kubernetes-tools.vscode-kubernetes-tools"
    "ms-python.autopep8"
    "ms-python.debugpy"
    "ms-python.python"
    "ms-python.vscode-pylance"
    "ms-toolsai.jupyter"
    "ms-toolsai.jupyter-keymap"
    "ms-toolsai.jupyter-renderers"
    "ms-toolsai.vscode-jupyter-cell-tags"
    "ms-toolsai.vscode-jupyter-slideshow"
    "ms-vscode-remote.remote-containers"
    "ms-vscode-remote.remote-ssh"
    "ms-vscode-remote.remote-ssh-edit"
    "ms-vscode-remote.remote-wsl"
    "ms-vscode-remote.vscode-remote-extensionpack"
    "ms-vscode.remote-explorer"
    "ms-vscode.remote-server"
    "ms-vscode.vscode-typescript-next"
    "prisma.prisma"
    "rangav.vscode-thunder-client"
    "redhat.vscode-xml"
    "redhat.vscode-yaml"
    "ritwickdey.liveserver"
    "sdras.vue-vscode-snippets"
    "sonarsource.sonarlint-vscode"
    "svelte.svelte-vscode"
    "thekalinga.bootstrap4-vscode"
    "tim-koehler.helm-intellisense"
    "timonwong.shellcheck"
    "uctakeoff.vscode-counter"
    "vue.volar"
    "wix.vscode-import-cost"
    "yzhang.markdown-all-in-one"
)

for extension in "${extensions[@]}"; do
    code --install-extension "$extension" 2>/dev/null || echo "Failed to install $extension"
done

# Create VS Code settings directory
if [[ "$OS" == "macos" ]]; then
    VSCODE_DIR="$HOME/Library/Application Support/Code/User"
elif [[ "$OS" == "linux" ]]; then
    VSCODE_DIR="$HOME/.config/Code/User"
fi

mkdir -p "$VSCODE_DIR"

# Create settings.json
cat > "$VSCODE_DIR/settings.json" << 'EOF'
{
    "workbench.colorTheme": "Solarized Dark",
    "files.autoSave": "afterDelay",
    "javascript.inlayHints.enumMemberValues.enabled": true,
    "typescript.inlayHints.enumMemberValues.enabled": true,
    "typescript.inlayHints.functionLikeReturnTypes.enabled": true,
    "typescript.inlayHints.propertyDeclarationTypes.enabled": true,
    "typescript.inlayHints.parameterTypes.enabled": true,
    "typescript.inlayHints.variableTypes.enabled": true,
    "workbench.sideBar.location": "right",
    "security.workspace.trust.untrustedFiles": "open",
    "[yaml]": {
        "editor.defaultFormatter": "redhat.vscode-yaml"
    },
    "[json]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "svelte.enable-ts-plugin": true,
    "[javascript]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "[vue]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "[html]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "[css]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "go.inlayHints.assignVariableTypes": true,
    "go.inlayHints.compositeLiteralFields": true,
    "go.inlayHints.compositeLiteralTypes": true,
    "go.inlayHints.constantValues": true,
    "go.inlayHints.functionTypeParameters": true,
    "go.inlayHints.parameterNames": true,
    "go.inlayHints.rangeVariableTypes": true,
    "[typescript]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "[typescriptreact]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "diffEditor.ignoreTrimWhitespace": false,
    "extensions.ignoreRecommendations": true,
    "prisma.showPrismaDataPlatformNotification": false,
    "terminal.integrated.enableMultiLinePasteWarning": false,
    "git.ignoreRebaseWarning": true,
    "javascript.inlayHints.parameterTypes.enabled": true,
    "javascript.inlayHints.functionLikeReturnTypes.enabled": true,
    "javascript.inlayHints.variableTypes.enabled": true,
    "javascript.inlayHints.propertyDeclarationTypes.enabled": true,
    "vue.inlayHints.destructuredProps": true,
    "vue.inlayHints.inlineHandlerLeading": true,
    "vue.inlayHints.optionsWrapper": true,
    "vue.inlayHints.missingProps": true,
    "vue.inlayHints.vBindShorthand": true,
    "[jsonc]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
    "workbench.startupEditor": "none"
}
EOF

echo "✅ VS Code setup complete" 