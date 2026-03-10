local function total_num_lines()
    return vim.api.nvim_buf_line_count(0)
end

local function lint_progress()
    if not vim.g.linting_enabled then
        return ' '
    end
    local linters = require('lint').get_running()
    if #linters == 0 then
        return ' '
    end
    return '󱉶 ' .. table.concat(linters, ', ')
end

local function is_recording()
    local rec = vim.fn.reg_recording()

    if rec == '' then
        return ''
    end

    return '󰑋  ' .. rec
end


local function buf_modified(buf)
    if vim.bo[buf].modified then
        return " [+] "
    else
        return ''
    end
end

local function breadcrumbs()
    local navic = require("nvim-navic")
    local filename = vim.fn.expand("%"):gsub("/", " > ")
    if filename:sub(1, 3) == " > " then
        filename = filename:sub(4)
    end

    local bc = ""
    if navic.is_available() then
        bc = navic.get_location()
    end

    if bc ~= "" then
        bc = filename .. " > " .. bc
    else
        bc = filename
    end

    return buf_modified(0) .. bc
end

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
            disabled_filetypes = {
                statusline = {
                    "checkhealth",
                    "floating",
                    "telescope",
                    "Outline",
                },
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            always_show_tabline = true,
            globalstatus = false,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
                refresh_time = 16, -- ~60fps
                events = {
                    'WinEnter',
                    'BufEnter',
                    'BufWritePost',
                    'SessionLoadPost',
                    'FileChangedShellPost',
                    'VimResized',
                    'Filetype',
                    'CursorMoved',
                    'CursorMovedI',
                    'ModeChanged',
                },
            }
        },
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch', 'diff', 'diagnostics'},
            lualine_c = { breadcrumbs },
            lualine_x = { is_recording, lint_progress, 'searchcount'},
            lualine_y = {'encoding', 'fileformat', 'filetype'},
            lualine_z = {'progress', 'location', total_num_lines}
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
    },
}
