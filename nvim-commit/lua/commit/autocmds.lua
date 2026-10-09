----------------------------------------------------------------------
-- Commit-message profile autocommands.
----------------------------------------------------------------------

local autocmd = vim.api.nvim_create_autocmd
local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Format git commit / rebase messages for easy writing.
autocmd("FileType", {
  group = augroup("commit_writing"),
  pattern = { "gitcommit", "gitrebase", "hgcommit" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en_us" }
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.textwidth = 72
    vim.opt_local.colorcolumn = "72"
    vim.opt_local.formatoptions = "tcqj"
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"

    -- Start typing straight away when the message is empty.
    if vim.fn.getline(1) == "" then
      vim.cmd("startinsert")
    end
  end,
})

return true
