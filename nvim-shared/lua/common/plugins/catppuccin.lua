return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        enabled = true,
        priority = 1000,
        lazy = false,
        opts = {
            flavour = 'mocha',
            transparent_background = false,
            show_end_of_buffer = false,
            term_colors = true,
            no_italic = false,
            no_bold = false,
            styles = {
                comments = { 'italic' },
                conditionals = {},
                loops = {},
                functions = {},
                keywords = {},
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {},
            },
            color_overrides = {},
            -- Catppuccin paints floats with `mantle`, one shade darker than the
            -- editor's `base`. With `vim.o.winborder` set every float gets a
            -- border, so that darker fill shows up as a boxed-in halo. Reuse
            -- `base` so floats blend with the real background.
            custom_highlights = function(colors)
                return {
                    NormalFloat = { bg = colors.base },
                    FloatBorder = { fg = colors.blue, bg = colors.base },
                    FloatTitle = { fg = colors.subtext0, bg = colors.base },
                    FloatFooter = { fg = colors.subtext0, bg = colors.base },
                    -- The completion menu is a float too; keep it consistent.
                    Pmenu = { bg = colors.base },
                    PmenuBorder = { fg = colors.blue, bg = colors.base },
                    PmenuKind = { bg = colors.base },
                }
            end,
            integrations = {
                alpha = true,
                leap = true,
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                fidget = true,
                telescope = true,
                notify = true,
                fzf = true,
                harpoon = true,
                markdown = true,
                noice = true,
                treesitter = true,
                symbols_outline = true,
                lsp_trouble = true,
                which_key = true,
                native_lsp = {
                    enabled = true,
                },
                indent_blankline = {
                    enabled = true,
                    scope_color = '',
                    colored_indent_levels = false,
                },
                mason = true,
                neogit = true,
                dap = true,
                dap_ui = true,
            },
        },
        config = function(_, opts)
            require('catppuccin').setup(opts)
            vim.cmd.colorscheme('catppuccin')
        end,
    },
}
