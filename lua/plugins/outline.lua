return {
    'hedyhli/outline.nvim',
    config = function()
        vim.keymap.set(
            'n',
            '<leader>lo',
            '<cmd>Outline<CR>',
            { desc = 'Toggle outline' }
        )

        require('outline').setup({})
    end,
}

