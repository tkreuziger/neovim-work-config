local custom_find_files = function()
    local builtin = require('telescope.builtin')

    local opts = {
        find_command = function()
            return {
                'rg',
                '--files',
                '--color=never',
                '--no-heading',
                '--with-filename',
                '--line-number',
                '--column',
                '--smart-case',
                '--no-ignore-vcs',
            }
        end,
        hidden = true,
    }
    builtin.find_files(opts)
end

return {
    -- Find, Filter, Preview, Pick. All lua, all the time.
    {
        'nvim-telescope/telescope.nvim',
        cmd = 'Telescope',
        enabled = true,
        keys = {
            {
                '<leader><leader>',
                '<cmd>Telescope buffers<cr>',
                desc = 'Active buffers',
            },
            {
                '<leader>fb',
                '<cmd>Telescope buffers<cr>',
                desc = 'Active buffers',
            },
            {
                '<leader>ff',
                --'<cmd>Telescope find_files hidden=true<cr>',
                custom_find_files,
                desc = 'All files',
            },
            {
                '<leader>fg',
                '<cmd>Telescope live_grep<cr>',
                desc = 'Grep search',
            },
            {
                '<leader>fr',
                '<cmd>Telescope oldfiles<cr>',
                desc = 'Recently opened files',
            },
            {
                '<leader>fs',
                '<cmd>Telescope grep_string<cr>',
                desc = 'Grep search word',
            },
            {
                '<leader>fh',
                '<cmd>Telescope search_history<cr>',
                desc = 'Search history',
            },
            {
                '<leader>fq',
                '<cmd>Telescope command_history<cr>',
                desc = 'Command history',
            },
            {
                '<leader>fc',
                '<cmd>Telescope resume<cr>',
                desc = 'Continue last search',
            },
            {
                '<leader>fz',
                '<cmd>Telescope current_buffer_fuzzy_find<cr>',
                desc = 'Fuzzy here',
            },
            { '<leader>fm', '<cmd>Telescope marks<cr>', desc = 'Marks' },
            {
                '<leader>gl',
                '<cmd>Telescope git_commits<cr>',
                desc = 'Commits',
            },
            { '<leader>gs', '<cmd>Telescope git_status<cr>', desc = 'Status' },
            {
                '<leader>gB',
                '<cmd>Telescope git_branches<cr>',
                desc = 'Branches',
            },

            { '<leader>shk', '<cmd>Telescope keymaps<cr>', desc = 'Key Maps' },
            {
                '<leader>so',
                '<cmd>Telescope vim_options<cr>',
                desc = 'Options',
            },

            {
                '<leader>db',
                '<cmd>Telescope diagnostics bufnr=0<cr>',
                desc = 'Current buffer',
            },
            {
                '<leader>dw',
                '<cmd>Telescope diagnostics<cr>',
                desc = 'All open buffers',
            },
        },
        opts = function()
            local actions = require('telescope.actions')

            return {
                defaults = {
                    prompt_prefix = ' ',
                    selection_caret = ' ',
                    mappings = {
                        i = {
                            ["<esc>"] = actions.close,
                            ["<C-u>"] = false,
                            ['<C-j>'] = actions.move_selection_next,
                            ['<C-k>'] = actions.move_selection_previous,
                            ['<C-l>'] = function(...)
                                return actions.preview_scrolling_down(...)
                            end,
                            ['<C-h>'] = function(...)
                                return actions.preview_scrolling_up(...)
                            end,
                        },
                        n = {
                            ['q'] = function(...)
                                return actions.close(...)
                            end,
                        },
                    },
                    vimgrep_arguments = {
                        'rg',
                        '--color=never',
                        '--no-heading',
                        '--with-filename',
                        '--line-number',
                        '--column',
                        '--smart-case',
                        '--no-ignore-vcs',
                        '--hidden',
                        '--glob',
                        '!.git/',
                    },
                    find_command = function()
                        return {
                            'rg',
                            '--color=never',
                            '--no-heading',
                            '--with-filename',
                            '--line-number',
                            '--column',
                            '--smart-case',
                            '--no-ignore-vcs',
                            '--hidden',
                            '--glob',
                            '!.git/',
                        }
                    end,
                },
            }
        end,
        init = function()
            -- Haunt with Telescope.
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')

            local function open_help_in_haunt(prompt_bufnr, map)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    require('haunt').help({ fargs = { selection.ordinal } })
                end)
                return true
            end

            local function open_man_in_haunt(prompt_bufnr, map)
                actions.select_default:replace(function()
                    actions.close(prompt_bufnr)
                    local selection = action_state.get_selected_entry()
                    require('haunt').man({ fargs = { selection.ordinal } })
                end)
                return true
            end

            local telescope_haunt_help = function()
                require('telescope.builtin').help_tags({
                    attach_mappings = open_help_in_haunt,
                })
            end

            local telescope_haunt_man = function()
                require('telescope.builtin').man_pages({
                    attach_mappings = open_man_in_haunt,
                })
            end

            vim.keymap.set(
                'n',
                '<leader>shh',
                telescope_haunt_help,
                { desc = 'Help pages' }
            )
            vim.keymap.set(
                'n',
                '<leader>shm',
                telescope_haunt_man,
                { desc = 'Man pages' }
            )
        end,
    },

    -- It sets vim.ui.select to telescope.
    { 'nvim-telescope/telescope-ui-select.nvim' },
}

