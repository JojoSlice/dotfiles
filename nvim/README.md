# Neovim Configuration

A modern, modular Neovim setup with LSP, completion, fuzzy finding, and debugging out of the box.

## Prerequisites

- [Neovim](https://neovim.io/) 0.9+ (0.10+ recommended)
- [Git](https://git-scm.com/)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (for live grep search)
- A [Nerd Font](https://www.nerdfonts.com/) (for icons)

## Installation

```bash
# 1. Backup existing config (if any)
mv ~/.config/nvim ~/.config/nvim.backup

# 2. Clone this config
git clone <your-repo-url> ~/.config/nvim

# 3. Start Neovim (plugins install automatically)
nvim
```

## Getting Started

Leader key is `Space`. Press it and wait to see all available keybindings via which-key.

### Essential Keybindings

| Key | Action |
|-----|--------|
| `Space` | Leader key (wait to see all options) |
| `Space ff` | Find files |
| `Space fg` | Search in files (grep) |
| `Space pv` | File explorer (Oil) |
| `gd` | Go to definition |
| `gr` | Go to references |
| `K` | Hover documentation |
| `Space ca` | Code actions |
| `Space cr` | Rename symbol |
| `gc` | Toggle comment |
| `Space h` | Harpoon menu (quick file switching) |

### Useful Commands

| Command | Action |
|---------|--------|
| `:Mason` | Manage LSP servers and tools |
| `:Lazy` | Manage plugins |
| `:checkhealth` | Diagnose issues |

## Features

- **LSP** - Language server support with auto-completion (TypeScript, Lua, Rust, C#, HTML, CSS, JSON, Svelte, YAML, Gleam)
- **Completion** - nvim-cmp with LSP, snippets, and path completion
- **Fuzzy Finder** - Telescope for files, grep, buffers, and help
- **File Explorer** - Oil.nvim (edit directories like buffers)
- **Git** - Fugitive and Gitsigns for git integration
- **Debugging** - DAP support with UI for multiple languages
- **Formatting** - Auto-format on save via Conform

## Customization

Your customizations live in `lua/user/` and are gitignored, so you can pull updates without conflicts.

```bash
cd ~/.config/nvim/lua/user

# Add custom keymaps
cp keymaps.lua.example keymaps.lua

# Override options
cp options.lua.example options.lua

# Add plugins
cp plugins.lua.example plugins.lua
```

## Troubleshooting

**Plugins not loading?**
Run `:Lazy sync` to install/update all plugins.

**LSP not working?**
Run `:Mason` to install language servers, then `:LspInfo` to check status.

**Icons look broken?**
Install a [Nerd Font](https://www.nerdfonts.com/) and configure your terminal to use it.

**General issues?**
Run `:checkhealth` for a full diagnostic report.

## Tips

- Press `Space` and wait to discover keybindings with which-key
- Use `Space 1` through `Space 5` to jump to Harpoon-marked files
- `Space H` adds current file to Harpoon
- Telescope searches respect `.gitignore` by default

## License

MIT
