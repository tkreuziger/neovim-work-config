return {
	{
		"neovim/nvim-lspconfig",
		enabled = true,
		event = { "BufReadPre", "BufNewFile" },
	},

	{
		"mason-org/mason.nvim",
		enabled = true,
		cmd = "Mason",
		opts = {
			-- Reuse the existing install (also on $PATH) across profiles.
			install_root_dir = vim.fn.expand("~/.local/share/nvim/mason"),
			ui = {
				border = require("common.defaults").diagnostics_options.float.border,
				icons = {
					package_installed = "󰸞 ",
					package_pending = "󰜴 ",
					package_uninstalled = "󰅜 ",
				},
			},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		enabled = true,
		event = "VeryLazy",
		opts = {
			ensure_installed = {
				"stylua",
				"selene",
				"ruff",
				"basedpyright",
                "ty",
				"mypy",
				"debugpy",
				"hadolint",
				"jsonlint",
				"yamllint",
				"yamlfmt",
                "jq",
                "shfmt",
                "shellcheck",
                "tombi",
                "clangd",
                "clang-format",
			},
		},
	},
}
