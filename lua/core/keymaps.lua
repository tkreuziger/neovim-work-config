-- Shorten function name
local keymap = vim.keymap.set

-- Silent keymap option
local opts = { silent = true }
local get_opts = function (title)
    return { desc = title, silent = true }
end

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Arrow keys.
keymap('n', '<Up>', '<nop>')
keymap('n', '<Down>', '<nop>')
keymap('n', '<Left>', '<nop>')
keymap('n', '<Right>', '<nop>')

keymap('i', '<C-h>', '<Left>')
keymap('i', '<C-j>', '<Down>')
keymap('i', '<C-k>', '<Up>')
keymap('i', '<C-l>', '<Right>')

-- Keep cursor centered when jumping.
keymap('n', '<C-u>', '<C-u>zz')
keymap('n', '<C-d>', '<C-d>zz')

-- Windows
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<leader>wv", "<C-w>v", get_opts("Split vertically"))
keymap("n", "<leader>ws", "<C-w>s", get_opts("Split horizontally"))
keymap("n", "<leader>wd", ":q<CR>", get_opts("Close"))

-- Clear highlights
keymap("n", "<esc>", "<cmd>nohlsearch<CR>", opts)

-- Buffers
keymap("n", "<leader>bd", ":bd<CR>", get_opts("Close"))
keymap("n", "<leader>bs", ":w<CR>", get_opts("Save"))

-- Exit neovim
keymap("n", "<leader>qq", ":qa<CR>", get_opts("Quit neovim"))

-- Projects
keymap("n", "<leader>pp", ":NeovimProjectDiscover<CR>", get_opts("Discover"))

-- Snacks
local snacks = require("snacks")
keymap("n", "<leader>nn", snacks.notifier.show_history, get_opts("History"))
keymap("n", "<leader>nx", snacks.notifier.hide, get_opts("Hide"))

-- Tabs
keymap("n", "<leader>yn", ":tabnew<CR>", get_opts("New tab"))
keymap("n", "<leader>yl", ":tabnext<CR>", get_opts("Next tab"))
keymap("n", "<leader>yh", ":tabprevious<CR>", get_opts("Previous tab"))
keymap("n", "<leader>yd", ":tabclose<CR>", get_opts("Close tab"))

-- System
keymap("n", "<leader>sl", ":Lazy<CR>", get_opts("Lazy"))
keymap("n", "<leader>sm", ":Mason<CR>", get_opts("Mason"))

-- LSP
keymap("n", "<leader>li", ":LspInfo<CR>", get_opts("Info"))

-- Terminal
keymap("n", "<leader>st", ":terminal<CR>", get_opts("Terminal"))
keymap("t", "<esc>", "<C-\\><C-n>", get_opts("Terminal"))
