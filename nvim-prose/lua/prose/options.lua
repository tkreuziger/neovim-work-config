----------------------------------------------------------------------
-- Prose profile options.
--
-- Distraction-free, writing-oriented defaults. No LSP, no completion.
----------------------------------------------------------------------

-- Quiet layout.
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.cursorline = true
vim.o.showtabline = 1
vim.o.cmdheight = 1

-- Tabs: a plain, plugin-free tabline that appears once there is more than
-- one tab. Navigation reuses the shared keys (<leader>yn / yl / yh / yd).
_G.prose_tabline = require("prose.tabline").render
vim.o.tabline = "%!v:lua.prose_tabline()"

-- A statusline that stays useful for writers.
vim.o.statusline = "%f %=%m%r  %{wordcount().words} words  %l:%c "

-- Wrapping and formatting.
vim.o.wrap = true
vim.o.linebreak = true
vim.o.textwidth = 80
vim.o.colorcolumn = "80"
vim.opt.formatoptions:append("actn")
vim.opt.formatoptions:remove("ro")

-- Spellchecking: off by default; enabled per prose filetype in
-- `prose.autocmds` (which is also where the spell file first loads).
vim.opt.spelllang = { "en_us" }
vim.opt.spelloptions:append("camel")

-- Render markdown a little nicer using built-in conceal.
vim.o.conceallevel = 2

return true
