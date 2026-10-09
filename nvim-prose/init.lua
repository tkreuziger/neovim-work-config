-- Prose profile: spellchecking, wrapping, markdown/org, distraction-free.
--
-- Launch with:  NVIM_APPNAME=nvim-prose nvim   (wrapper: nvp)
--
-- Uses the shared Catppuccin layer and a small Telescope spec for file
-- navigation. Everything else is built into Neovim.

vim.loader.enable(true)

-- Make the shared core visible on the runtime path.
vim.opt.runtimepath:append(vim.fn.expand("~/.config/nvim-shared"))

-- Shared options, keymaps and editing behaviour.
require("common")

-- Prose-specific configuration.
require("prose.options")
require("prose.keymaps")
require("prose.autocmds")

-- Shared Catppuccin layer + this profile's `lua/plugins` specs (Telescope).
require("common.lazy").setup({})

-- Add more prose-oriented plugins by dropping specs into
-- `nvim-prose/lua/plugins/` (e.g. render-markdown.nvim, zen-mode.nvim).
