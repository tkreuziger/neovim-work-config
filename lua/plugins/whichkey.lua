return {
    {
        'folke/which-key.nvim',
        enabled = true,
        opts = {
            preset = 'modern',
            icons = {
                group = '',
            },
        },
        keys = {
            {
                '<leader>?',
                function()
                    require('which-key').show({ global = false })
                end,
                desc = 'Buffer Local Keymaps',
            },
        },
        init = function()
            require('which-key').add({
                mode = { 'n' },
                { '<leader>q', group = 'Quit?' },

                { '<leader>s', group = 'System', icon = '' },
                { '<leader>sc', group = 'Options', icon = '' },
                { '<leader>ss', group = 'Session', icon = '󰇄' },
                { '<leader>sh', group = 'Help', icon = '󰋖' },
                { '<leader>shk', desc = 'Keymaps', icon = '󰌌' },
                { '<leader>shm', desc = 'Man pages', icon = '󰈙' },
                { '<leader>st', desc = 'Terminal', icon = '' },

                { '<leader>f', group = 'Find', icon = '' },
                { '<leader>h', group = 'Harpoon', icon = '󰛢' },
                { '<leader>b', group = 'Buffer' },
                { '<leader>w', group = 'Windows' },
                { '<leader>d', group = 'Diagnostics' },
                { '<leader>n', group = 'Notifications' },
                { '<leader>y', group = 'Tabs', icon = '󰓩' },
                { '<leader>m', group = 'Music', icon = '󰝚' },

                { '<leader>l', group = 'LSP', icon = '󰧑' },
                { '<leader>lp', group = 'Preview', icon = '󰍋' },
                { '<leader>lc', group = 'Actions', icon = '' },
                { '<leader>lcs', group = 'Swaps', icon = '󰓡' },

                { '<leader>g', group = 'Git' },
                { '<leader>gc', group = 'Commands' },
                { '<leader>gh', group = 'Hunks' },
                { '<leader>gb', group = 'Buffer' },

                { '<leader>la', group = 'Actions' },
                { '<leader>lr', group = 'Symbols' },
            })
        end,
    },
}
