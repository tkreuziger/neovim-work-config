----------------------------------------------------------------------
-- Shared core entry point.
--
-- A profile only needs to do:
--
--   vim.opt.runtimepath:append(vim.fn.expand("~/.config/nvim-shared"))
--   require("common")
--
----------------------------------------------------------------------

require("common.options")
require("common.keymaps")
require("common.editing")

return true
