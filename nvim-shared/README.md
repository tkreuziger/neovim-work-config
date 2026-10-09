# Neovim profiles

A small set of Neovim configurations that share one plugin-free core. Each
profile lives in its own config directory and is selected with
`NVIM_APPNAME`.

```
~/.config/
├── nvim-shared/     # shared core + shared plugin layer
│   └── lua/common/  # require("common"), require("common.text"), ...
│       └── plugins/ # cross-profile specs (catppuccin)
├── nvim-ide/        # full coding setup (LSP, completion, treesitter, git, …)
│   └── lua/plugins/ # IDE-only specs
├── nvim-commit/     # minimal, fast git commit editing
├── nvim-prose/      # spellchecking, wrapping, markdown/org, distraction-free
│   └── lua/plugins/ # prose specs (telescope)
└── nvim -> nvim-ide # convenience symlink: plain `nvim` opens the IDE profile
```

## Launching

Wrappers are installed in `~/.local/bin`:

| command | profile   | `NVIM_APPNAME` |
| ------- | --------- | -------------- |
| `nvi`   | IDE       | `nvim-ide`     |
| `nvc`   | Commit    | `nvim-commit`  |
| `nvp`   | Prose     | `nvim-prose`   |
| `nvim`  | IDE       | `nvim` (via the symlink) |

They are plain wrappers around `NVIM_APPNAME=nvim-<profile> nvim`, so you can
always invoke a profile directly:

```sh
NVIM_APPNAME=nvim-prose nvim notes.md
```

### Git commits

Use the commit profile for commit messages:

```sh
git config --global core.editor 'nvc'
# or, without the wrapper:
git config --global core.editor 'NVIM_APPNAME=nvim-commit nvim'
```

## The shared core

Every profile starts with:

```lua
vim.opt.runtimepath:append(vim.fn.expand("~/.config/nvim-shared"))
require("common") -- options + keymaps + editing
```

Modules:

| module             | purpose                                                       |
| ------------------ | ------------------------------------------------------------- |
| `common`           | loads the three base modules below                            |
| `common.options`   | editor options safe for every profile (no plugins)            |
| `common.keymaps`   | base motions/windows/buffers/tabs (no plugins)                |
| `common.editing`   | yank highlight, cursor restore, treesitter-if-available, etc. |
| `common.text`      | spell/wrap toggles, word count, distraction-free mode         |
| `common.defaults`  | icons + diagnostic data                                       |
| `common.utils`     | small string/table helpers                                    |
| `common.lazy`      | shared lazy.nvim bootstrap (`common.lazy.setup{}`)            |
| `common.plugins`   | plugin specs shared by every profile (Catppuccin)             |

**Rule:** `common.options`, `common.keymaps` and `common.editing` must never
`require` a plugin. Plugin usage is opt-in through `common.lazy`: every profile
loads the shared `common.plugins` layer (Catppuccin), and a profile may add its
own specs under `lua/plugins/` (the IDE does, and prose adds Telescope).

lazy.nvim's `import` only walks one root per module, so the shared layer uses
the `common.plugins` namespace and the profile layer keeps `plugins`. The
default spec in `common.lazy.setup` wires both together automatically.

## Shared data (no duplicate installs)

Profiles intentionally reuse the historical `~/.local/share/nvim` locations so
existing installs keep working:

| resource            | location                            |
| ------------------- | ----------------------------------- |
| lazy.nvim plugins   | `~/.local/share/nvim/lazy`          |
| lazy lockfile       | `~/.config/nvim-shared/lazy-lock.json` |
| treesitter parsers  | `~/.local/share/nvim/site`          |
| Mason servers/tools | `~/.local/share/nvim/mason` (`$PATH`) |

State that is profile specific (shada, undo, sessions, …) stays under
`~/.local/share/nvim-<profile>` and `~/.local/state/nvim-<profile>`.

## Prose profile

`nvim-prose` uses the shared Catppuccin layer plus a few small plugins:

- **Telescope** (`nvim-prose/lua/plugins/telescope.lua`) for file navigation:
  `<leader><leader>` / `<leader>ff` find files, `<leader>fg` live grep,
  `<leader>fb` buffers, `<leader>fr` recent, `<leader>fh` help.
- **goyo.vim + limelight.vim** (`nvim-prose/lua/plugins/goyo.lua`) for
  distraction-free writing: `<leader>z` toggles Goyo, and Limelight is turned
  on/off automatically with it; `<leader>ul` toggles Limelight on its own.

Everything else is built in: spellchecking, wrapping, markdown conceal, prose
filetypes and word count in the statusline. Add more prose-oriented plugins by
dropping specs into `nvim-prose/lua/plugins/` (e.g. render-markdown,
zen-mode).

## Commit profile

`nvim-commit` loads only the shared Catppuccin layer (no LSP, completion or
language servers) and sets up `gitcommit`/`gitrebase` buffers: spell,
`textwidth=72`, auto-wrap, a quiet layout and insert mode on an empty message.
