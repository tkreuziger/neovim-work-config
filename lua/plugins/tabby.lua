-- The changes on file indicator comes from this issue:
-- https://github.com/nanozuki/tabby.nvim/issues/125

local modified_symbol = ''

local function tab_modified(tab)
    local wins = require('tabby.module.api').get_tab_wins(tab)
    for _, x in pairs(wins) do
        if vim.bo[vim.api.nvim_win_get_buf(x)].modified then
            return modified_symbol
        end
    end
    return ''
end

local utils = require("core.utils")
local function getcwd()
    local parts = utils.str_split(vim.fn.getcwd(), "/")
    return parts[#parts]
end

return {
    {
        'nanozuki/tabby.nvim',
        enabled = true,
        opts = {
            line = function(line)
                local theme = {
                    current = {
                        fg = '#000000',
                        bg = '#ffffff',
                        style = 'bold',
                    },
                    not_current = {
                        fg = '#dddddd',
                        -- bg = 'transparent',
                    },
                    fill = {
                        -- bg = 'transparent',
                    },
                    marker = {
                        fg = "#000000",
                        bg = "#89b4fa",
                    },
                }
                return {
                    {
                        { '  ' .. getcwd() .. "  ", hl = theme.marker },
                    },
                    line.tabs().foreach(function(tab)
                        local hl = tab.is_current() and theme.current
                            or theme.not_current
                        local sep = tab.is_current() and theme.current
                            or theme.fill
                        return {
                            line.sep(' ', sep, theme.fill),
                            tab.current_win().file_icon(),
                            tab.name(),
                            tab_modified(tab.id),
                            tab.jump_key(),
                            line.sep(' ', sep, theme.fill),
                            hl = hl,
                            margin = ' ',
                        }
                    end),
                    hl = theme.fill,
                }
            end,
        },
    },
}
