# Neovim config

A set of Neovim configurations that share one plugin-free core, kept in a
single repository. Each profile lives in its own directory and is selected
with `NVIM_APPNAME`.

```
.
├── nvim-shared/     # shared core (`require("common")`) + shared plugin layer
├── nvim-ide/        # full coding setup (LSP, completion, treesitter, git, …)
├── nvim-commit/     # minimal, fast git commit editing
├── nvim-prose/      # spellchecking, wrapping, markdown/org, distraction-free
└── install.sh       # symlink the profiles into ~/.config
```

The full background on the shared core, the lazy.nvim plugin/lockfile layout
and each profile lives in [`nvim-shared/README.md`](nvim-shared/README.md).

## Install / deploy

Neovim resolves configuration at `$XDG_CONFIG_HOME/nvim-<appname>`, and every
profile loads the shared core from `~/.config/nvim-shared`, so the directories
must be reachable there. This repo is the source of truth; `install.sh` creates
the symlinks:

```sh
git clone <remote> ~/dotfiles
~/dotfiles/install.sh
```

It symlinks `nvim-shared`, `nvim-ide`, `nvim-commit` and `nvim-prose` into
`~/.config`, plus `~/.config/nvim -> nvim-ide` so plain `nvim` opens the IDE.
Any pre-existing real directory is moved aside as a timestamped backup.

## Launching

| command | profile | `NVIM_APPNAME` |
| ------- | ------- | -------------- |
| `nvi`   | IDE     | `nvim-ide`     |
| `nvc`   | Commit  | `nvim-commit`  |
| `nvp`   | Prose   | `nvim-prose`   |
| `nvim`  | IDE     | `nvim` (via `~/.config/nvim` symlink) |

The wrappers live in `~/.local/bin` and are plain
`NVIM_APPNAME=nvim-<profile> nvim` calls.

Use the commit profile as your Git editor:

```sh
git config --global core.editor nvc
```
