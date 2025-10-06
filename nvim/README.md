# Neovim Configuration

Modern, modular Neovim configuration built for sharing and customization. Designed to be forked and extended with your own settings without breaking on updates.

## ✨ Features

### 🎨 UI & Themes
- **Rose Pine** - Beautiful colorscheme
- **Lualine** - Clean statusline with git, diagnostics, and file info
- **Which-key** - Interactive keymap hints
- **Oil.nvim** - Modern file explorer (edit directories like buffers)
- **Notify** - Elegant notification system
- **Colorizer** - Live color preview in code

### 🔧 LSP & Development
- **LSP Support** for:
  - TypeScript/JavaScript (ts_ls)
  - Lua (lua_ls)
  - HTML, CSS, JSON
  - ESLint
  - Rust (rust-analyzer via rustaceanvim)
  - C# (roslyn)
- **Mason** - Automatic LSP server installation
- **Conform** - Auto-formatting on save
- **Formatters**: stylua, prettier, csharpier, rustfmt

### 💬 Completion & Snippets
- **nvim-cmp** - Powerful completion engine
- **LuaSnip** - Snippet support
- Sources: LSP, buffer, path, crates.nvim
- **Autopairs** - Auto-close brackets and quotes

### 🔍 Navigation & Search
- **Telescope** - Fuzzy finder for files, grep, buffers, help
- **Harpoon 2** - Quick file navigation and marking
- **Treesitter** - Advanced syntax highlighting and navigation
- **Spectre** - Search and replace across project

### 🐛 Debugging
- **nvim-dap** - Debug Adapter Protocol support
- **DAP UI** - Beautiful debugging interface
- Debug adapters: js-debug-adapter, netcoredbg, codelldb

### 🦀 Language-Specific
- **Rustaceanvim** - Enhanced Rust development
  - Explain errors, render diagnostics
  - Runnables, testables, macro expansion
  - Clippy integration
- **Crates.nvim** - Manage Rust dependencies in Cargo.toml
- **Kulala** - HTTP client for .http files

### 📦 Git Integration
- **Fugitive** - Git commands
- **Gitsigns** - Git decorations, blame, hunk navigation

### 🎯 Editor Enhancements
- **Comment.nvim** - Smart commenting
- **Todo-comments** - Highlight TODO, FIXME, NOTE, etc.
- **Treesitter Context** - Show context of current scope

## 📁 Structure

```
nvim/
├── init.lua                    # Entry point
├── lua/
│   ├── config/                 # Core configuration (tracked in git)
│   │   ├── options.lua         # Vim options (tabstop, numbers, etc.)
│   │   ├── keymaps.lua         # Default keymaps
│   │   └── autocmds.lua        # Autocommands
│   ├── plugins/                # Plugin specifications (tracked in git)
│   │   ├── colorscheme.lua     # Rose Pine theme
│   │   ├── lsp.lua             # LSP, Mason, formatters
│   │   ├── completion.lua      # nvim-cmp, autopairs
│   │   ├── ui.lua              # Lualine, Which-key, Oil, Notify
│   │   ├── editor.lua          # Telescope, Treesitter, Git, Harpoon
│   │   └── tools.lua           # DAP, Kulala
│   └── user/                   # User overrides (gitignored)
│       ├── keymaps.lua.example # Custom keymaps template
│       ├── options.lua.example # Custom options template
│       └── plugins.lua.example # Custom plugins template
└── .gitignore                  # Excludes user/* except *.example
```

## 🚀 Installation

```bash
# Backup your current config
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this config
git clone <your-repo-url> ~/.config/nvim

# Start Neovim (plugins will auto-install)
nvim
```

## 🎨 Customization

The config is designed so you can pull updates without losing your custom settings.

### Add Custom Keymaps

```bash
cd ~/.config/nvim/lua/user
cp keymaps.lua.example keymaps.lua
nvim keymaps.lua
```

Example:
```lua
local map = vim.keymap.set
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
```

### Override Options

```bash
cd ~/.config/nvim/lua/user
cp options.lua.example options.lua
nvim options.lua
```

Example:
```lua
vim.o.tabstop = 2
vim.o.shiftwidth = 2
```

### Add Custom Plugins

```bash
cd ~/.config/nvim/lua/user
cp plugins.lua.example plugins.lua
nvim plugins.lua
```

