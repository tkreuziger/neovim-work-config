----------------------------------------------------------------------
-- Commit-message profile options.
--
-- Minimal, dependency-free and tuned for a focused writing session.
-- Filetype-specific settings (spell, wrapping, width) live in
-- `commit.autocmds`.
----------------------------------------------------------------------

-- A quiet, focused editing surface.
vim.o.shadafile = "NONE"  -- throwaway commit buffers: no shada read/write
vim.o.number = false
vim.o.relativenumber = false
vim.o.signcolumn = "no"
vim.o.showtabline = 0
vim.o.laststatus = 0
vim.o.cmdheight = 1

-- Faster feedback while typing.
vim.o.updatetime = 200
vim.o.timeoutlen = 300

return true
