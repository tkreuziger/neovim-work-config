vim.g.linting_enabled = true

return {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
    config = function()
        local lint = require('lint')
        lint.linters_by_ft = {
            lua = { 'selene' },
            python = { 'mypy' },
            dockerfile = { 'hadolint' },
            json = { 'jsonlint' },
            yaml = { 'yamllint' },
        }

        local lint_augroup =
            vim.api.nvim_create_augroup('lint', { clear = true })

        vim.api.nvim_create_autocmd(
            { 'BufEnter', 'BufWritePost', 'InsertLeave' },
            {
                group = lint_augroup,
                callback = function()
                    if vim.g.linting_enabled then
                        lint.try_lint()
                    end
                end,
            }
        )

        local toggle_lint = function()
            vim.g.linting_enabled = not vim.g.linting_enabled

            if not vim.g.linting_enabled then
                vim.diagnostic.reset(nil, 0)
            else
                lint.try_lint()
            end
        end

        vim.keymap.set('n', '<leader>lll', function()
            lint.try_lint()
        end, { desc = 'Lint buffer' })
        vim.keymap.set('n', '<leader>llc', function()
            vim.diagnostic.reset(nil, 0)
        end, { desc = 'Clear linter messages' })
        vim.keymap.set(
            'n',
            '<leader>llt',
            toggle_lint,
            { desc = 'Toggle linting' }
        )
    end,
}
