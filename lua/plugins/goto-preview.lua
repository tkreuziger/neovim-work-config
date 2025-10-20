return {
    'rmagatti/goto-preview',
    enabled = true,
    event = 'BufEnter',
    dependencies = {'rmagatti/logger.nvim'},
    opts = {
        border = require('core.defaults').diagnostics_options.float.border,
    },
}
