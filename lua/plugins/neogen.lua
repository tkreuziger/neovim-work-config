return {
	"danymat/neogen",
	config = true,
	opts = {
		snippet_engine = "luasnip",
		languages = {
			lua = {
				template = {
					annotation_convention = "emmylua",
				},
			},
		},
		python = {
			template = {
				annotation_convention = "google_docstrings",
			},
		},
	},
}
