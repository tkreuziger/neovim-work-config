----------------------------------------------------------------------
-- Shared editor options.
--
-- These are safe for every profile: they enable sensible editing
-- behaviour without depending on plugins or on a programming setup.
-- Profile-specific display/behaviour options live in the profile.
----------------------------------------------------------------------

local opt = vim.opt

-- Leader keys.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable mouse.
vim.o.mouse = ""

-- Indentation.
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- Open new splits to the right and below.
opt.splitright = true
opt.splitbelow = true

-- Always keep some context around the cursor.
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Line numbers (relativenumber is toggled per mode in editing.lua).
vim.wo.number = true
vim.wo.cursorline = true
vim.wo.signcolumn = "yes"
opt.numberwidth = 2

-- Searching.
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- Undo history.
opt.undofile = true
opt.undolevels = 30000
opt.swapfile = false

-- Responsiveness.
opt.updatetime = 300
opt.timeout = true
opt.timeoutlen = 500

-- Completion.
opt.completeopt = "menuone,noselect"

-- Editing basics.
opt.backspace = "indent,eol,start"
opt.autoread = true
opt.fileencoding = "utf-8"
opt.smartindent = true

-- Folding. Fold method is switched to treesitter when a parser exists
-- (see editing.lua); indent is a good universal fallback.
opt.foldlevel = 0
opt.foldmethod = "indent"
opt.foldenable = false
opt.foldminlines = 2
opt.fillchars = { fold = " ", vert = "|", eob = " " }

-- Custom fold text.
function _G.CustomFoldText()
  local line = vim.trim(vim.fn.getline(vim.v.foldstart))
  local folded_line_num = vim.v.foldend - vim.v.foldstart
  local textwidth = vim.o.textwidth > 0 and vim.o.textwidth or 80
  local fillcharcount = textwidth - #line - tostring(folded_line_num):len() - 8

  if fillcharcount < 0 then
    fillcharcount = 0
  end

  return "+" .. string.rep("-", 2)
    .. " " .. line .. " "
    .. string.rep(".", fillcharcount)
    .. " (" .. folded_line_num .. ")"
end
opt.foldtext = "v:lua.CustomFoldText()"

-- Filetype / syntax.
vim.cmd("filetype plugin on")
vim.cmd("syntax on")

-- True colour terminals.
opt.termguicolors = true

-- Session options (persistence.nvim compatible).
opt.sessionoptions =
  "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Interface niceties.
opt.pumheight = 10
opt.linebreak = true
opt.showcmd = false

opt.shortmess:append("c")                 -- hide completion messages
opt.whichwrap:append("<,>,[,],h,l")       -- allow h/l to wrap lines
opt.iskeyword:append("-")                 -- treat dashed-words as one word
opt.formatoptions:remove("cro")            -- sensible code defaults

-- Hide deprecation warnings.
vim.deprecate = function() end

-- Reuse the treesitter parsers/queries installed by the IDE profile so that
-- core syntax highlighting works in the plugin-free profiles as well. The
-- directory is harmless if it does not exist yet.
vim.opt.runtimepath:append(vim.fn.expand("~/.local/share/nvim/site"))

return true
