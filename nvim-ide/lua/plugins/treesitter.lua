-- nvim-treesitter `main` branch.
--
-- On `main` the plugin only installs parsers/queries and registers
-- filetype<->language mappings. Highlighting, folds and indentation are
-- provided by Neovim core; see `lua/core/autocmds.lua` for enabling them.

return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        -- `main` does not support lazy-loading.
        lazy = false,
        build = ':TSUpdate',
        -- Reuse the existing parser install across every profile.
        opts = {
            install_dir = vim.fn.expand('~/.local/share/nvim/site'),
        },
        config = function(_, opts)
            local treesitter = require('nvim-treesitter')
            treesitter.setup(opts)
            treesitter.install({
                'lua',
                'python',
                'html',
                'htmldjango',
                'css',
                'javascript',
                'json',
                'toml',
                'yaml',
                'bash',
                'markdown',
                'markdown_inline',
                'latex',
                'regex',
                'vim',
                'dockerfile',
                'c',
                'cpp',
                'make',
                'diff',
                'gitignore',
                'ini',
                'requirements',
            })
        end,
    },

    -- Syntax aware text-objects, select, move, swap and peek support.
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        init = function()
            -- Avoid conflicts with Neovim's built-in ftplugin mappings.
            vim.g.no_plugin_maps = true
        end,
        opts = {
            select = {
                -- Automatically jump forward to the text object.
                lookahead = true,
                selection_modes = {
                    ['@parameter.outer'] = 'v', -- charwise
                    ['@function.outer'] = 'V', -- linewise
                },
                include_surrounding_whitespace = true,
            },
            move = {
                set_jumps = true,
            },
        },
        config = function(_, opts)
            require('nvim-treesitter-textobjects').setup(opts)

            local select = require('nvim-treesitter-textobjects.select')
            local move = require('nvim-treesitter-textobjects.move')
            local swap = require('nvim-treesitter-textobjects.swap')

            local loop = { '@loop.inner', '@loop.outer' }

            -- Select.
            local select_maps = {
                ['af'] = { '@function.outer', 'Function' },
                ['if'] = { '@function.inner', 'Function' },
                ['ac'] = { '@class.outer', 'Class' },
                ['ic'] = { '@class.inner', 'Class' },
                ['as'] = { '@local.scope', 'Scope', 'locals' },
                ['a='] = { '@assignment.outer', 'Assignment' },
                ['i='] = { '@assignment.inner', 'Assignment' },
                ['l='] = { '@assignment.lhs', 'LHS assignment' },
                ['r='] = { '@assignment.rhs', 'RHS assignment' },
                ['aa'] = { '@parameter.outer', 'Parameter' },
                ['ia'] = { '@parameter.inner', 'Parameter' },
                ['ai'] = { '@conditional.outer', 'Conditional' },
                ['ii'] = { '@conditional.inner', 'Conditional' },
                ['al'] = { '@loop.outer', 'Loop' },
                ['il'] = { '@loop.inner', 'Loop' },
                ['ar'] = { '@call.outer', 'Function call' },
                ['ir'] = { '@call.inner', 'Function call' },
            }
            for lhs, spec in pairs(select_maps) do
                vim.keymap.set({ 'x', 'o' }, lhs, function()
                    select.select_textobject(spec[1], spec[3] or 'textobjects')
                end, { desc = 'Select ' .. spec[2] })
            end

            -- Move.
            local move_maps = {
                [']m'] = { 'goto_next_start', '@function.outer', 'Next function' },
                [']]'] = { 'goto_next_start', '@class.outer', 'Next class start' },
                [']o'] = { 'goto_next_start', loop, 'Next loop' },
                [']s'] = { 'goto_next_start', '@local.scope', 'Next scope', 'locals' },
                [']z'] = { 'goto_next_start', '@fold', 'Next fold', 'folds' },
                [']M'] = { 'goto_next_end', '@function.outer', 'Next function end' },
                [']O'] = { 'goto_next_end', loop, 'Next loop end' },
                [']['] = { 'goto_next_end', '@class.outer', 'Next class end' },
                ['[m'] = { 'goto_previous_start', '@function.outer', 'Previous function' },
                ['[o'] = { 'goto_previous_start', loop, 'Previous loop' },
                ['[['] = { 'goto_previous_start', '@class.outer', 'Previous class start' },
                ['[M'] = { 'goto_previous_end', '@function.outer', 'Previous function end' },
                ['[O'] = { 'goto_previous_end', loop, 'Previous loop end' },
                ['[]'] = { 'goto_previous_end', '@class.outer', 'Previous class end' },
                [']f'] = { 'goto_next', '@conditional.outer', 'Next conditional' },
                ['[f'] = { 'goto_previous', '@conditional.outer', 'Previous conditional' },
            }
            for lhs, spec in pairs(move_maps) do
                vim.keymap.set({ 'n', 'x', 'o' }, lhs, function()
                    move[spec[1]](spec[2], spec[4] or 'textobjects')
                end, { desc = spec[3] })
            end

            -- Swap.
            vim.keymap.set('n', '<leader>lcsp', function()
                swap.swap_next('@parameter.inner')
            end, { desc = 'Swap with next parameter' })
            vim.keymap.set('n', '<leader>lcsf', function()
                swap.swap_next('@function.outer')
            end, { desc = 'Swap with next function' })
            vim.keymap.set('n', '<leader>lcsP', function()
                swap.swap_previous('@parameter.inner')
            end, { desc = 'Swap with previous parameter' })
            vim.keymap.set('n', '<leader>lcsF', function()
                swap.swap_previous('@function.outer')
            end, { desc = 'Swap with previous function' })
        end,
    },
}
