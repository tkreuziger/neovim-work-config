----------------------------------------------------------------------
-- Commit-message profile keymaps.
--
-- Deliberately tiny: the shared keymaps already cover motions,
-- saving, quitting and spell/wrap toggles.
----------------------------------------------------------------------

local map = vim.keymap.set
local text = require("common.text")

map("n", "<leader>wc", text.report_word_count, { desc = "Word count", silent = true })
map("n", "<leader>z", text.distraction_free, { desc = "Distraction-free mode", silent = true })

return true
