# Zsh

Zsh-konfiguration med Powerlevel10k, Zinit för pluginhantering, och moderna terminalverktyg.

## Installation

Kör `install.sh` från repots rot — den skapar symlinken `~/.zshrc → dotfiles/zsh/.zshrc` och installerar alla beroenden.

Vid första start av Zsh installeras Zinit och plugins automatiskt.

**Krav:** En [Nerd Font](https://www.nerdfonts.com/) för Powerlevel10k-ikoner.

## Plugins

| Plugin | Beskrivning |
|--------|-------------|
| powerlevel10k | Snabb och konfigurerbar prompt |
| zsh-syntax-highlighting | Syntaxmarkering i realtid |
| zsh-autosuggestions | Förslag baserade på historik |
| zsh-completions | Extra completions |
| fzf-tab | FZF-integration i tab-completion |

## Verktyg

| Verktyg | Syfte |
|---------|-------|
| **fzf** | Fuzzy-sökning — `Ctrl+R` historik, `Ctrl+T` filer, `Alt+C` mappar |
| **zoxide** | Smart `cd` — lär sig dina vanliga kataloger |

## Keybindings

| Tangent | Aktion |
|---------|--------|
| `Ctrl+J` | Sök bakåt i historik |
| `Ctrl+K` | Sök framåt i historik |
| `Ctrl+R` | FZF-historikssökning |
| `Ctrl+T` | FZF-filsökning |
| `Alt+C` | FZF-katalogsökning |
| `→` | Acceptera autosuggestion |
| `Esc` | Vi-normalläge |

## Aliases

| Alias | Kommando |
|-------|----------|
| `ls` | `ls --color` |
| `c` | `clear` |
| `winhome` | `cd /mnt/c/Users/Johan/` |

## Anpassa prompten

```bash
p10k configure
```

## Felsökning

- **Ikoner visas inte** — kontrollera att Nerd Font är inställd i terminalen
- **Zinit installeras inte** — säkerställ att `git` finns installerat
- **Plugins läser in långsamt** — kör `zinit update` för att uppdatera
- **Zoxide fungerar inte** — kontrollera att `eval "$(zoxide init --cmd cd zsh)"` finns i `.zshrc`
