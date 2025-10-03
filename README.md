# Jojo's dotFiles

Detta är en samling av mina konfigurationer. Vissa uppdateras ofta, andra mer sällan.

Om du vill kan du följa mina uppdateringar genom att skapa en symbolisk länk från filerna i detta repo till den katalog där respektive config normalt ligger.

Ett problem som jag planerar att åtgärda framöver är att vissa inställningar är hårdkodade för min egen dator. Till exempel pekar bakgrundsbilden i WezTerm på en fil som bara finns hos mig. Dessutom kommer eventuella anpassningar du själv gör att skrivas över vid varje git pull. Min ambition är att göra konfigurationerna mer modulära i framtiden.

Jag kommer även lägga upp fler configs för andra verktyg och program som jag använder, när tid, ork och lust finns.

Du kan använda en eller flera av dessa configs precis som du vill – de är helt fristående från varandra.



## Konfigurationer

Här hittar du både installationsguider och tips på hur du kan anpassa varje konfiguration efter dina egna behov.

- [Neovim Configuration](#neovim-configuration)  
  Min editor-setup för Neovim, med plugins, keybinds och inställningar för ett smidigare arbetsflöde.  

- [WezTerm Configuration](#wezterm-configuration)  
  Inställningar för terminalemulatorn WezTerm, inklusive teman, typsnitt och layout.  

- [Zsh Configuration](#zsh-configuration)  
  Min konfiguration för Zsh-skalet, med alias, prompt-anpassningar och plugin-hantering.  




# Neovim Configuration

En modern Neovim-konfiguration med LSP, autocompletion, debugging och formatering för webbutveckling och C#.

## Innehåll

- [Installation](#installation)
  - [Neovim](#neovim)
  - [Kompilator (Treesitter)](#kompilator-treesitter)
  - [Dependencies](#dependencies)
- [Konfiguration](#konfiguration)
- [Funktioner](#funktioner)
- [Keybindings](#keybindings)
- [Plugins](#plugins)

## Installation

### Neovim

#### Windows (Scoop)

```powershell
# Installera Scoop om du inte har det
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex

# Installera Neovim 0.11+
scoop install neovim
```

#### Windows (Chocolatey)

```powershell
choco install neovim
```

#### Windows (GitHub Releases)

1. Ladda ner senaste versionen från [Neovim Releases](https://github.com/neovim/neovim/releases)
2. Extrahera till valfri plats (t.ex. `C:\Program Files\Neovim`)
3. Lägg till i PATH

#### macOS (Homebrew)

```bash
brew install neovim
```

#### Linux (Ubuntu/Debian)

```bash
# Via APT (kan vara äldre version)
sudo apt install neovimG

# Eller via snap för senaste versionen
sudo snap install nvim --classic

# Eller bygg från källa för 0.11+
```

#### Linux (Arch)

```bash
sudo pacman -S neovim
```

### Kompilator (Treesitter)

Treesitter behöver en C-kompilator för att bygga parsers. Välj ett av följande:

#### Clang

**Windows (Scoop):**
```powershell
scoop install llvm
```

**Windows (Chocolatey):**
```powershell
choco install llvm
```

**macOS:**
```bash
# Ingår i Xcode Command Line Tools
xcode-select --install
```

**Linux:**
```bash
# Ubuntu/Debian
sudo apt install clang

# Arch
sudo pacman -S clang
```

#### Zig (Alternativ)

**Windows (Scoop):**
```powershell
scoop install zig
```

**macOS:**
```bash
brew install zig
```

**Linux:**
```bash
# Ladda ner från https://ziglang.org/download/
```

### Dependencies

#### Git

**Windows (Scoop):**
```powershell
scoop install git
```

**macOS:**
```bash
brew install git
```

**Linux:**
```bash
sudo apt install git  # Ubuntu/Debian
sudo pacman -S git    # Arch
```

#### Node.js (för LSP-servrar)

**Windows (Scoop):**
```powershell
scoop install nodejs
```

**macOS:**
```bash
brew install node
```

**Linux:**
```bash
# Ubuntu/Debian
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install nodejs

# Arch
sudo pacman -S nodejs npm
```

#### Ripgrep (för Telescope live_grep)

**Windows (Scoop):**
```powershell
scoop install ripgrep
```

**macOS:**
```bash
brew install ripgrep
```

**Linux:**
```bash
sudo apt install ripgrep  # Ubuntu/Debian
sudo pacman -S ripgrep    # Arch
```

#### .NET SDK (för C#-utveckling)

**Windows:**
```powershell
scoop install dotnet-sdk
# eller från https://dotnet.microsoft.com/download
```

**macOS:**
```bash
brew install dotnet-sdk
```

**Linux:**
```bash
# Följ instruktioner på https://docs.microsoft.com/dotnet/core/install/linux
```

#### Nerd Font (valfritt men rekommenderat)

För bästa visuella upplevelse med ikoner:

**Windows (Scoop):**
```powershell
scoop bucket add nerd-fonts
scoop install FiraCode-NF
```

**macOS/Linux:**
1. Ladda ner från [Nerd Fonts](https://www.nerdfonts.com/)
2. Installera fonten (t.ex. FiraCode Nerd Font)
3. Konfigurera din terminal att använda fonten

## Konfiguration

### Installation av config

1. **Hitta Neovim config-katalogen:**

   **Windows:**
   ```
   %LOCALAPPDATA%\nvim\
   ```

   **macOS/Linux:**
   ```
   ~/.config/nvim/
   ```

2. **Skapa config-filen:**

   **Windows (PowerShell):**
   ```powershell
   New-Item -ItemType Directory -Force -Path "$env:LOCALAPPDATA\nvim"
   # Kopiera din init.lua till denna katalog
   ```

   **macOS/Linux:**
   ```bash
   mkdir -p ~/.config/nvim
   # Kopiera din init.lua till denna katalog
   ```

3. **Starta Neovim:**

   ```bash
   nvim
   ```

   Vid första starten kommer Lazy.nvim att installeras automatiskt och alla plugins kommer att laddas ner. Detta kan ta några minuter.

4. **Verifiera installation:**

   I Neovim, kör:
   ```vim
   :checkhealth
   ```

   Detta visar eventuella problem med din setup.

## Funktioner

### Language Support

- **JavaScript/TypeScript**: Full LSP-support med ts_ls
- **C#**: Roslyn LSP med debugger-support
- **HTML/CSS**: Formatting och completion
- **Lua**: Konfigurerad för Neovim-utveckling
- **JSON**: Syntax och validation

### Core Features

- **LSP**: Autocompletion, go-to-definition, hover docs, refactoring
- **Formatting**: Automatisk formatering vid save
- **Debugging**: DAP-support för JavaScript och C#
- **Git Integration**: Gitsigns för inline git-ändringar
- **Fuzzy Finding**: Telescope för filer, buffers, grep
- **Syntax Highlighting**: Treesitter för förbättrad syntax
- **REST Client**: Kulala för HTTP-requests direkt i Neovim

## Keybindings

Leader key är `Space`.

### Allmänt

| Keybinding | Beskrivning |
|------------|-------------|
| `<Space>pv` | Öppna filutforskare (Lexplore) |
| `j`/`k` | Hoppa visuella rader (utan count) |
| `<C-h/j/k/l>` | Navigera mellan fönster |
| `<`/`>` | Indentera i visual mode (behåller selection) |
| `J`/`K` (visual) | Flytta rader upp/ner |

### Telescope (Fuzzy Finder)

| Keybinding | Beskrivning |
|------------|-------------|
| `<Space>ff` | Hitta filer |
| `<Space>fg` | Live grep (sök i filer) |
| `<Space>fb` | Hitta buffers |
| `<Space>fh` | Hjälp-taggar |
| `<Space>fd` | Diagnostics |

### Harpoon (Snabb filnavigering)

| Keybinding | Beskrivning |
|------------|-------------|
| `<Space>H` | Lägg till fil i Harpoon |
| `<Space>h` | Öppna Harpoon-menyn |
| `<Space>1-5` | Hoppa till Harpoon-fil 1-5 |

### LSP

| Keybinding | Beskrivning |
|------------|-------------|
| `gd` | Gå till definition |
| `gr` | Hitta referenser |
| `gi` | Gå till implementation |
| `K` | Visa hover-dokumentation |
| `<Space>ca` | Code actions |
| `<Space>rn` | Rename symbol |
| `<Space>f` | Formatera fil |
| `<C-h>` (insert) | Signature help |

### Debugging (DAP)

| Keybinding | Beskrivning |
|------------|-------------|
| `<Space>db` | Toggle breakpoint |
| `<Space>dc` | Continue/Start debugging |
| `<Space>dsi` | Step into |
| `<Space>dso` | Step over |
| `<Space>dsO` | Step out |
| `<Space>dr` | Öppna REPL |
| `<Space>dt` | Terminate debugging |
| `<Space>du` | Toggle DAP UI |

### Git (Gitsigns)

| Keybinding | Beskrivning |
|------------|-------------|
| `<Space>gp` | Preview hunk |
| `<Space>gt` | Toggle blame line |
| `<Space>gb` | Visa full blame |
| `]c` | Nästa hunk |
| `[c` | Föregående hunk |

### REST Client (Kulala)

| Keybinding | Beskrivning |
|------------|-------------|
| `<Space>rr` | Kör HTTP-request |
| `<Space>rp` | Importera från curl |
| `<Space>rc` | Kopiera som curl |
| `<Space>ri` | Inspektera request |
| `<Space>rt` | Toggle response/headers |

### Search & Replace (Spectre)

| Keybinding | Beskrivning |
|------------|-------------|
| `<Space>S` | Toggle Spectre |
| `<Space>sw` | Sök aktuellt ord |
| `<Space>sp` | Sök i aktuell fil |

### Completion

| Keybinding | Beskrivning |
|------------|-------------|
| `<C-Space>` | Trigga completion |
| `<C-y>` | Bekräfta completion |
| `<Tab>` | Nästa item/expand snippet |
| `<S-Tab>` | Föregående item |

## Plugins

### Core Plugins

- **lazy.nvim**: Plugin manager
- **rose-pine**: Colorscheme
- **nvim-lspconfig**: LSP-konfiguration
- **mason.nvim**: LSP/formatter installer
- **nvim-cmp**: Autocompletion
- **telescope.nvim**: Fuzzy finder
- **nvim-treesitter**: Syntax highlighting
- **harpoon**: Snabb filnavigering

### Development Tools

- **nvim-dap**: Debugging
- **conform.nvim**: Code formatting
- **gitsigns.nvim**: Git integration
- **vim-fugitive**: Git commands
- **kulala.nvim**: REST client
- **nvim-spectre**: Search & replace

### UI Enhancements

- **lualine.nvim**: Statusline
- **nvim-web-devicons**: File icons
- **nvim-notify**: Notifications
- **nvim-autopairs**: Auto-close brackets
- **Comment.nvim**: Smart commenting
- **treesitter-context**: Show context

## Formatters & LSP Servers

Följande installeras automatiskt via Mason:

### Formatters
- stylua (Lua)
- prettier (JS/TS/HTML/CSS/JSON)
- csharpier (C#)

### LSP Servers
- typescript-language-server
- lua-language-server
- html-lsp
- css-lsp
- eslint-lsp
- json-lsp
- roslyn (C#) - installeras separat för .cs-filer

### Debug Adapters
- js-debug-adapter
- netcoredbg

## Felsökning

### Treesitter fungerar inte

```vim
:checkhealth nvim-treesitter
```

Om kompilator saknas, installera clang eller zig (se ovan).

### LSP startar inte

```vim
:LspInfo
```

Kontrollera att Mason har installerat rätt LSP-server:

```vim
:Mason
```

### Plugins laddas inte

```vim
:Lazy sync
```

### Formatering fungerar inte

Kontrollera att formatter är installerad:

```vim
:Mason
```

## Tips & Tricks

1. **Uppdatera plugins**: `:Lazy sync`
2. **Installera ytterligare LSP-servrar**: `:Mason`
3. **Se tillgängliga keybindings**: `<Space>` och vänta en stund (via which-key om du lägger till det)
4. **Rensa Treesitter cache**: `:TSUpdate`
5. **Testa HTTP-requests**: Skapa en `.http`-fil och använd Kulala-kommandon

## Anpassning

Alla inställningar finns i `init.lua`. Vanliga anpassningar:

- **Ändra colorscheme**: Modifiera `vim.cmd 'colorscheme rose-pine'`
- **Tab-width**: Ändra `vim.o.tabstop` och `vim.o.shiftwidth`
- **Leader key**: Ändra `vim.g.mapleader`
- **Lägg till LSP-servrar**: Uppdatera Mason-konfigurationen

## Support

För problem med:
- **Neovim**: [Neovim GitHub](https://github.com/neovim/neovim)
- **Plugins**: Se respektive plugins GitHub-repo
- **Denna config**: Kontrollera `:checkhealth` först

## Licens

Denna konfiguration är fri att använda och modifiera.




# WezTerm Configuration

En modern och visuellt tilltalande WezTerm-konfiguration med Rose Pine Moon colorscheme, custom tabbar och avancerad fönsterhantering.

## Innehåll

- [Installation](#installation)
  - [WezTerm](#wezterm)
  - [Dependencies](#dependencies)
- [Konfiguration](#konfiguration)
- [Funktioner](#funktioner)
- [Keybindings](#keybindings)
- [Anpassning](#anpassning)
- [Felsökning](#felsökning)

## Installation

### WezTerm

#### Windows (Scoop)

```powershell
scoop install wezterm
```

#### Windows (Chocolatey)

```powershell
choco install wezterm
```

#### Windows (WinGet)

```powershell
winget install wez.wezterm
```

#### Windows (Manuell installation)

1. Ladda ner senaste versionen från [WezTerm Releases](https://github.com/wez/wezterm/releases)
2. Installera `.exe`-filen
3. WezTerm läggs automatiskt till i PATH

#### macOS (Homebrew)

```bash
brew install --cask wezterm
```

#### Linux (Ubuntu/Debian)

```bash
# Ladda ner .deb från releases
curl -LO https://github.com/wez/wezterm/releases/download/nightly/wezterm-nightly.Ubuntu22.04.deb
sudo apt install ./wezterm-nightly.Ubuntu22.04.deb
```

#### Linux (Arch)

```bash
sudo pacman -S wezterm
```

### Dependencies

#### Nerd Font (Obligatorisk)

Denna config använder **CaskaydiaCove Nerd Font**. Du måste installera den för att få korrekt visning av ikoner och symboler.

**Windows (Scoop):**
```powershell
scoop bucket add nerd-fonts
scoop install CascadiaCode-NF
```

**Manuell installation (Alla plattformar):**
1. Ladda ner [CascadiaCode Nerd Font](https://www.nerdfonts.com/font-downloads)
2. Installera fonten:
   - **Windows**: Högerklicka på `.ttf`-filerna → "Installera"
   - **macOS**: Dubbelklicka på `.ttf`-filerna → "Installera font"
   - **Linux**: Kopiera till `~/.local/share/fonts/` och kör `fc-cache -fv`

#### WSL (För Windows-användare)

Om du använder WSL (som denna config gör som standard):

```powershell
# Installera WSL om du inte har det
wsl --install

# Eller installera specifik distribution
wsl --install -d Ubuntu
```

#### Bakgrundsbild (Valfritt)

Denna config använder en bakgrundsbild. Du behöver antingen:
1. Placera en bild på: `C:/Users/[DITT_ANVÄNDARNAMN]/Pictures/bakgrunder/yoru.gif`
2. Eller kommentera bort/ändra denna rad i konfigurationen:
   ```lua
   config.window_background_image = "C:/Users/Johan/Pictures/bakgrunder/yoru.gif"
   ```

## Konfiguration

### Installation av config

1. **Hitta WezTerm config-katalogen:**

   **Windows:**
   ```
   %USERPROFILE%\.config\wezterm\
   eller
   %USERPROFILE%\.wezterm.lua (direkt i home-katalogen)
   ```

   **macOS/Linux:**
   ```
   ~/.config/wezterm/
   eller
   ~/.wezterm.lua (direkt i home-katalogen)
   ```

2. **Skapa config-filen:**

   **Windows (PowerShell):**
   ```powershell
   # Skapa katalog
   New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.config\wezterm"
   
   # Skapa config-fil
   New-Item -ItemType File -Path "$env:USERPROFILE\.config\wezterm\wezterm.lua"
   
   # Kopiera din config till denna fil
   ```

   **macOS/Linux:**
   ```bash
   # Skapa katalog
   mkdir -p ~/.config/wezterm
   
   # Skapa config-fil
   touch ~/.config/wezterm/wezterm.lua
   
   # Kopiera din config till denna fil
   ```

3. **Anpassa sökvägar:**

   Uppdatera följande i config-filen:

   ```lua
   -- Ändra bakgrundsbildens sökväg till din egen
   config.window_background_image = "DIN/SÖKVÄG/TILL/BILD.gif"
   
   -- Ändra default program om du inte använder WSL
   config.default_prog = { "wsl.exe", "-d", "Ubuntu", "--cd", "~" }
   ```

4. **Starta WezTerm:**

   Konfigurationen laddas automatiskt. Vid fel, öppna med `Ctrl+Shift+L` för att se loggar.

## Funktioner

### Visuella Funktioner

- **Colorscheme**: Rose Pine Moon - en mörk, lugn färgpalett
- **Custom Tabbar**: Anpassad tabbar med index och titlar
- **Bakgrundsbild**: Stöd för animerade GIF-bakgrunder med opacity
- **Nerd Font Icons**: Full support för utvecklar-ikoner
- **Blinkande Cursor**: Elegant blinkande block-cursor
- **Anpassad Fönsterstorlek**: Automatiskt centrerat fönster vid start (90% av skärmstorlek)

### Terminal Features

- **WSL Integration**: Startar direkt i WSL Ubuntu som standard
- **Tab Management**: Flera tabs med custom titlar
- **Pane Splitting**: Dela terminalen horisontellt och vertikalt
- **High Refresh Rate**: 120 FPS för smooth scrollning
- **Smart Tab Bar**: Alltid synlig tabbar längst ner

### Performance

- **120 FPS**: Smooth rendering och scrollning
- **Optimerad Opacity**: 98% opacity för bättre prestanda än fullt transparent
- **GPU Acceleration**: Automatisk hårdvaruacceleration

## Keybindings

### Tab Management

| Keybinding | Beskrivning |
|------------|-------------|
| `Ctrl+T` | Skapa ny tab |
| `Ctrl+W` | Stäng aktiv tab/pane (med bekräftelse) |
| `Ctrl+Tab` | Nästa tab |
| `Ctrl+Shift+Tab` | Föregående tab |
| `Ctrl+Shift+0-9` | Gå till specifik tab (0-9) |

### Pane Management

| Keybinding | Beskrivning |
|------------|-------------|
| `Ctrl+Shift+H` | Dela horisontellt (ny pane till höger) |
| `Ctrl+Shift+V` | Dela vertikalt (ny pane nedanför) |
| `Ctrl+Shift+H` | Flytta fokus till vänster pane |
| `Ctrl+Shift+J` | Flytta fokus till nedre pane |
| `Ctrl+Shift+K` | Flytta fokus till övre pane |
| `Ctrl+Shift+L` | Flytta fokus till höger pane |

### Pane Resizing

| Keybinding | Beskrivning |
|------------|-------------|
| `Ctrl+Shift+←` | Minska bredd (5 steg åt vänster) |
| `Ctrl+Shift+→` | Öka bredd (5 steg åt höger) |
| `Ctrl+Shift+↑` | Minska höjd (5 steg uppåt) |
| `Ctrl+Shift+↓` | Öka höjd (5 steg nedåt) |

### Standard WezTerm Keybindings (fortfarande aktiva)

| Keybinding | Beskrivning |
|------------|-------------|
| `Ctrl+Shift+C` | Kopiera |
| `Ctrl+Shift+V` | Klistra in |
| `Ctrl+Shift+F` | Sök i terminalen |
| `Ctrl+Shift+Space` | Quick Select mode |
| `Ctrl+Shift+L` | Visa debug overlay/loggar |
| `Ctrl++` | Öka font-storlek |
| `Ctrl+-` | Minska font-storlek |
| `Ctrl+0` | Återställ font-storlek |

## Anpassning

### Ändra Colorscheme

WezTerm kommer med många inbyggda colorschemes:

```lua
-- Byt ut denna rad:
config.color_scheme = "rose-pine-moon"

-- Till en annan, t.ex:
config.color_scheme = "Catppuccin Mocha"
config.color_scheme = "Tokyo Night"
config.color_scheme = "Dracula"
config.color_scheme = "Nord"
```

Se alla tillgängliga: [WezTerm Color Schemes](https://wezfurlong.org/wezterm/colorschemes/index.html)

### Ändra Font

```lua
config.font_size = 14  -- Ändra storlek
config.font = wezterm.font("Ditt Font Namn", { weight = "Regular" })
```

Vanliga Nerd Fonts:
- `"FiraCode Nerd Font"`
- `"JetBrainsMono Nerd Font"`
- `"Hack Nerd Font"`
- `"Meslo Nerd Font"`

### Ändra Default Shell

**För PowerShell:**
```lua
config.default_prog = { "pwsh.exe" }
```

**För Windows CMD:**
```lua
config.default_prog = { "cmd.exe" }
```

**För Git Bash:**
```lua
config.default_prog = { "C:/Program Files/Git/bin/bash.exe" }
```

**För macOS/Linux:**
```lua
config.default_prog = { "/bin/zsh" }  -- eller /bin/bash
```

### Ta Bort Bakgrundsbild

Kommentera bort eller ta bort dessa rader:

```lua
-- config.window_background_image = "..."
-- config.window_background_opacity = 0.98
-- config.window_background_image_hsb = { ... }
```

### Ändra Fönsterstorlek vid Start

```lua
-- I gui-startup eventet, ändra ratio:
local ratio = 0.9  -- 90% av skärmstorlek
-- Ändra till t.ex 0.8 för 80%, eller 1.0 för fullskärm
```

### Anpassa Tab Bar

```lua
-- Flytta tab bar till toppen:
config.tab_bar_at_bottom = false

-- Använd fancy tab bar (macOS-stil):
config.use_fancy_tab_bar = true

-- Dölj tab bar om bara en tab:
config.hide_tab_bar_if_only_one_tab = true
```

### Custom Colors

Ändra färgerna i `colors`-tabellen:

```lua
local colors = {
    border = "#191724",
    tab_bar_active_tab_fg = "#c4a7e7",  -- Ändra aktiv tab-färg
    tab_bar_active_tab_bg = "#191724",
    tab_bar_text = "#6e6a86",           -- Ändra inaktiv tab-färg
    tab_bar_background = "#191724",
}
```

## Advanced Features

### Konfigurera för Flera Operativsystem

```lua
local is_windows = wezterm.target_triple:find("windows") ~= nil
local is_linux = wezterm.target_triple:find("linux") ~= nil
local is_macos = wezterm.target_triple:find("darwin") ~= nil

if is_windows then
    config.default_prog = { "wsl.exe", "-d", "Ubuntu", "--cd", "~" }
    config.window_background_image = "C:/Users/Johan/Pictures/bakgrunder/yoru.gif"
elseif is_macos then
    config.default_prog = { "/bin/zsh" }
    config.window_background_image = "/Users/johan/Pictures/yoru.gif"
else
    config.default_prog = { "/bin/bash" }
    config.window_background_image = "/home/johan/Pictures/yoru.gif"
end
```

### Lägg Till Fler Custom Keybindings

```lua
table.insert(config.keys, {
    key = "F11",
    action = wezterm.action.ToggleFullScreen,
})

table.insert(config.keys, {
    key = "r",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ReloadConfiguration,
})
```

### Domain-Switching (SSH, Docker, etc.)

WezTerm kan hantera flera domains (SSH-servrar, Docker-containers):

```lua
config.ssh_domains = {
    {
        name = "min.server",
        remote_address = "server.example.com",
        username = "ditt_användarnamn",
    },
}
```

Sedan kan du koppla upp med: `Ctrl+Shift+P` → "Connect to SSH domain"

## Felsökning

### Fonten visas inte korrekt

1. Kontrollera att Nerd Font är installerad:
   ```bash
   # Windows PowerShell
   fc-list | Select-String "Cascadia"
   
   # macOS/Linux
   fc-list | grep -i cascadia
   ```

2. Om fonten saknas, installera den (se [Dependencies](#nerd-font-obligatorisk))

### Bakgrundsbild visas inte

1. Kontrollera att sökvägen är korrekt
2. Se till att bilden existerar på den angivna platsen
3. Prova med absolut sökväg
4. WezTerm stödjer: PNG, JPG, GIF

### WSL startar inte

1. Kontrollera att WSL är installerat: `wsl --list`
2. Kontrollera distribution-namnet: `wsl --list --verbose`
3. Uppdatera `default_prog` till rätt distribution:
   ```lua
   config.default_prog = { "wsl.exe", "-d", "DITT_WSL_NAMN", "--cd", "~" }
   ```

### Config laddas inte

1. Kontrollera sökvägen till config-filen
2. Öppna debug overlay: `Ctrl+Shift+L`
3. Leta efter syntax-fel i Lua-koden
4. Verifiera att filen heter `wezterm.lua`

### Performance-problem

1. Inaktivera bakgrundsbild temporärt
2. Minska `max_fps` från 120 till 60
3. Öka `window_background_opacity` till 1.0
4. Inaktivera animationer i ditt colorscheme

## Användbara Kommandon

### Reload Configuration

Tryck `Ctrl+Shift+L` och kör:
```
:reload
```

Eller lägg till keybinding:
```lua
{
    key = "r",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ReloadConfiguration,
}
```

### Visa Alla Färgscheman

```lua
-- Lägg till temporärt i config för att testa
wezterm.gui.enumerate_color_schemes()
```

### Debug Information

```lua
-- Visa i terminal
wezterm.config_builder()
wezterm.target_triple  -- Se vilken plattform du är på
```

## Resurser

- **WezTerm Dokumentation**: [https://wezfurlong.org/wezterm/](https://wezfurlong.org/wezterm/)
- **Color Schemes**: [https://wezfurlong.org/wezterm/colorschemes/](https://wezfurlong.org/wezterm/colorschemes/)
- **Nerd Fonts**: [https://www.nerdfonts.com/](https://www.nerdfonts.com/)
- **WezTerm GitHub**: [https://github.com/wez/wezterm](https://github.com/wez/wezterm)

## Tips & Tricks

1. **Snabb reload**: Använd `Ctrl+Shift+R` efter att du lagt till en keybinding för reload
2. **Test colorschemes**: Ändra `config.color_scheme` och spara - WezTerm reloadar automatiskt
3. **Multiple configs**: Du kan ha olika configs för olika profiler
4. **Ligatures**: CaskaydiaCove stödjer programming ligatures (→ >= <=)
5. **Copy mode**: `Ctrl+Shift+X` för att kopiera utan mus
6. **Search**: `Ctrl+Shift+F` för att söka i terminal-historik
7. **Split & Zoom**: Efter split, använd `Ctrl+Shift+Z` för att zooma in på en pane

## Licens

Denna konfiguration är fri att använda och modifiera.



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
cargo install zoxide
```

#### Nerd Font (Rekommenderad för Powerlevel10k)

Se [WezTerm README](https://github.com/yourusername/wezterm-config) för installation av Nerd Fonts.

**Snabbinstallation (macOS/Linux):**
```bash
# Ladda ner och installera MesloLGS NF (rekommenderad för P10k)
# P10k kommer att erbjuda att installera denna automatiskt första gången
```

## Konfiguration

### Installation av config

1. **Skapa .zshrc-filen:**

   **WSL/Linux/macOS:**
   ```bash
   # Skapa eller redigera .zshrc
   nano ~/.zshrc
   # eller
   vim ~/.zshrc
   
   # Kopiera hela konfigurationen till filen
   ```

2. **Första gången du startar Zsh:**

   ```bash
   # Starta Zsh (om inte redan i Zsh)
   zsh
   
   # Zinit kommer att installeras automatiskt
   # Plugins kommer att laddas ner
   # Powerlevel10k konfigurationsguide kommer att starta
   ```

3. **Konfigurera Powerlevel10k:**

   Första gången kommer du att få en interaktiv guide:
   - Välj stil för prompt (Lean, Classic, Rainbow, etc.)
   - Välj ikoner och format
   - Välj vilka element som ska visas

   **För att köra guiden igen:**
   ```bash
   p10k configure
   ```

4. **Anpassa för din miljö:**

   Uppdatera winhome-alias till din Windows-användare:
   ```bash
   # I .zshrc, ändra:
   alias winhome='cd /mnt/c/Users/DITT_ANVÄNDARNAMN/'
   ```

5. **Reload konfigurationen:**

   ```bash
   source ~/.zshrc
   # eller starta om terminalen
   ```

## Funktioner

### Powerlevel10k Prompt

- **Snabb**: Optimerad för minimal latency med instant prompt
- **Informativ**: Visar git-status, execution time, exit codes
- **Anpassningsbar**: Välj bland många förkonfigurerade stilar
- **Kontext-medveten**: Visar olika info beroende på katalog

### Plugin Manager: Zinit

- **Turbo Mode**: Lazy loading för snabb start
- **Automatisk Installation**: Plugins installeras vid första körningen
- **Effektiv**: Laddar endast vad som behövs

### Intelligenta Plugins

- **Syntax Highlighting**: Färgkodad syntax medan du skriver
- **Autosuggestions**: Förslag baserat på historik (grå text)
- **Completions**: Avancerad tab-completion
- **FZF-tab**: Fuzzy finder för tab-completion
- **Command-not-found**: Förslag på paket när kommando saknas

### Shell Integrations

- **FZF**: Fuzzy finding för filer, historik och mer
- **Zoxide**: Smart cd som lär sig dina vanligaste kataloger

### Vi Mode

- Vi-keybindings i terminalen för effektiv navigation
- Kombineras med moderna verktyg för bästa av båda världar

## Plugins

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
