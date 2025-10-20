------------------------
-- Set up basic settings.
------------------------

-- Set leader and local leader.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable mouse.
vim.o.mouse = ''

-- Indentation.
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true

-- Open new split panes to right and below.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Always keep at least 8 lines below and above the cursor.
vim.o.scrolloff = 8

-- Show colored column at 80.
vim.o.colorcolumn = '80'

-- Enable clipboard integration.
vim.o.clipboard = 'unnamedplus'

-- Enable line numbers.
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.cursorline = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Highlight all matches on previous search pattern.
vim.o.hlsearch = true

-- Save undo history
vim.o.undofile = true
vim.o.undolevels = 30000

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience.
vim.o.completeopt = 'menuone,noselect'

-- Backspace.
vim.o.backspace = 'indent,eol,start'

-- Enable folding.
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'syntax'
vim.opt.fillchars = { fold = " " }

-- Disable folding at startup.
vim.opt.foldenable = false

-- Set the number of screen lines above which a fold is displayed closed.
vim.opt.foldminlines = 2

-- Enable filetype stuff.
vim.cmd('filetype plugin on')

-- Time settings for keyhits.
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set correct terminal colors.
vim.o.termguicolors = true

-- Session options recommended by auto-session.
vim.o.sessionoptions =
    'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

------------------------
-- Set up diagnostics appearance.
------------------------

local defaults = require('core.defaults')
local diagnostics_options = defaults.diagnostics_options

-- Configure floating window.
vim.diagnostic.config(diagnostics_options)

-- Setup borders for handlers.
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = diagnostics_options.float.border,
})
vim.lsp.handlers['textDocument/signatureHelp'] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = diagnostics_options.float.border,
    })

-- Configure diagnostics signs.
local icons = defaults.icons.diagnostics
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = icons.Error,
            [vim.diagnostic.severity.WARN] = icons.Warn,
            [vim.diagnostic.severity.INFO] = icons.Info,
            [vim.diagnostic.severity.HINT] = icons.Hint,
        },
        linehl = {},
        numhl = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
        },
    },
})
vim.opt.cmdheight = 0                           -- more space in the neovim command line for displaying messages
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.showtabline = 2                         -- always show tabs
vim.opt.smartindent = true                      -- make indenting smarter again
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.updatetime = 300                        -- faster completion (4000ms default)
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.laststatus = 3                          -- only the last window will always have a status line
vim.opt.showcmd = false                         -- hide (partial) command in the last line of the screen (for performance)
vim.opt.ruler = true                            -- hide the line and column number of the cursor position
vim.opt.numberwidth = 2                         -- minimal number of columns to use for the line number {default 4}
vim.opt.wrap = false                            -- display lines as one long line
vim.opt.sidescrolloff = 8                       -- minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`
vim.opt.fillchars.eob=" "                       -- show empty lines at the end of a buffer as ` ` {default `~`}
vim.opt.shortmess:append "c"                    -- hide all the completion messages, e.g. "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"
vim.opt.whichwrap:append("<,>,[,],h,l")         -- keys allowed to move to the previous/next line when the beginning/end of line is reached
vim.opt.iskeyword:append("-")                   -- treats words with `-` as single words
vim.opt.formatoptions:remove({ "c", "r", "o" }) -- This is a sequence of letters which describes how automatic formatting is to be done
vim.opt.linebreak = true

vim.deprecate = function() end

vim.g.gui_font_default_size = 12
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = "Hack Nerd Font Propo"

RefreshGuiFont = function()
  vim.opt.guifont = string.format("%s:h%s",vim.g.gui_font_face, vim.g.gui_font_size)
end

ResizeGuiFont = function(delta)
  vim.g.gui_font_size = vim.g.gui_font_size + delta
  RefreshGuiFont()
end

ResetGuiFont = function ()
  vim.g.gui_font_size = vim.g.gui_font_default_size
  RefreshGuiFont()
end

-- Call function on startup to set default value
ResetGuiFont()

