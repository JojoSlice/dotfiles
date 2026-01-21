# Jojo's dotFiles

This is a collection of my configurations. Some are updated frequently, others less so.

If you'd like, you can follow my updates by creating symbolic links from the files in this repo to the directory where each config normally lives.

One issue I plan to address in the future is that some settings are hardcoded for my own machine. Additionally, any customizations you make will be overwritten on each git pull. My goal is to make the configurations more modular in the future.

I will also add more configs for other tools and programs I use, when time and motivation allow.

You can use one or more of these configs however you like - they are completely independent from each other.



## Configurations

Here you'll find both installation guides and tips on how to customize each configuration to your own needs.

- [Neovim Configuration](#neovim-configuration)
  My editor setup for Neovim, with plugins, keybinds, and settings for a smoother workflow.

- [Tmux Configuration](#tmux-configuration)
  Settings for the terminal multiplexer Tmux.

- [Zsh Configuration](#zsh-configuration)
  My configuration for the Zsh shell, with aliases, prompt customizations, and plugin management.




# Neovim Configuration

A modern and modular Neovim configuration in Lua, built to be easy to customize and extend.

All detailed documentation, including installation, features, plugins, and keybindings, has been moved to its own dedicated README file to avoid duplication and make maintenance easier.

**[See the detailed Neovim README](./nvim/README.md)**



# Tmux Configuration

This is my configuration for [Tmux](https://github.com/tmux/tmux/wiki), a terminal multiplexer.

## Installation

1.  **Install Tmux:**
    *   **macOS:** `brew install tmux`
    *   **Linux (Ubuntu/Debian):** `sudo apt install tmux`
    *   **Linux (Arch):** `sudo pacman -S tmux`

2.  **Install the configuration:**
    Create a symbolic link from your home directory to the `.tmux.conf` file in this repo.

    ```bash
    # Remove any existing config
    rm ~/.tmux.conf

    # Link the new file
    ln -s /home/jojo/dev/dotfiles/tmux/.tmux.conf ~/.tmux.conf
    ```
    *Note: The path `/home/jojo/dev/dotfiles` is specific to my machine. Other users may need to change it.*

## Features

This configuration customizes Tmux with a "Rose Pine" color scheme and new keybindings for easier navigation.

### Main Features
*   **Color Scheme**: A complete "Rose Pine" theme for status bar, windows, and panes.
*   **True Color**: Full support for 24-bit colors in the terminal.
*   **Default Prefix**: Uses the Tmux default prefix `Ctrl+b`.
*   **Faster Response**: Shorter `escape-time` for better interaction with editors like Neovim.
*   **Zsh**: Sets `zsh` as the default shell in new windows.

### Keybindings (beyond default)
*   `t`: Create a new window.
*   `w`: Close current window.
*   `Tab`: Go to next window.
*   `Shift+Tab`: Go to previous window.
*   `v`: Split window vertically (creates a new pane to the right).
*   `s`: Split window horizontally (creates a new pane below).

### Status Bar
*   **Position**: Placed at the bottom.
*   **Left**: Shows session name.
*   **Center**: List of open windows.
*   **Right**: Date and time.


# Zsh Configuration

A powerful Zsh configuration with Powerlevel10k, Zinit for plugin management, and various smart tools.

All detailed documentation, including installation, plugins, and keybindings, is now in a dedicated README file in the `zsh/` folder.

**[See the detailed Zsh README](./zsh/README.md)**
