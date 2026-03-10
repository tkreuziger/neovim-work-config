-- Set up some helpers.
local autocmd = vim.api.nvim_create_autocmd
local augroup = function(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Highlight on yank.
autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = augroup('YankHighlight'),
    pattern = '*',
})

-- Resize splits if window got resized.
autocmd({ 'VimResized' }, {
    group = augroup('resize_splits'),
    callback = function()
        vim.cmd('wincmd =')
        vim.cmd('tabdo wincmd =')
    end,
})

-- Go to the last known location when opening a file.
autocmd('BufReadPost', {
    group = augroup('restore cursor'),
    pattern = { '*' },
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] >= 1 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

local map = function(mode, lhs, rhs, opts, desc)
    opts = opts and opts or {}
    opts = vim.tbl_extend('force', opts, { desc = desc })
    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Close some file types with <q>.
autocmd('FileType', {
    group = augroup('close_with_q'),
    pattern = {
        'PlenaryTestPopup',
        'help',
        'lspinfo',
        'man',
        'notify',
        'qf',
        'query',
        'spectre_panel',
        'startuptime',
        'tsplayground',
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        map(
            'n',
            'q',
            '<cmd>close<cr>',
            { buffer = event.buf, silent = true },
            'close some filetype windows with <q>'
        )
    end,
})

-- Remove trailing whitespace in all files.
autocmd({ 'BufWritePre' }, { pattern = { '*' }, command = [[%s/\s\+$//e]] })

autocmd({ 'FileType' }, {
    callback = function()
--         if require('nvim-treesitter.parsers').has_parser() then
--             vim.opt.foldmethod = 'expr'
--             vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
--         else
--             vim.opt.foldmethod = 'syntax'
--         end
    end,
})

local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
    if not client or type(value) ~= "table" then
      return
    end
    local p = progress[client.id]

    for i = 1, #p + 1 do
      if i == #p + 1 or p[i].token == ev.data.params.token then
        p[i] = {
          token = ev.data.params.token,
          msg = ("[%3d%%] %s%s"):format(
            value.kind == "end" and 100 or value.percentage or 100,
            value.title or "",
            value.message and (" **%s**"):format(value.message) or ""
          ),
          done = value.kind == "end",
        }
        break
      end
    end

    local msg = {} ---@type string[]
    progress[client.id] = vim.tbl_filter(function(v)
      return table.insert(msg, v.msg) or not v.done
    end, p)

    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(table.concat(msg, "\n"), "info", {
      id = "lsp_progress",
      title = client.name,
      opts = function(notif)
        notif.icon = #progress[client.id] == 0 and " "
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})
