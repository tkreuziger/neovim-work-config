return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
			yaml = { "yamlfmt" },
			json = { "jq" },
			toml = { "tombi" },
			sh = { "shfmt" },
			bash = { "shfmt" },
		},
	},
}
