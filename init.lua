-- Enables the experimental Lua module loader.
vim.loader.enable()

require("core.options")
require("core.autocmds")

require("core.lazy")

require("core.lsp")

-- Load keymaps last (including plugins)
require("core.keymaps")
require("core.styles")