Example:
```lua
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      vim.cmd("colorscheme catppuccin")
    end,
  },
}
```

## 🔄 Updates

Pull the latest changes without affecting your custom config:

```bash
cd ~/.config/nvim
git pull
```

Your `lua/user/` files are gitignored and won't be overwritten.

## ⌨️ Keybindings

Leader key: `<Space>`

### General Navigation
| Key | Action |
|-----|--------|
| `<Esc>` | Clear search highlighting |
| `j` / `k` | Move by visual lines (when no count) |
| `<C-h/j/k/l>` | Navigate between windows |
| `<S-h>` | Previous buffer |
| `<S-l>` | Next buffer |
| `<leader>bd` | Close buffer |

### Visual Mode
| Key | Action |
|-----|--------|
| `<` / `>` | Indent left/right (stays in visual mode) |
| `J` | Move selected lines down |
| `K` | Move selected lines up |

### File Explorer (Oil.nvim)
| Key | Action |
|-----|--------|
| `<leader>pv` | Open parent directory in Oil |
| `-` | Go to parent directory |
| `<CR>` | Select/open file or directory |
| `<C-s>` | Open in vertical split |
| `<C-h>` | Open in horizontal split |
| `g.` | Toggle hidden files |

### Telescope (Fuzzy Finder)
| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search in files) |
| `<leader>fb` | Find buffers |
| `<leader>fh` | Help tags |
| `<leader>fd` | Diagnostics |

### Harpoon (Quick Navigation)
| Key | Action |
|-----|--------|
| `<leader>H` | Add file to Harpoon |
| `<leader>h` | Toggle Harpoon menu |
| `<leader>1-5` | Jump to Harpoon file 1-5 |

### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `<C-h>` (insert) | Signature help |
| `<leader>ca` | Code action |
| `<leader>cr` | Rename symbol |
| `<leader>cf` | Format code |

### Git (Gitsigns)
| Key | Action |
|-----|--------|
| `<leader>gp` | Preview hunk |
| `<leader>gt` | Toggle line blame |
| `<leader>gb` | Show full blame for line |
| `]c` | Next git hunk |
| `[c` | Previous git hunk |

### Search & Replace (Spectre)
| Key | Action |
|-----|--------|
| `<leader>S` | Toggle Spectre |
| `<leader>sw` | Search current word (n/v) |
| `<leader>sp` | Search in current file |

### Debugging (DAP)
| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Continue |
| `<leader>dsi` | Step into |
| `<leader>dso` | Step over |
| `<leader>dsO` | Step out |
| `<leader>dr` | Open REPL |
| `<leader>dl` | Run last |
| `<leader>dt` | Terminate |
| `<leader>du` | Toggle DAP UI |

### Rust (Rustaceanvim)
| Key | Action |
|-----|--------|
| `<leader>re` | Explain error |
| `<leader>rd` | Render diagnostic |
| `<leader>rc` | Open Cargo.toml |
| `<leader>rp` | Go to parent module |
| `<leader>rj` | Join lines |
| `<leader>rh` | Hover actions |
| `<leader>rm` | Expand macro |
| `<leader>rr` | Runnables |
| `<leader>rt` | Testables |

### HTTP Client (Kulala)
| Key | Action |
|-----|--------|
| `<leader>kr` | Run HTTP request |
| `<leader>kp` | Paste from curl command |
| `<leader>kc` | Copy as curl |
| `<leader>ki` | Inspect request |
| `<leader>kt` | Toggle response/headers view |

### Comments
| Key | Action |
|-----|--------|
| `gc` | Toggle line comment (n/v) |
| `gb` | Toggle block comment (n/v) |

## 🛠️ Default Settings

- **Leader key**: Space
- **Tab width**: 4 spaces
- **Scroll offset**: 20 lines
- **Line numbers**: Relative + absolute
- **Clipboard**: System clipboard integration
- **Format on save**: Enabled
- **Word wrap**: Enabled with smart indent

## 📝 Tips

- Press `<Space>` and wait to see all available keybindings (Which-key)
- Use `:Mason` to manage LSP servers and tools
- Use `:Lazy` to manage plugins
- Telescope is your friend - `<leader>ff` and `<leader>fg` are the most used commands
- Harpoon is great for jumping between 2-5 frequently used files

## 🤝 Contributing

Feel free to fork this config and make it your own! If you have improvements to the core config, PRs are welcome.

## 📄 License

MIT
