return {
    {
        "neovim/nvim-lspconfig",
        enabled = true,
        event = { 'BufReadPre', 'BufNewFile' },
    },

    {
        'williamboman/mason.nvim',
        enabled = true,
        opts = {
            ui = {
                border = require('core.defaults').diagnostics_options.float.border,
                icons = {
                    package_installed = '󰸞 ',
                    package_pending = '󰜴 ',
                    package_uninstalled = '󰅜 ',
                },
            },
        },
    },

    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        enabled = true,
        opts = {
            ensure_installed = {
                'stylua',
                'selene',
                'ruff',
                'pyright',
                'mypy',
                'debugpy',
                'hadolint',
                'jsonlint',
                'yamllint',
            },
        },
    },
}
