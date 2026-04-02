# Neovim

Modulär Neovim-konfiguration i Lua med LSP, completion, fuzzy finding och debugging.

## Installation

Kör `install.sh` från repots rot — den skapar symlinken `~/.config/nvim → dotfiles/nvim`.

Vid första start av Neovim installeras alla plugins automatiskt via Lazy, och alla LSP-servrar, formatters och debuggers via Mason.

**Krav:** Neovim 0.10+, en [Nerd Font](https://www.nerdfonts.com/) i terminalen.

## Språkstöd

| Språk | LSP | Formatter | Debugger |
|-------|-----|-----------|----------|
| TypeScript/JavaScript | ts_ls, eslint | prettier | js-debug-adapter |
| Rust | rust-analyzer | rustfmt | codelldb |
| Go | gopls | goimports | delve |
| Python | pyright | ruff | debugpy |
| C# | roslyn | csharpier | netcoredbg |
| Dart/Flutter | dart | dart_format | — |
| Gleam | gleam | gleam_format | — |
| Svelte | svelte | prettier | — |
| Lua | lua_ls | stylua | — |
| HTML/CSS/JSON/YAML | html, cssls, jsonls, yamlls | prettier | — |

## Viktigaste keybindings

Leader-knappen är `Space`. Tryck och vänta för att se alla tillgängliga kommandon via which-key.

| Tangent | Aktion |
|---------|--------|
| `Space ff` | Hitta filer |
| `Space fg` | Sök i filer (grep) |
| `Space pv` | Filutforskaren (Oil) |
| `Space h` | Harpoon-menyn |
| `Space H` | Lägg till fil i Harpoon |
| `Space 1–5` | Hoppa till Harpoon-fil |
| `gd` | Gå till definition |
| `gr` | Gå till referenser |
| `K` | Hover-dokumentation |
| `Space ca` | Kodåtgärder |
| `Space cr` | Byt namn på symbol |
| `gc` | Kommentera/avkommentera |

## Kommandon

| Kommando | Aktion |
|----------|--------|
| `:Mason` | Hantera LSP-servrar och verktyg |
| `:Lazy` | Hantera plugins |
| `:checkhealth` | Diagnostik |

## Felsökning

- **Plugins installeras inte** — kör `:Lazy sync`
- **LSP fungerar inte** — kör `:Mason` och kontrollera med `:LspInfo`
- **Brutna ikoner** — installera en Nerd Font och konfigurera terminalen att använda den
