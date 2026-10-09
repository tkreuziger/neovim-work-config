----------------------------------------------------------------------
-- Prose profile keymaps.
--
-- Writing-oriented navigation plus the shared spell/wrap toggles.
----------------------------------------------------------------------

local map = vim.keymap.set
local text = require("common.text")

-- Move by display line, which matters once long paragraphs wrap.
map({ "n", "x" }, "j", "gj", { desc = "Down (screen line)", silent = true })
map({ "n", "x" }, "k", "gk", { desc = "Up (screen line)", silent = true })
map({ "n", "x" }, "<Home>", "g0", { desc = "Start of screen line", silent = true })
map({ "n", "x" }, "<End>", "g$", { desc = "End of screen line", silent = true })

-- Writer tools. (Distraction-free mode is Goyo/Limelight, mapped in
-- `lua/plugins/goyo.lua` via lazy keys.)
map("n", "<leader>wc", text.report_word_count, { desc = "Word count", silent = true })

return true
