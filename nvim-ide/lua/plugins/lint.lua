return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	opts = {},
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			lua = { "selene" },
			python = { "mypy" },
			dockerfile = { "hadolint" },
			json = { "jsonlint" },
			yaml = { "yamllint" },
			toml = { "tombi" },
			sh = { "shellcheck" },
			bash = { "shellcheck" },
			zsh = { "shellcheck" },
		}

		vim.keymap.set("n", "<leader>lll", function()
			lint.try_lint()
		end, { desc = "Lint buffer" })
		vim.keymap.set("n", "<leader>llc", function()
			vim.diagnostic.reset(nil, 0)
		end, { desc = "Clear linter messages" })
	end,
}
