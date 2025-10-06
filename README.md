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

- [Tmux Configuration](#tmux-configuration)
  Inställningar för terminal-multiplexern Tmux.

- [Zsh Configuration](#zsh-configuration)  
  Min konfiguration för Zsh-skalet, med alias, prompt-anpassningar och plugin-hantering.  




# Neovim Configuration

En modern och modulär Neovim-konfiguration i Lua, byggd för att vara enkel att anpassa och utöka.

All detaljerad dokumentation, inklusive installation, funktioner, plugins och kortkommandon, har flyttats till sin egen dedikerade README-fil för att undvika dubbelarbete och göra underhållet enklare.

**[➡️ Gå till den detaljerade Neovim README:n](./nvim/README.md)**



# Tmux Configuration

Detta är min konfiguration för [Tmux](https://github.com/tmux/tmux/wiki), en terminal-multiplexer.

## Installation

1.  **Installera Tmux:**
    *   **macOS:** `brew install tmux`
    *   **Linux (Ubuntu/Debian):** `sudo apt install tmux`
    *   **Linux (Arch):** `sudo pacman -S tmux`

2.  **Installera konfigurationen:**
    Skapa en symbolisk länk från din hemkatalog till `.tmux.conf`-filen i detta repo.

    ```bash
    # Ta bort en eventuell befintlig konfig
    rm ~/.tmux.conf

    # Länka den nya filen
    ln -s /home/jojo/dev/dotfiles/tmux/.tmux.conf ~/.tmux.conf
    ```
    *Notera: Sökvägen `/home/jojo/dev/dotfiles` är specifik för din maskin. Andra användare kan behöva byta ut den.*

## Funktioner

Denna konfiguration anpassar Tmux med ett "Rose Pine"-färgschema och nya kortkommandon för enklare navigering.

### Huvudfunktioner
*   **Färgschema**: En komplett "Rose Pine"-tematisering för statusrad, fönster och paneler.
*   **True Color**: Fullt stöd för 24-bitars färger i terminalen.
*   **Standard-prefix**: Använder Tmux standardprefix `Ctrl+b`.
*   **Snabbare Respons**: Kortare `escape-time` för bättre samspel med editorer som Neovim.
*   **Zsh**: Sätter `zsh` som standardskal i nya fönster.

### Kortkommandon (utöver standard)
*   `t`: Skapa ett nytt fönster.
*   `w`: Stäng nuvarande fönster.
*   `Tab`: Gå till nästa fönster.
*   `Shift+Tab`: Gå till föregående fönster.
*   `v`: Dela fönstret vertikalt (skapar en ny panel till höger).
*   `s`: Dela fönstret horisontellt (skapar en ny panel under).

### Statusrad
*   **Position**: Placerad längst ner.
*   **Vänster**: Visar sessionens namn.
*   **Mitten**: Lista över öppna fönster.
*   **Höger**: Datum och klockslag.


# Zsh Configuration

En kraftfull Zsh-konfiguration med Powerlevel10k, Zinit för plugin-hantering och diverse smarta verktyg.

All detaljerad dokumentation, inklusive installation, plugins och kortkommandon, finns nu i en dedikerad README-fil i `zsh/`-mappen.

**[➡️ Gå till den detaljerade Zsh README:n](./zsh/README.md)**