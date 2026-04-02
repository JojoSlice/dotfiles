# Dotfiles

Konfigurationsfiler för Neovim, Tmux och Zsh.

## Snabbstart

```bash
git clone <repo-url> ~/dev/dotfiles
cd ~/dev/dotfiles
bash install.sh
```

Skriptet sätter upp symlinks, installerar beroenden och SDKer. Se nedan för vad som ingår.

## Vad installeras

**Symlinks**
| Fil | Destination |
|-----|-------------|
| `nvim/` | `~/.config/nvim` |
| `tmux/.tmux.conf` | `~/.tmux.conf` |
| `zsh/.zshrc` | `~/.zshrc` |

**Systemverktyg**
- Neovim (senaste stabila), Tmux, Zsh
- ripgrep, fd, fzf, zoxide
- Linuxbrew

**Språk-SDKer**
- Node.js (via NVM)
- Rust (via rustup)
- Go
- .NET 10
- Flutter + Dart
- Gleam (via Homebrew)

Alla LSP-servrar, formatters och debuggers installeras automatiskt av Mason när Neovim startas första gången.

## Konfigurationer

- [Neovim](./nvim/README.md)
- [Zsh](./zsh/README.md)
- Tmux — se kommentarer i `tmux/.tmux.conf`

## Uppdatera

```bash
cd ~/dev/dotfiles
git pull
```

Eftersom konfigfilerna är symlänkade gäller ändringar direkt utan att köra om installationen.
