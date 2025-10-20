-- Enables the experimental Lua module loader.
vim.loader.enable()

require("core.options")
require("core.autocmds")

require("core.lazy")

-- Load keymaps last (including plugins)
require("core.keymaps")
