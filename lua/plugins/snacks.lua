return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        dashboard = {
            enabled = true,
            preset = {
                keys = {
                    { icon = " ", key = "f", desc = "Find File", action = "<leader>ff" },
                    { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                    { icon = " ", key = "g", desc = "Find Text", action = "<leader>fg" },
                    { icon = " ", key = "r", desc = "Recent Files", action = "<leader>fr" },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                },
            },
            sections = {
                { section = "header" },
                { section = "keys", gap = 1, padding = 2 },
                { section = "startup" },
            },
        },
        explorer = { enabled = false },
        scratch = {
            enabled = true,
        },
        indent = { enabled = true },
        input = { enabled = true },
        picker = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
    },
    keys = {
        { "<leader>bx",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
        { "<leader>bc",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    }
}
