# nvim-ide

The **IDE** profile of a multi-profile Neovim setup. See
[`nvim-shared/README.md`](../nvim-shared/README.md) for the full picture.

- LSP, diagnostics and code actions
- Completion, snippets and Treesitter
- Formatting and linting
- Telescope, Git integration and debugging

The plugin-free base (options, keymaps, editing behaviour) lives in
`~/.config/nvim-shared` and is loaded through `require("common")` at the top
of `init.lua`. Everything plugin-facing lives under `lua/ide/` and
`lua/plugins/`.

## Launch

```sh
nvi                 # wrapper for NVIM_APPNAME=nvim-ide nvim
# or
NVIM_APPNAME=nvim-ide nvim
```

Plain `nvim` also works: `~/.config/nvim` is a symlink to this directory.

## Layout

```
nvim-ide/
├── init.lua
├── lua/
│   ├── ide/          # IDE-only code (lsp, options, keymaps, autocmds, lazy)
│   └── plugins/      # lazy.nvim specs
└── after/ftplugin/   # e.g. lazygit tweaks
```

## Requirements

- Neovim v0.11+ (this config targets a recent dev build)
- A [Nerd Font](https://www.nerdfonts.com/)
- `fd` (https://github.com/sharkdp/fd)
- `ripgrep` (https://github.com/BurntSushi/ripgrep)
- `pip` & `npm` (for installing LSPs etc.)

Plugins are shared with the other profiles and installed once by lazy.nvim.
