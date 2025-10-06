# Zsh Configuration

En kraftfull Zsh-konfiguration med Powerlevel10k prompt, intelligenta plugins och moderna utvecklarverktyg för en produktiv terminal-upplevelse.

## Innehåll

- [Installation](#installation)
  - [Zsh](#zsh)
  - [Dependencies](#dependencies)
- [Konfiguration](#konfiguration)
- [Funktioner](#funktioner)
- [Plugins](#plugins)
- [Keybindings](#keybindings)
- [Aliases](#aliases)
- [Anpassning](#anpassning)
- [Felsökning](#felsökning)

## Installation

### Zsh

#### Windows (WSL)

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install zsh

# Sätt Zsh som default shell
chsh -s $(which zsh)
```

#### macOS

```bash
# Zsh är redan installerat på moderna macOS
# För att uppdatera till senaste versionen:
brew install zsh

# Sätt som default shell
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

# Sätt som default shell
chsh -s $(which zsh)
```

**Verifiera installation:**
```bash
zsh --version
echo $SHELL  # Ska visa /bin/zsh eller liknande
```

### Dependencies

#### Git (Obligatorisk för Zinit)

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

**Cargo (alternativ för alla plattformar):**
```bash
car<ctrl62>## Plugins

### Installerade Plugins

| Plugin | Beskrivning |
|--------|-------------|
| **powerlevel10k** | Modern, snabb och anpassningsbar prompt |
| **zsh-syntax-highlighting** | Realtids syntax highlighting |
| **zsh-completions** | Ytterligare completions för vanliga kommandon |
| **zsh-autosuggestions** | Förslag baserat på tidigare kommandon |
| **fzf-tab** | Fuzzy finder integration för tab-completion |

### Oh My Zsh Snippets

| Snippet | Beskrivning |
|---------|-------------|
| **command-not-found** | Föreslår paket när kommando inte hittas |

## Keybindings

### Vi Mode Keybindings

Grundläggande Vi-navigation är aktiverad (`bindkey -v`):

| Mode | Keybinding | Beskrivning |
|------|------------|-------------|
| Normal | `h/j/k/l` | Navigera i kommandot |
| Normal | `w/b/e` | Hoppa mellan ord |
| Normal | `0/$` | Början/slut av rad |
| Normal | `dd` | Radera rad |
| Normal | `cc` | Ändra rad |
| Insert | `Esc` | Gå till normal mode |

### Custom Keybindings

| Keybinding | Beskrivning |
|------------|-------------|
| `Ctrl+J` | Sök bakåt i historik |
| `Ctrl+K` | Sök framåt i historik |
| `Ctrl+R` | FZF historik-sökning (från FZF integration) |
| `Ctrl+T` | FZF fil-sökning (från FZF integration) |
| `Alt+C` | FZF katalog-sökning (från FZF integration) |
| `Tab` | FZF tab-completion |

### Autosuggestions

| Keybinding | Beskrivning |
|------------|-------------|
| `→` (högerpil) | Acceptera hela förslaget |
| `Ctrl+→` | Acceptera ett ord från förslaget |
| `Ctrl+E` | Acceptera hela förslaget (alternativ) |

## Aliases

### Standard Aliases

| Alias | Kommando | Beskrivning |
|-------|----------|-------------|
| `winhome` | `cd /mnt/c/Users/Johan/` | Gå till Windows home (WSL) |
| `ls` | `ls --color` | Färgad ls-output |
| `c` | `clear` | Rensa skärmen |

### Lägg Till Fler Aliases

Lägg till i `~/.zshrc`:

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
alias cat='bat'  # Om du har bat installerat
alias find='fd'  # Om du har fd installerat

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

### Konfigurerade Inställningar

```bash
HISTSIZE=5000              # 5000 kommandon i minnet
SAVEHIST=5000              # 5000 kommandon sparade
HISTFILE=~/.zsh_history    # Historik-fil
```

### History Beteende

- `appendhistory`: Lägg till istället för att skriva över
- `sharehistory`: Dela historik mellan sessioner
- `hist_ignore_space`: Ignorera kommandon som börjar med mellanslag
- `hist_ignore_all_dups`: Ta bort alla duplicerade kommandon
- `hist_save_no_dups`: Spara inte duplicerade kommandon
- `hist_find_no_dups`: Visa inte duplicerade kommandon vid sökning

### Använda Historik

```bash
# Sök i historik
Ctrl+R           # FZF fuzzy search

# Vi mode historik
Ctrl+J           # Föregående matchande kommando
Ctrl+K           # Nästa matchande kommando

# Traditionell historik
history          # Visa all historik
history 20       # Visa senaste 20
!!               # Kör senaste kommandot
!$               # Senaste argumentet från förra kommandot
!abc             # Kör senaste kommando som började med 'abc'
```

## Anpassning

### Ändra Powerlevel10k Stil

```bash
# Kör konfigurationsguide
p10k configure

# Eller redigera direkt
nano ~/.p10k.zsh
```

### Lägg Till Fler Plugins

```bash
# I .zshrc, lägg till efter befintliga plugins:
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search
zinit light MichaelAquilina/zsh-you-should-use
```

**Populära plugins:**
- `fast-syntax-highlighting`: Snabbare syntax highlighting
- `zsh-history-substring-search`: Sök i historik med pilar
- `zsh-you-should-use`: Påminner dig om dina aliases
- `zsh-autoenv`: Automatisk aktivering av Python venv
- `extract`: Universell extraktions-funktion för arkiv

### Custom Funktioner

Lägg till i `~/.zshrc`:

```bash
# Skapa katalog och cd till den
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Backup av fil
backup() {
    cp "$1" "$1.backup-$(date +%Y%m%d-%H%M%S)"
}

# Extract arkiv
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

# Snabb git commit
gcm() {
    git commit -m "$*"
}
```

### Completion Styling

Redan konfigurerat i denna setup:
- Case-insensitive completion
- Färgad completion-meny
- FZF preview för cd och zoxide

**Anpassa ytterligare:**
```bash
# I .zshrc
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
```

## FZF Integration

### FZF Keybindings

| Keybinding | Beskrivning |
|------------|-------------|
| `Ctrl+R` | Sök i command history |
| `Ctrl+T` | Sök efter filer rekursivt |
| `Alt+C` | Sök och cd till katalog |

### Använda FZF

```bash
# Sök i historik och kör
Ctrl+R

# Hitta och öppna fil i editor
nvim $(fzf)

# Multiselect i FZF
# Tryck Tab för att markera flera filer
# Shift+Tab för att avmarkera

# FZF i pipes
ls | fzf
git branch | fzf
```

### FZF Customization

Lägg till i `~/.zshrc`:

```bash
# FZF colors (Rose Pine tema)
export FZF_DEFAULT_OPTS="
--color=fg:#908caa,bg:#232136,hl:#ea9a97
--color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
--color=border:#44415a,header:#3e8fb0,gutter:#232136
--color=spinner:#f6c177,info:#9ccfd8
--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa
"

# FZF default command (kräver fd eller ripgrep)
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
```

## Zoxide Usage

Zoxide lär sig dina mest besökta kataloger:

```bash
# Första gången: cd normalt
cd ~/projekt/my-app

# Senare: hoppa direkt
cd my-app        # Fungerar från var som helst!

# Interaktiv sökning
cdi              # Söker med FZF

# Visa databas
zoxide query --list

# Ta bort från databas
zoxide remove ~/old-project
```

## Felsökning

### Zinit installeras inte

```bash
# Manuell installation
mkdir -p ~/.local/share/zinit
git clone https://github.com/zdharma-continuum/zinit.git ~/.local/share/zinit/zinit.git
source ~/.zshrc
```

### Powerlevel10k instant prompt varning

Om du får varningar om instant prompt:
```bash
# Rensa cache
rm -rf ~/.cache/p10k-*

# Kör om konfiguration
p10k configure
```

### Plugins laddar långsamt

```bash
# Använd Zinit turbo mode
# Lägg till 'wait' för att ladda plugin asynkront
zinit wait lucid light zsh-users/zsh-syntax-highlighting
```

### Nerd Font ikoner visas inte

1. Installera en Nerd Font (se Dependencies)
2. Konfigurera din terminal att använda fonten
3. Kör `p10k configure` igen

### FZF fungerar inte

```bash
# Verifiera installation
fzf --version

# Reinstallera FZF integration
~/.fzf/install --all

# Source .zshrc igen
source ~/.zshrc
```

### Zoxide cd fungerar inte

```bash
# Verifiera installation
zoxide --version

# Kontrollera init line i .zshrc
eval "$(zoxide init --cmd cd zsh)"

# Bygg databas genom att cd:a runt
cd ~/projekt
cd ~/dokument
# etc...
```

### Autosuggestions visas inte

```bash
# Kontrollera plugin
zinit list | grep autosuggestions

# Återinstallera
zinit delete zsh-users/zsh-autosuggestions
zinit load zsh-users/zsh-autosuggestions
```

### Completion fungerar inte

```bash
# Återbygg completion cache
rm -f ~/.zcompdump
compinit

# Reload
source ~/.zshrc
```

## Performance Tips

### Snabbare Start

```bash
# Profiliera startup-tid
time zsh -i -c exit

# Om > 1 sekund, använd zinit turbo mode mer:
zinit wait lucid for \
    atinit"zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions
```

### Kompaktera History

```bash
# Ta bort duplicates från historik
sort -u ~/.zsh_history > ~/.zsh_history.tmp
mv ~/.zsh_history.tmp ~/.zsh_history
```

## Användbara Kommandon

### Zinit Management

```bash
zinit self-update              # Uppdatera Zinit
zinit update                   # Uppdatera alla plugins
zinit update zsh-users/zsh-syntax-highlighting  # Uppdatera specifik plugin
zinit list                     # Lista installerade plugins
zinit delete PLUGIN_NAME       # Ta bort plugin
```

### Zsh Management

```bash
source ~/.zshrc               # Reload konfiguration
exec zsh                      # Starta om shell
compinit                      # Återbygg completions
rehash                        # Uppdatera command cache
```

## Resurser

- **Zinit**: [https://github.com/zdharma-continuum/zinit](https://github.com/zdharma-continuum/zinit)
- **Powerlevel10k**: [https://github.com/romkatv/powerlevel10k](https://github.com/romkatv/powerlevel10k)
- **FZF**: [https://github.com/junegunn/fzf](https://github.com/junegunn/fzf)
- **Zoxide**: [https://github.com/ajeetdsouza/zoxide](https://github.com/ajeetdsouza/zoxide)
- **Awesome Zsh Plugins**: [https://github.com/unixorn/awesome-zsh-plugins](https://github.com/unixorn/awesome-zsh-plugins)

## Rekommenderade Tillägg

### Modern CLI Tools

```bash
# Installera moderna replacements
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

Lägg sedan till aliases:
```bash
alias cat='bat'
alias ls='exa --icons'
alias ll='exa -l --icons'
alias la='exa -la --icons'
alias find='fd'
alias grep='rg'
```

## Tips & Tricks

1. **Snabb cd**: Skriv bara `cd my-proj` istället för full sökväg tack vare zoxide
2. **History search**: `Ctrl+R` och börja skriva - FZF visar matchande kommandon
3. **Accept suggestions**: Tryck `→` för att acceptera grå förslag
4. **Tab everywhere**: Tryck Tab ofta för FZF completion
5. **Vi mode**: `Esc` för att gå till normal mode och använda Vi-kommandon
6. **Ignore history**: Starta kommando med mellanslag för att inte spara i historik
7. **Quick edit**: `fc` öppnar senaste kommandot i editor
8. **Multiple commands**: Använd `;` eller `&&` mellan kommandon

## Licens

Denna konfiguration är fri att använda och modifiera.
