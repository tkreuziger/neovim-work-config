-- Shorten function name
local keymap = vim.keymap.set

-- Silent keymap option
local opts = { silent = true }
local get_opts = function(title)
	return { desc = title, silent = true }
end

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Arrow keys.
keymap("n", "<Up>", "<nop>")
keymap("n", "<Down>", "<nop>")
keymap("n", "<Left>", "<nop>")
keymap("n", "<Right>", "<nop>")

keymap("i", "<C-h>", "<Left>")
keymap("i", "<C-j>", "<Down>")
keymap("i", "<C-k>", "<Up>")
keymap("i", "<C-l>", "<Right>")

-- Windows
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<leader>wv", "<C-w>v", get_opts("Split vertically"))
keymap("n", "<leader>ws", "<C-w>s", get_opts("Split horizontally"))
keymap("n", "<leader>wd", ":q<CR>", get_opts("Close"))
keymap("n", "<leader>wx", "<C-w>x", get_opts("Swap"))
keymap("n", "<leader>ww", "<C-w>w", get_opts("Switch"))

-- Clear highlights
keymap("n", "<esc>", "<cmd>nohlsearch<CR>", opts)

-- Buffers
keymap("n", "<leader>bs", ":w<CR>", get_opts("Save"))
keymap("n", "<leader>br", ":e<CR>", get_opts("Reload"))

local conform = require("conform")
keymap("n", "<leader>bf", function()
	conform.format({ async = true })
end, get_opts("Format buffer"))

-- Exit neovim
keymap("n", "<leader>qq", ":qa<CR>", get_opts("Quit neovim"))

-- Snacks
local snacks = require("snacks")
keymap("n", "<leader>nn", snacks.notifier.show_history, get_opts("History"))
keymap("n", "<leader>nx", snacks.notifier.hide, get_opts("Hide"))

keymap("n", "<leader>bd", snacks.bufdelete.delete, get_opts("Close"))
keymap("n", "<leader>bD", function()
	snacks.bufdelete.delete({ force = true })
end, get_opts("Force close"))

-- Tabs
keymap("n", "<leader>yn", ":tabnew<CR>", get_opts("New tab"))
keymap("n", "<leader>yl", ":tabnext<CR>", get_opts("Next tab"))
keymap("n", "<leader>yh", ":tabprevious<CR>", get_opts("Previous tab"))
keymap("n", "<leader>yd", ":tabclose<CR>", get_opts("Close tab"))

-- System
keymap("n", "<leader>sl", ":Lazy<CR>", get_opts("Lazy"))
keymap("n", "<leader>sm", ":Mason<CR>", get_opts("Mason"))
keymap("n", "<leader>sc", ":checkhealth<CR>", get_opts("Health"))
keymap("n", "<leader>sn", function()
	vim.wo.relativenumber = not vim.wo.relativenumber
end, get_opts("Toggle line numbers"))

local persistence = require("persistence")
keymap("n", "<leader>ss", persistence.load, get_opts("Restore session"))

-- LSP
keymap("n", "<leader>li", ":LspInfo<CR>", get_opts("Info"))

-- Terminal
keymap("n", "<leader>st", ":terminal<CR>", get_opts("Terminal"))
keymap("t", "<esc>", "<C-\\><C-n>", get_opts("Terminal"))

-- Fileviewer
keymap("n", "<leader>fe", ":Neotree float<CR>", get_opts("Fileviewer"))

-- Telescope
local telescope_ext = require("core.telescope_picker")
vim.api.nvim_create_user_command("TelescopeModifiedBuffers", function()
	telescope_ext.modified_buffers()
end, {})

keymap("n", "<leader>bm", "<cmd>TelescopeModifiedBuffers<cr>", get_opts("Modified buffers"))
keymap("n", "<leader>bb", "<cmd>Telescope buffers<cr>", get_opts("All buffers"))

-- Diagnostics.
keymap("n", "<leader>df", vim.diagnostic.open_float, get_opts("Float"))
keymap("n", "<leader>dl", vim.diagnostic.setloclist, get_opts("List"))
keymap("n", "<leader>dW", ":Trouble diagnostics open<CR>",  get_opts("Workspace"))

-- Ignore files.
keymap("n", "<leader>gi", ":e .gitignore<CR>", get_opts("Open .gitignore"))
keymap("n", "<leader>fi", ":e .ignore<CR>", get_opts("Open .ignore"))

-- Refactor.
local refactoring = require("refactoring")
local refactor = refactoring.refactor
keymap({ "n", "x" }, "<leader>crr", function()
	refactoring.select_refactor({ prefer_ex_cmd = true })
end, get_opts("Select"))
vim.keymap.set({ "n", "x" }, "<leader>ref", function()
	return refactor("Extract Function")
end, { desc = "Function", expr = true })
vim.keymap.set({ "n", "x" }, "<leader>reF", function()
	return refactor("Extract Function To File")
end, { desc = "Function to file", expr = true })
vim.keymap.set({ "n", "x" }, "<leader>rev", function()
	return refactor("Extract Variable")
end, { desc = "Variable", expr = true })
vim.keymap.set({ "n", "x" }, "<leader>reb", function()
	return refactor("Extract Block")
end, { desc = "Block", expr = true })
vim.keymap.set({ "n", "x" }, "<leader>reB", function()
	return refactor("Extract Block To File")
end, { desc = "Block to file", expr = true })

vim.keymap.set({ "n", "x" }, "<leader>rif", function()
	return refactor("Inline Function")
end, { desc = "Function", expr = true })
vim.keymap.set({ "n", "x" }, "<leader>riv", function()
	return refactor("Inline Variable")
end, { desc = "Variable", expr = true })

-- Docstrings.
local neogen = require('neogen')
keymap("n", "<leader>cd", neogen.generate, get_opts("Add docstring"))

-- Open git repository.
keymap("n", "<leader>goo", snacks.gitbrowse.open, get_opts("Repository"))
keymap("n", "<leader>gob", function() snacks.gitbrowse.open({ what = "branch" }) end, get_opts("Branch"))
keymap("n", "<leader>goc", function() snacks.gitbrowse.open({ what = "commit" }) end, get_opts("Commit"))

-- Harpoon.
local harpoon = require("harpoon")

keymap("n", "<leader>ha", function() harpoon:list():add() end, get_opts("Add harpoon"))
-- keymap("n", "<leader>hs", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, get_opts("Pick harpoon"))

keymap("n", "<leader>hs", function() telescope_ext.harpoon_marks(harpoon:list()) end,
    { desc = "Open harpoon window" })

-- Neotest
keymap("n", "<leader>ct", ":Neotest summary toggle", get_opts("Show tests"))
