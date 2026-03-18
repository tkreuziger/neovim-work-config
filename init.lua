-- Enables the experimental Lua module loader.
vim.loader.enable(true)

require("core.options")
require("core.autocmds")

require("core.lazy")

require("core.lsp")

-- Load keymaps last (including plugins)
require("core.keymaps")

-- Add optional styles.
require("core.styles")
