# Neovim config

My neovim config in a work setting. Tested on Windows and MacOS.

## Requirements

- neovim (_duh_) v0.11+ (earlier versions might work, not tested)
- A [Nerdtree Font](https://www.nerdfonts.com/) of your liking
- fd
- ripgrep
- pip & npm (for installing LSPs etc.)

## Install

Backup your existing config:
```bash
mv ~/.config/nvim ~/.config/nvim-bak
```

Clone:
```bash
git clone git@github.com:tkreuziger/neovim-work-config.git ~/.config/nvim
```

The first time you run neovim, it will install all packages and components.
Afterwards, restart once, so everything gets set up correctly.

