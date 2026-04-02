#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ── Colors ────────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

info()    { echo -e "${BLUE}${BOLD}==${NC} $1"; }
success() { echo -e "${GREEN}✓${NC} $1"; }
warn()    { echo -e "${YELLOW}!${NC} $1"; }
error()   { echo -e "${RED}✗${NC} $1"; exit 1; }
step()    { echo -e "\n${BOLD}$1${NC}"; }

# ── Symlink helper ────────────────────────────────────────────────────────────
link() {
  local src="$1"
  local dest="$2"

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo -n "  '$dest' finns redan. Skriva över? [y/N] "
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
      rm -rf "$dest"
    else
      warn "Hoppar över $dest"
      return
    fi
  fi

  ln -s "$src" "$dest"
  success "Länkad: $dest → $src"
}

# ── 1. Symlinks ───────────────────────────────────────────────────────────────
setup_symlinks() {
  step "1/11  Sätter upp symlinks"
  mkdir -p "$HOME/.config"
  link "$DOTFILES_DIR/nvim"           "$HOME/.config/nvim"
  link "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
  link "$DOTFILES_DIR/zsh/.zshrc"     "$HOME/.zshrc"
}

# ── 2. System packages ────────────────────────────────────────────────────────
install_system_deps() {
  step "2/11  Installerar systempaket (apt)"
  sudo apt update -qq
  sudo apt install -y \
    git curl wget unzip ca-certificates gnupg \
    build-essential cmake ninja-build gettext \
    zsh tmux \
    ripgrep fd-find \
    python3 python3-pip python3-venv \
    lsb-release
  success "Systempaket installerade"
}

# ── 3. Neovim (GitHub releases) ───────────────────────────────────────────────
install_neovim() {
  step "3/11  Installerar Neovim (senaste stabila)"
  local url="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
  local tmp
  tmp=$(mktemp -d)

  info "Laddar ner Neovim..."
  curl -sSL "$url" -o "$tmp/nvim.tar.gz"
  sudo rm -rf /opt/nvim
  sudo mkdir -p /opt/nvim
  sudo tar -xzf "$tmp/nvim.tar.gz" -C /opt/nvim --strip-components=1
  sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim

  rm -rf "$tmp"
  success "Neovim installerat: $(nvim --version | head -1)"
}

# ── 4. FZF ────────────────────────────────────────────────────────────────────
install_fzf() {
  step "4/11  Installerar fzf"
  if [ -d "$HOME/.fzf" ]; then
    warn "~/.fzf finns redan, uppdaterar..."
    git -C "$HOME/.fzf" pull -q
  else
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  fi
  "$HOME/.fzf/install" --all --no-update-rc
  success "fzf installerat"
}

# ── 5. zoxide ─────────────────────────────────────────────────────────────────
install_zoxide() {
  step "5/11  Installerar zoxide"
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
  success "zoxide installerat"
}

# ── 6. Linuxbrew ──────────────────────────────────────────────────────────────
install_linuxbrew() {
  step "6/11  Installerar Linuxbrew"
  if [ -d "/home/linuxbrew/.linuxbrew" ]; then
    warn "Linuxbrew finns redan, hoppar över"
  else
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    success "Linuxbrew installerat"
  fi
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
  info "Installerar Gleam via brew..."
  brew install gleam
  success "Gleam installerat: $(gleam --version)"
}

# ── 7. NVM + Node.js LTS ──────────────────────────────────────────────────────
install_node() {
  step "7/11  Installerar NVM + Node.js LTS"
  local nvm_version
  nvm_version=$(curl -sSL https://api.github.com/repos/nvm-sh/nvm/releases/latest \
    | grep '"tag_name"' | cut -d'"' -f4)

  info "Installerar NVM $nvm_version..."
  curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${nvm_version}/install.sh" | bash

  export NVM_DIR="$HOME/.nvm"
  # shellcheck source=/dev/null
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

  info "Installerar Node.js LTS..."
  nvm install --lts
  nvm use --lts

  # Global npm-katalog (matchar PATH i .zshrc)
  mkdir -p "$HOME/.npm-global"
  npm config set prefix "$HOME/.npm-global"

  success "Node.js installerat: $(node --version)"
}

