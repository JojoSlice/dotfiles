# Zsh Configuration

A powerful Zsh configuration with Powerlevel10k prompt, intelligent plugins, and modern developer tools for a productive terminal experience.

## Contents

- [Installation](#installation)
  - [Zsh](#zsh)
  - [Dependencies](#dependencies)
- [Configuration](#configuration)
- [Features](#features)
- [Plugins](#plugins)
- [Keybindings](#keybindings)
- [Aliases](#aliases)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)

## Installation

### Zsh

#### Windows (WSL)

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install zsh

# Set Zsh as default shell
chsh -s $(which zsh)
```

#### macOS

```bash
# Zsh is already installed on modern macOS
# To update to the latest version:
brew install zsh

# Set as default shell
chsh -s /bin/zsh
```

#### Linux

```bash
# Ubuntu/Debian
sudo apt install zsh

# Arch Linux
sudo pacman -S zsh

# Fedora
sudo dnf install zsh

# Set as default shell
chsh -s $(which zsh)
```

**Verify installation:**
```bash
zsh --version
echo $SHELL  # Should show /bin/zsh or similar
```

### Dependencies

#### Git (Required for Zinit)

```bash
# Ubuntu/Debian
sudo apt install git

# macOS
brew install git

# Arch
sudo pacman -S git
```

#### FZF (Fuzzy Finder)

**Via Git:**
```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

**Via Package Manager:**
```bash
# Ubuntu/Debian
sudo apt install fzf

# macOS
brew install fzf
$(brew --prefix)/opt/fzf/install

# Arch
sudo pacman -S fzf
```

#### Zoxide (Smart cd)

**Linux:**
```bash
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
```

**macOS:**
```bash
brew install zoxide
```

**Cargo (alternative for all platforms):**
```bash
cargo install zoxide
```

## Plugins

### Installed Plugins

| Plugin | Description |
|--------|-------------|
| **powerlevel10k** | Modern, fast, and customizable prompt |
| **zsh-syntax-highlighting** | Real-time syntax highlighting |
| **zsh-completions** | Additional completions for common commands |
| **zsh-autosuggestions** | Suggestions based on previous commands |
| **fzf-tab** | Fuzzy finder integration for tab-completion |

### Oh My Zsh Snippets

| Snippet | Description |
|---------|-------------|
| **command-not-found** | Suggests packages when command is not found |

## Keybindings

### Vi Mode Keybindings

Basic Vi navigation is enabled (`bindkey -v`):

| Mode | Keybinding | Description |
|------|------------|-------------|
| Normal | `h/j/k/l` | Navigate in the command |
| Normal | `w/b/e` | Jump between words |
| Normal | `0/$` | Beginning/end of line |
| Normal | `dd` | Delete line |
| Normal | `cc` | Change line |
| Insert | `Esc` | Go to normal mode |

### Custom Keybindings

| Keybinding | Description |
|------------|-------------|
| `Ctrl+J` | Search backward in history |
| `Ctrl+K` | Search forward in history |
| `Ctrl+R` | FZF history search (from FZF integration) |
| `Ctrl+T` | FZF file search (from FZF integration) |
| `Alt+C` | FZF directory search (from FZF integration) |
| `Tab` | FZF tab-completion |

### Autosuggestions

| Keybinding | Description |
|------------|-------------|
| `→` (right arrow) | Accept entire suggestion |
| `Ctrl+→` | Accept one word from suggestion |
| `Ctrl+E` | Accept entire suggestion (alternative) |

## Aliases

### Standard Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `winhome` | `cd /mnt/c/Users/Johan/` | Go to Windows home (WSL) |
| `ls` | `ls --color` | Colored ls output |
| `c` | `clear` | Clear screen |

### Add More Aliases

Add to `~/.zshrc`:

```bash
# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Modern replacements
alias cat='bat'  # If you have bat installed
alias find='fd'  # If you have fd installed

# Docker
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'

# System
alias update='sudo apt update && sudo apt upgrade'  # Ubuntu/Debian
alias ports='netstat -tulanp'

# Development
alias n='nvim'
alias v='nvim'
alias python='python3'
alias pip='pip3'
```

## History Settings

### Configured Settings

```bash
HISTSIZE=5000              # 5000 commands in memory
SAVEHIST=5000              # 5000 commands saved
HISTFILE=~/.zsh_history    # History file
```

### History Behavior

- `appendhistory`: Append instead of overwrite
- `sharehistory`: Share history between sessions
- `hist_ignore_space`: Ignore commands starting with space
- `hist_ignore_all_dups`: Remove all duplicate commands
- `hist_save_no_dups`: Don't save duplicate commands
- `hist_find_no_dups`: Don't show duplicate commands when searching

### Using History

```bash
# Search in history
Ctrl+R           # FZF fuzzy search

# Vi mode history
Ctrl+J           # Previous matching command
Ctrl+K           # Next matching command

# Traditional history
history          # Show all history
history 20       # Show last 20
!!               # Run last command
!$               # Last argument from previous command
!abc             # Run last command starting with 'abc'
```

## Customization

### Change Powerlevel10k Style

```bash
# Run configuration wizard
p10k configure

# Or edit directly
nano ~/.p10k.zsh
```

### Add More Plugins

```bash
# In .zshrc, add after existing plugins:
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search
zinit light MichaelAquilina/zsh-you-should-use
```

**Popular plugins:**
- `fast-syntax-highlighting`: Faster syntax highlighting
- `zsh-history-substring-search`: Search history with arrows
- `zsh-you-should-use`: Reminds you about your aliases
- `zsh-autoenv`: Automatic Python venv activation
- `extract`: Universal extraction function for archives

### Custom Functions

Add to `~/.zshrc`:

```bash
# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Backup a file
backup() {
    cp "$1" "$1.backup-$(date +%Y%m%d-%H%M%S)"
}

# Extract archives
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz) tar xzf "$1" ;;
            *.bz2) bunzip2 "$1" ;;
            *.rar) unrar x "$1" ;;
            *.gz) gunzip "$1" ;;
            *.tar) tar xf "$1" ;;
            *.tbz2) tar xjf "$1" ;;
            *.tgz) tar xzf "$1" ;;
            *.zip) unzip "$1" ;;
            *.Z) uncompress "$1" ;;
            *.7z) 7z x "$1" ;;
            *) echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Quick git commit
gcm() {
    git commit -m "$*"
}
```

### Completion Styling

Already configured in this setup:
- Case-insensitive completion
- Colored completion menu
- FZF preview for cd and zoxide

**Customize further:**
```bash
# In .zshrc
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
```

## FZF Integration

### FZF Keybindings

| Keybinding | Description |
|------------|-------------|
| `Ctrl+R` | Search in command history |
| `Ctrl+T` | Search for files recursively |
| `Alt+C` | Search and cd to directory |

### Using FZF

```bash
# Search history and run
Ctrl+R

# Find and open file in editor
nvim $(fzf)

# Multiselect in FZF
# Press Tab to select multiple files
# Shift+Tab to deselect

# FZF in pipes
ls | fzf
git branch | fzf
```

### FZF Customization

Add to `~/.zshrc`:

```bash
# FZF colors (Rose Pine theme)
export FZF_DEFAULT_OPTS="
--color=fg:#908caa,bg:#232136,hl:#ea9a97
--color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
--color=border:#44415a,header:#3e8fb0,gutter:#232136
--color=spinner:#f6c177,info:#9ccfd8
--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa
"

# FZF default command (requires fd or ripgrep)
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
```

## Zoxide Usage

Zoxide learns your most visited directories:

```bash
# First time: cd normally
cd ~/projects/my-app

# Later: jump directly
cd my-app        # Works from anywhere!

# Interactive search
cdi              # Searches with FZF

# Show database
zoxide query --list

# Remove from database
zoxide remove ~/old-project
```

## Troubleshooting

### Zinit doesn't install

```bash
# Manual installation
mkdir -p ~/.local/share/zinit
git clone https://github.com/zdharma-continuum/zinit.git ~/.local/share/zinit/zinit.git
source ~/.zshrc
```

### Powerlevel10k instant prompt warning

If you get warnings about instant prompt:
```bash
# Clear cache
rm -rf ~/.cache/p10k-*

# Re-run configuration
p10k configure
```

### Plugins load slowly

```bash
# Use Zinit turbo mode
# Add 'wait' to load plugin asynchronously
zinit wait lucid light zsh-users/zsh-syntax-highlighting
```

### Nerd Font icons not showing

1. Install a Nerd Font (see Dependencies)
2. Configure your terminal to use the font
3. Run `p10k configure` again

### FZF doesn't work

```bash
# Verify installation
fzf --version

# Reinstall FZF integration
~/.fzf/install --all

# Source .zshrc again
source ~/.zshrc
```

### Zoxide cd doesn't work

```bash
# Verify installation
zoxide --version

# Check init line in .zshrc
eval "$(zoxide init --cmd cd zsh)"

# Build database by cd'ing around
cd ~/projects
cd ~/documents
# etc...
```

### Autosuggestions not showing

```bash
# Check plugin
zinit list | grep autosuggestions

# Reinstall
zinit delete zsh-users/zsh-autosuggestions
zinit load zsh-users/zsh-autosuggestions
```

### Completion doesn't work

```bash
# Rebuild completion cache
rm -f ~/.zcompdump
compinit

# Reload
source ~/.zshrc
```

## Performance Tips

### Faster Startup

```bash
# Profile startup time
time zsh -i -c exit

# If > 1 second, use zinit turbo mode more:
zinit wait lucid for \
    atinit"zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions
```

### Compact History

```bash
# Remove duplicates from history
sort -u ~/.zsh_history > ~/.zsh_history.tmp
mv ~/.zsh_history.tmp ~/.zsh_history
```

## Useful Commands

### Zinit Management

```bash
zinit self-update              # Update Zinit
zinit update                   # Update all plugins
zinit update zsh-users/zsh-syntax-highlighting  # Update specific plugin
zinit list                     # List installed plugins
zinit delete PLUGIN_NAME       # Remove plugin
```

### Zsh Management

```bash
source ~/.zshrc               # Reload configuration
exec zsh                      # Restart shell
compinit                      # Rebuild completions
rehash                        # Update command cache
```

## Resources

- **Zinit**: [https://github.com/zdharma-continuum/zinit](https://github.com/zdharma-continuum/zinit)
- **Powerlevel10k**: [https://github.com/romkatv/powerlevel10k](https://github.com/romkatv/powerlevel10k)
- **FZF**: [https://github.com/junegunn/fzf](https://github.com/junegunn/fzf)
- **Zoxide**: [https://github.com/ajeetdsouza/zoxide](https://github.com/ajeetdsouza/zoxide)
- **Awesome Zsh Plugins**: [https://github.com/unixorn/awesome-zsh-plugins](https://github.com/unixorn/awesome-zsh-plugins)

## Recommended Additions

### Modern CLI Tools

```bash
# Install modern replacements
# bat - better cat
# exa/eza - better ls
# fd - better find
# ripgrep - better grep
# delta - better git diff

# Ubuntu/Debian
sudo apt install bat exa fd-find ripgrep

# macOS
brew install bat exa fd ripgrep git-delta
```

Then add aliases:
```bash
alias cat='bat'
alias ls='exa --icons'
alias ll='exa -l --icons'
alias la='exa -la --icons'
alias find='fd'
alias grep='rg'
```

## Tips & Tricks

1. **Quick cd**: Just type `cd my-proj` instead of full path thanks to zoxide
2. **History search**: `Ctrl+R` and start typing - FZF shows matching commands
3. **Accept suggestions**: Press `→` to accept gray suggestions
4. **Tab everywhere**: Press Tab often for FZF completion
5. **Vi mode**: `Esc` to go to normal mode and use Vi commands
6. **Ignore history**: Start command with space to not save in history
7. **Quick edit**: `fc` opens last command in editor
8. **Multiple commands**: Use `;` or `&&` between commands

## License

This configuration is free to use and modify.
