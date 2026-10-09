----------------------------------------------------------------------
-- IDE profile options.
--
-- Everything here is loaded *after* `common.options`, so it may
-- override the shared defaults for a coding-focused experience.
----------------------------------------------------------------------

local defaults = require("common.defaults")
local diagnostics_options = defaults.diagnostics_options

-- Interface / layout tuned for code.
vim.o.colorcolumn = "80"       -- guide at 80 columns
vim.o.ruler = true
vim.o.wrap = false             -- code reads better unwrapped
vim.o.showtabline = 2          -- always show tabs
vim.o.cmdheight = 0            -- more room for messages
vim.o.laststatus = 3           -- single global statusline
vim.o.conceallevel = 0         -- `` stays visible in markdown

-- Default border for all floating windows (hover, signature help, ...).
vim.o.winborder = diagnostics_options.float.border

-- Diagnostics appearance.
vim.diagnostic.config(diagnostics_options)

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = defaults.icons.diagnostics.Error,
      [vim.diagnostic.severity.WARN] = defaults.icons.diagnostics.Warn,
      [vim.diagnostic.severity.INFO] = defaults.icons.diagnostics.Info,
      [vim.diagnostic.severity.HINT] = defaults.icons.diagnostics.Hint,
    },
    linehl = {},
    numhl = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
})

-- GUI font helpers.
vim.g.gui_font_default_size = 12
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = "Hack Nerd Font Propo"

function _G.RefreshGuiFont()
  vim.opt.guifont = string.format("%s:h%s", vim.g.gui_font_face, vim.g.gui_font_size)
end

function _G.ResizeGuiFont(delta)
  vim.g.gui_font_size = vim.g.gui_font_size + delta
  RefreshGuiFont()
end

function _G.ResetGuiFont()
  vim.g.gui_font_size = vim.g.gui_font_default_size
  RefreshGuiFont()
end

ResetGuiFont()

return true
