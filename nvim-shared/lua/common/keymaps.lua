----------------------------------------------------------------------
-- Shared keymaps.
--
-- IMPORTANT: this module must stay free of `require("plugin")` calls.
-- Plugin usage is opt-in via `common.lazy`; the base mappings below work
-- in every profile, including the dependency-light commit profile.
----------------------------------------------------------------------

local map = vim.keymap.set
local opts = { silent = true }
local function o(desc)
  return { desc = desc, silent = true }
end

-- Space is the leader; make a bare space a no-op in normal mode.
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Disable arrow keys (use hjkl).
map("n", "<Up>", "<nop>", opts)
map("n", "<Down>", "<nop>", opts)
map("n", "<Left>", "<nop>", opts)
map("n", "<Right>", "<nop>", opts)

-- Insert-mode navigation.
map("i", "<C-h>", "<Left>", opts)
map("i", "<C-j>", "<Down>", opts)
map("i", "<C-k>", "<Up>", opts)
map("i", "<C-l>", "<Right>", opts)

-- Window navigation.
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Window management.
map("n", "<leader>wv", "<C-w>v", o("Split vertically"))
map("n", "<leader>ws", "<C-w>s", o("Split horizontally"))
map("n", "<leader>wd", "<C-w>q", o("Close window"))
map("n", "<leader>wx", "<C-w>x", o("Swap windows"))
map("n", "<leader>ww", "<C-w>w", o("Next window"))

-- Clear search highlighting.
map("n", "<esc>", "<cmd>nohlsearch<CR>", opts)

-- Buffers.
map("n", "<leader>bs", "<cmd>write<CR>", o("Save buffer"))
map("n", "<leader>br", "<cmd>edit<CR>", o("Reload buffer"))
map("n", "<leader>bd", "<cmd>bdelete<CR>", o("Close buffer"))
map("n", "<leader>bD", "<cmd>bdelete!<CR>", o("Force close buffer"))

-- Quit.
map("n", "<leader>qq", "<cmd>qa<CR>", o("Quit neovim"))

-- Tabs.
map("n", "<leader>yn", "<cmd>tabnew<CR>", o("New tab"))
map("n", "<leader>yl", "<cmd>tabnext<CR>", o("Next tab"))
map("n", "<leader>yh", "<cmd>tabprevious<CR>", o("Previous tab"))
map("n", "<leader>yd", "<cmd>tabclose<CR>", o("Close tab"))

-- System.
map("n", "<leader>sc", "<cmd>checkhealth<CR>", o("Check health"))
map("n", "<leader>sn", function()
  vim.wo.relativenumber = not vim.wo.relativenumber
end, o("Toggle line numbers"))

-- Terminal.
map("n", "<leader>st", "<cmd>terminal<CR>", o("Terminal"))
map("t", "<esc>", "<C-\\><C-n>", o("Terminal normal mode"))

-- Spelling / wrapping helpers (see common/text.lua).
local text = require("common.text")
map("n", "<leader>us", text.toggle_spell, o("Toggle spellcheck"))
map("n", "<leader>uw", text.toggle_wrap, o("Toggle wrap"))

return true
