#!/usr/bin/env bash
# setup-claude.sh — Bootstrap Claude Code + MCP servers on Linux (Arch) or macOS
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
OS="$(uname -s)"
ARCH="$(uname -m)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info()  { echo -e "${GREEN}[+]${NC} $*"; }
warn()  { echo -e "${YELLOW}[!]${NC} $*"; }
error() { echo -e "${RED}[x]${NC} $*"; exit 1; }

command_exists() { command -v "$1" &>/dev/null; }

# ---------- OS-specific package install ----------
install_pkg() {
    case "$OS" in
        Linux)
            if command_exists yay; then
                yay -S --needed --noconfirm "$@"
            elif command_exists pacman; then
                sudo pacman -S --needed --noconfirm "$@"
            else
                error "Unsupported Linux distro — expected Arch-based with yay/pacman"
            fi
            ;;
        Darwin)
            if ! command_exists brew; then
                error "Homebrew not found. Install it first: https://brew.sh"
            fi
            brew install "$@"
            ;;
        *)
            error "Unsupported OS: $OS"
            ;;
    esac
}

# ---------- 1. Go (official tarball, latest stable) ----------
install_go() {
    if command_exists go; then
        info "Go already installed: $(go version)"
        return
    fi

    info "Fetching latest stable Go version..."
    GO_VERSION=$(curl -fsSL 'https://go.dev/VERSION?m=text' | head -1)

    case "${OS}-${ARCH}" in
        Linux-x86_64)   GO_ARCHIVE="${GO_VERSION}.linux-amd64.tar.gz" ;;
        Linux-aarch64)  GO_ARCHIVE="${GO_VERSION}.linux-arm64.tar.gz" ;;
        Darwin-x86_64)  GO_ARCHIVE="${GO_VERSION}.darwin-amd64.tar.gz" ;;
        Darwin-arm64)   GO_ARCHIVE="${GO_VERSION}.darwin-arm64.tar.gz" ;;
        *) error "Unsupported platform: ${OS}-${ARCH}" ;;
    esac

    info "Installing ${GO_VERSION} from official tarball..."
    TMP_DIR=$(mktemp -d)
    curl -fsSL "https://go.dev/dl/${GO_ARCHIVE}" -o "${TMP_DIR}/${GO_ARCHIVE}"
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf "${TMP_DIR}/${GO_ARCHIVE}"
    rm -rf "$TMP_DIR"

    # Ensure PATH is set for the rest of this script
    export PATH="/usr/local/go/bin:$HOME/go/bin:$PATH"
    info "Go installed: $(go version)"
}

