-- Commit-message profile: fast git commit editing with shared theming.
--
-- Launch with:  NVIM_APPNAME=nvim-commit nvim   (wrapper: nvc)
--
-- Set it as git's editor, e.g.:
--   git config --global core.editor 'nvc'
--   git config --global core.editor 'NVIM_APPNAME=nvim-commit nvim'

vim.loader.enable(true)

-- Make the shared core visible on the runtime path.
vim.opt.runtimepath:append(vim.fn.expand("~/.config/nvim-shared"))

-- Shared options, keymaps and editing behaviour.
require("common")

-- Commit-specific configuration.
require("commit.options")
require("commit.keymaps")
require("commit.autocmds")

-- Shared plugin layer: Catppuccin (and any future cross-profile plugins).
-- The commit profile intentionally adds no other plugins.
require("common.lazy").setup({})
