-- IDE profile: LSP, completion, treesitter, formatting, git, debugging.
--
-- Launch with:  NVIM_APPNAME=nvim-ide nvim   (wrapper: nvi)

-- Experimental Lua module loader.
vim.loader.enable(true)

-- Make the shared core visible on the runtime path.
vim.opt.runtimepath:append(vim.fn.expand("~/.config/nvim-shared"))

-- Shared options, keymaps and editing behaviour.
require("common")

-- IDE-specific overrides and behaviour.
require("ide.options")
require("ide.autocmds")

-- Plugins (shared install dir + lockfile).
require("ide.lazy")

-- LSP configuration and plugin-facing keymaps.
require("ide.lsp")
require("ide.keymaps")

-- Optional highlight overrides.
require("ide.styles")
