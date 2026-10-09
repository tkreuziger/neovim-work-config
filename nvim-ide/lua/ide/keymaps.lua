----------------------------------------------------------------------
-- IDE keymaps.
--
-- Plugin-facing only. Base motions/windows/buffers are provided by
-- `common.keymaps`; anything here is allowed to override them.
----------------------------------------------------------------------

local keymap = vim.keymap.set
local function o(desc)
  return { desc = desc, silent = true }
end

-- Formatting.
local conform = require("conform")
keymap("n", "<leader>bf", function()
  conform.format({ async = true })
end, o("Format buffer"))

-- Snacks.
local snacks = require("snacks")
keymap("n", "<leader>nn", snacks.notifier.show_history, o("Notification history"))
keymap("n", "<leader>nx", snacks.notifier.hide, o("Hide notifications"))

-- Smarter buffer delete than the shared `<leader>bd`.
keymap("n", "<leader>bd", snacks.bufdelete.delete, o("Close buffer"))
keymap("n", "<leader>bD", function()
  snacks.bufdelete.delete({ force = true })
end, o("Force close buffer"))

-- System.
keymap("n", "<leader>sl", ":Lazy<CR>", o("Lazy"))
keymap("n", "<leader>sm", ":Mason<CR>", o("Mason"))

keymap("n", "<leader>ss", function()
  require("persistence").load()
end, o("Restore session"))

-- LSP.
keymap("n", "<leader>li", ":LspInfo<CR>", o("LSP info"))

-- File viewer.
keymap("n", "<leader>fe", ":Neotree float<CR>", o("File viewer"))

-- Telescope.
vim.api.nvim_create_user_command("TelescopeModifiedBuffers", function()
  require("ide.telescope_picker").modified_buffers()
end, {})

keymap("n", "<leader>bm", "<cmd>TelescopeModifiedBuffers<cr>", o("Modified buffers"))
keymap("n", "<leader>bb", "<cmd>Telescope buffers<cr>", o("All buffers"))

-- Diagnostics.
keymap("n", "<leader>df", vim.diagnostic.open_float, o("Diagnostic float"))
keymap("n", "<leader>dl", vim.diagnostic.setloclist, o("Diagnostic list"))
keymap("n", "<leader>dW", ":Trouble diagnostics open<CR>", o("Workspace diagnostics"))

-- Ignore files.
keymap("n", "<leader>gi", ":e .gitignore<CR>", o("Open .gitignore"))
keymap("n", "<leader>fi", ":e .ignore<CR>", o("Open .ignore"))

-- Docstrings.
local neogen = require("neogen")
keymap("n", "<leader>cd", neogen.generate, o("Add docstring"))

-- Open git repository in the browser.
keymap("n", "<leader>goo", snacks.gitbrowse.open, o("Repository"))
keymap("n", "<leader>gob", function()
  snacks.gitbrowse.open({ what = "branch" })
end, o("Branch"))
keymap("n", "<leader>goc", function()
  snacks.gitbrowse.open({ what = "commit" })
end, o("Commit"))

-- Harpoon.
local harpoon = require("harpoon")
keymap("n", "<leader>ha", function()
  harpoon:list():add()
end, o("Add harpoon"))
keymap("n", "<leader>hs", function()
  require("ide.telescope_picker").harpoon_marks(harpoon:list())
end, o("Open harpoon window"))

-- Neotest.
keymap("n", "<leader>ct", ":Neotest summary toggle<cr>", o("Show tests"))

return true