# ---------- 2. Core dependencies (package manager) ----------
install_core_deps() {
    info "Checking core dependencies..."

    DEPS=()
    command_exists node || DEPS+=(nodejs npm)
    command_exists gpg  || DEPS+=(gnupg)
    command_exists pass || DEPS+=(pass)

    if [[ "$OS" == "Darwin" ]]; then
        DEPS=("${DEPS[@]/nodejs/node}")
        DEPS=("${DEPS[@]/npm/}")  # brew node includes npm
    fi

    # Remove empty entries
    DEPS=("${DEPS[@]}" )
    DEPS=($(echo "${DEPS[@]}" | xargs))

    if [[ ${#DEPS[@]} -gt 0 ]]; then
        install_pkg "${DEPS[@]}"
    else
        info "Core dependencies already installed."
    fi
}

# ---------- 3. Docker / container runtime ----------
install_docker() {
    if command_exists docker; then
        info "Docker CLI already installed."
        return
    fi

    case "$OS" in
        Darwin)
            info "Installing Colima + Docker CLI..."
            brew install colima docker
            info "Start Colima with: colima start"
            ;;
        Linux)
            info "Installing Docker..."
            install_pkg docker
            sudo systemctl enable --now docker.service
            sudo usermod -aG docker "$USER"
            warn "Added $USER to docker group — log out and back in for it to take effect."
            ;;
    esac
}

# ---------- 4. kubectl ----------
install_kubectl() {
    if command_exists kubectl; then
        info "kubectl already installed."
        return
    fi
    info "Installing kubectl..."
    install_pkg kubectl
}

# ---------- 5. Claude Code ----------
install_claude() {
    if command_exists claude; then
        info "Claude Code already installed: $(claude --version 2>/dev/null || echo 'unknown')"
        return
    fi
    info "Installing Claude Code..."
    npm install -g @anthropic-ai/claude-code
}

# ---------- 6. github-mcp-server ----------
install_github_mcp() {
    if command_exists github-mcp-server; then
        info "github-mcp-server already installed."
        return
    fi
    info "Installing github-mcp-server..."
    go install github.com/github/github-mcp-server/cmd/github-mcp-server@latest
}

# ---------- 7. pyenv + Python ----------
PYTHON_VERSION="3.12"

install_python() {
    if ! command_exists pyenv; then
        info "Installing pyenv..."
        if [[ "$OS" == "Darwin" ]]; then
            brew install pyenv
        else
            install_pkg pyenv
        fi
    fi

    eval "$(pyenv init -)" 2>/dev/null || true

    PYTHON_FULL=$(pyenv versions --bare 2>/dev/null | grep "^${PYTHON_VERSION}" | tail -1 || true)

    if [[ -z "$PYTHON_FULL" ]]; then
        info "Installing Python ${PYTHON_VERSION} via pyenv..."
        PYTHON_FULL=$(pyenv install --list | tr -d ' ' | grep "^${PYTHON_VERSION}\." | grep -v '[a-z]' | tail -1)
        pyenv install "$PYTHON_FULL"
    else
        info "Python ${PYTHON_FULL} already installed via pyenv."
    fi
}

# ---------- 8. Fix paths in .claude.json ----------
fix_claude_paths() {
    CLAUDE_JSON="$DOTFILES_DIR/.claude.json"

    if [[ ! -f "$CLAUDE_JSON" ]]; then
        warn ".claude.json not found in dotfiles — skipping path fixup."
        return
    fi

    if ! grep -q '/home/samsepiol' "$CLAUDE_JSON"; then
        info "Paths in .claude.json already correct."
        return
    fi

    info "Fixing hardcoded paths in .claude.json..."

    if [[ "$OS" == "Darwin" ]]; then
        sed -i '' "s|/home/samsepiol|$HOME|g" "$CLAUDE_JSON"
    else
        sed -i "s|/home/samsepiol|$HOME|g" "$CLAUDE_JSON"
    fi

    # Update pyenv python path to match installed version
    PYTHON_FULL=$(pyenv versions --bare 2>/dev/null | grep "^${PYTHON_VERSION}" | tail -1 || true)
    if [[ -n "$PYTHON_FULL" ]]; then
        PYENV_BIN="$HOME/.pyenv/versions/$PYTHON_FULL/bin/python"
        if [[ "$OS" == "Darwin" ]]; then
            sed -i '' "s|$HOME/.pyenv/versions/[0-9.]*/bin/python|$PYENV_BIN|g" "$CLAUDE_JSON"
        else
            sed -i "s|$HOME/.pyenv/versions/[0-9.]*/bin/python|$PYENV_BIN|g" "$CLAUDE_JSON"
        fi
    fi

    info "Paths in .claude.json updated to use $HOME"
}

# ---------- 9. Pull k8s MCP Docker image ----------
pull_k8s_mcp() {
    if command_exists docker && docker info &>/dev/null; then
        info "Pulling k8s MCP server image..."
        docker pull ghcr.io/alexei-led/k8s-mcp-server:latest
    else
        warn "Docker not running — skipping k8s MCP image pull. Run later:"
        warn "  docker pull ghcr.io/alexei-led/k8s-mcp-server:latest"
    fi
}

# ---------- Run ----------
echo ""
info "Claude Code setup — $(uname -s) $(uname -m)"
echo ""

install_go
install_core_deps
install_docker
install_kubectl
install_claude
install_github_mcp
install_python
fix_claude_paths

info "Running dotfiles install..."
cd "$DOTFILES_DIR"
make install

pull_k8s_mcp

# ---------- Done ----------
echo ""
info "Claude Code setup complete!"
echo ""
warn "Manual steps remaining:"
echo "  1. Import your GPG key:    gpg --import /path/to/key.asc"
echo "  2. Init password store:    pass init <your-gpg-id>"
echo "  3. Add GitHub PAT:         pass insert github/personal-access-token"
echo "  4. Source your shell:       source ~/.bashrc  (or restart terminal)"
echo ""
if [[ "$OS" == "Darwin" ]]; then
    warn "macOS notes:"
    echo "  - Start Colima before using Docker MCP:  colima start"
    echo "  - Default shell is zsh — ensure ~/.zshrc has pass/pyenv setup"
    echo ""
fi
