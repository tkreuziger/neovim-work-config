----------------------------------------------------------------------
-- Prose profile autocommands.
----------------------------------------------------------------------

local autocmd = vim.api.nvim_create_autocmd
local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Filetypes that should behave like prose.
local prose_filetypes = {
  "markdown",
  "org",
  "text",
  "tex",
  "plaintex",
  "rst",
  "asciidoc",
  "norg",
  "gitcommit",
}

autocmd("FileType", {
  group = augroup("prose_writing"),
  pattern = prose_filetypes,
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "en_us" }
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.textwidth = 80
    vim.opt_local.formatoptions:append("actn")
    vim.opt_local.formatoptions:remove("ro")
  end,
})

return true
