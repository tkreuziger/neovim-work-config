return {
    'adigitoleo/haunt.nvim',
    config = true,
    opts = {
        window =  {
            title_pos = 'center',
            winblend = 0,
            border = require('core.defaults').diagnostics_options.float.border,
        },
    }
}
