return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	opts = {
		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
		},
		ensure_installed = {
			"rust",
			"markdown",
			"markdown_inline",
			"tsx",
			"toml",
			"json",
			"yaml",
			"css",
			"html",
			"lua",
		},
	},
}