# ── 8. Rust ───────────────────────────────────────────────────────────────────
install_rust() {
  step "8/11  Installerar Rust (rustup)"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
  # shellcheck source=/dev/null
  source "$HOME/.cargo/env"
  success "Rust installerat: $(rustc --version)"
}

# ── 9. Go ─────────────────────────────────────────────────────────────────────
install_go() {
  step "9/11  Installerar Go (senaste stabila)"
  local go_version
  go_version=$(curl -sSL "https://go.dev/VERSION?m=text" | head -1)
  local url="https://go.dev/dl/${go_version}.linux-amd64.tar.gz"
  local tmp
  tmp=$(mktemp -d)

  info "Laddar ner ${go_version}..."
  curl -sSL "$url" -o "$tmp/go.tar.gz"
  sudo rm -rf /usr/local/go
  sudo tar -xzf "$tmp/go.tar.gz" -C /usr/local

  export PATH="$PATH:/usr/local/go/bin"
  rm -rf "$tmp"
  success "Go installerat: $(go version)"
}

# ── 10. .NET SDK ──────────────────────────────────────────────────────────────
install_dotnet() {
  step "10/11  Installerar .NET SDK"
  local ubuntu_version
  ubuntu_version=$(lsb_release -rs)

  wget -q "https://packages.microsoft.com/config/ubuntu/${ubuntu_version}/packages-microsoft-prod.deb" \
    -O /tmp/packages-microsoft-prod.deb
  sudo dpkg -i /tmp/packages-microsoft-prod.deb
  sudo apt update -qq
  sudo apt install -y dotnet-sdk-10.0
  rm /tmp/packages-microsoft-prod.deb

  export DOTNET_ROOT="$HOME/.dotnet"
  success ".NET installerat: $(dotnet --version)"
}

# ── 11. Flutter + Dart ────────────────────────────────────────────────────────
install_flutter() {
  step "11/11  Installerar Flutter + Dart"
  local flutter_dir="$HOME/flutter"

  if [ -d "$flutter_dir" ]; then
    warn "Flutter finns redan på $flutter_dir, uppdaterar..."
    git -C "$flutter_dir" pull -q
  else
    info "Klonar Flutter (stable)..."
    git clone https://github.com/flutter/flutter.git -b stable "$flutter_dir" --depth 1
  fi

  export PATH="$PATH:$flutter_dir/bin"
  info "Kör flutter precache..."
  flutter precache --suppress-analytics
  success "Flutter installerat: $(flutter --version 2>&1 | head -1)"
}

# ── Byt shell till zsh ────────────────────────────────────────────────────────
set_zsh_as_default() {
  local zsh_path
  zsh_path=$(which zsh)

  if [ "$SHELL" = "$zsh_path" ]; then
    success "zsh är redan default-shell"
    return
  fi

  info "Byter default-shell till zsh..."
  if ! grep -qx "$zsh_path" /etc/shells; then
    echo "$zsh_path" | sudo tee -a /etc/shells
  fi
  chsh -s "$zsh_path"
  success "Default-shell ändrad till zsh"
}

# ── Main ──────────────────────────────────────────────────────────────────────
main() {
  echo -e "\n${BOLD}  Dotfiles Installer${NC}"
  echo    "  ==================="
  echo -e "  Dotfiles: ${BLUE}${DOTFILES_DIR}${NC}\n"

  setup_symlinks
  install_system_deps
  install_neovim
  install_fzf
  install_zoxide
  install_linuxbrew
  install_node
  install_rust
  install_go
  install_dotnet
  install_flutter
  set_zsh_as_default

  echo -e "\n${GREEN}${BOLD}Klart!${NC}"
  echo "  • Starta om terminalen eller kör: exec zsh"
  echo "  • Öppna Neovim – plugins installeras automatiskt vid första start"
}

main "$@"
