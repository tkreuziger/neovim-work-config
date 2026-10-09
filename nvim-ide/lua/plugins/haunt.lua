return {
    'adigitoleo/haunt.nvim',
    config = true,
    opts = {
        window =  {
            title_pos = 'center',
            winblend = 0,
            border = require('common.defaults').diagnostics_options.float.border,
        },
    }
}
