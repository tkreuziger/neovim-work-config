return {
    'rmagatti/goto-preview',
    enabled = true,
    event = 'BufEnter',
    dependencies = {'rmagatti/logger.nvim'},
    opts = {
        border = require('common.defaults').diagnostics_options.float.border,
    },
}
