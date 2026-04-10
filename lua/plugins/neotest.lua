return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-python",
	},
	config = function(_, opts)
		require("neotest").setup({
            floating = {
                border = "rounded",
            },
			adapters = {
				require("neotest-python")({
					dap = {},
				}),
			},
		})
	end,
}
