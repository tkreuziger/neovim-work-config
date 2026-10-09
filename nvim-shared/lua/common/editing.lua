----------------------------------------------------------------------
-- Shared editing behaviour (autocommands).
--
-- Plugin-free: everything here must work with a bare Neovim install.
-- LSP progress and other IDE-only autocmds live in `ide/autocmds.lua`.
----------------------------------------------------------------------

local autocmd = vim.api.nvim_create_autocmd
local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Highlight on yank.
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = augroup("YankHighlight"),
  pattern = "*",
})

-- Resize splits if the window got resized.
autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    vim.cmd("wincmd =")
    vim.cmd("tabdo wincmd =")
  end,
})

-- Go to the last known location when opening a file.
autocmd("BufReadPost", {
  group = augroup("restore_cursor"),
  pattern = { "*" },
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] >= 1 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Close some file types with <q>.
autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = event.buf,
      silent = true,
      desc = "Close window",
    })
  end,
})

-- Remove trailing whitespace on save.
autocmd({ "BufWritePre" }, { pattern = { "*" }, command = [[%s/\s\+$//e]] })

-- Enable treesitter highlighting, folds and indentation where a parser
-- is available. Safe on installs without the plugin/parsers.
autocmd({ "FileType" }, {
  group = augroup("treesitter"),
  callback = function()
    if pcall(vim.treesitter.start) then
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      local ok, ts = pcall(require, "nvim-treesitter")
      if ok and ts.indentexpr then
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    else
      vim.wo.foldmethod = "indent"
    end
  end,
})

-- Toggle relative numbers while the window is focused / in normal mode.
local group = augroup("numbertoggle")

autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  group = group,
  callback = function()
    if vim.wo.number and vim.fn.mode() ~= "i" then
      vim.wo.relativenumber = true
    end
  end,
})

autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  group = group,
  callback = function()
    if vim.wo.number then
      vim.wo.relativenumber = false
    end
  end,
})

return true
