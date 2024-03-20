local opts = { silent = true }

local function show_documentation()
	local filetype = vim.bo.filetype
	if vim.tbl_contains({ "vim", "help" }, filetype) then
		vim.cmd("h " .. vim.fn.expand("<cword>"))
	elseif vim.tbl_contains({ "man" }, filetype) then
		vim.cmd("Man " .. vim.fn.expand("<cword>"))
	elseif vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
		require("crates").show_popup()
	else
		vim.lsp.buf.hover()
	end
end

return {
	"saecki/crates.nvim",
	-- tag = 'stable',
	event = { "BufRead Cargo.toml" },
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("crates").setup({
			sources = {
				{ name = "path" },
				{ name = "buffer" },
				{ name = "nvim_lsp" },
				{ name = "crates" },
			},
			lsp = {
				enabled = true,
				on_attach = function(client, bufnr)
					-- the same on_attach function as for your other lsp's
				end,
				actions = true,
				completion = true,
				hover = true,
			},
			null_ls = {
				enabled = true,
				name = "crates.nvim",
			},
		})
	end,
	opts = {
		src = {
			cmp = {
				enabled = true,
			},
		},
		null_ls = {
			enabled = true,
			name = "crates.nvim",
		},
	},
	keys = {
		{
			"<leader>ct",
			":Crates toggle<cr>",
			opts,
		},
		{
			"<leader>cr",
			":Crates reload<cr>",
			opts,
		},
		{
			"<leader>cv",
			":Crates show_versions_popup<cr>",
			opts,
		},
		{
			"<leader>cf",
			":Crates show_features_popup<cr>",
			opts,
		},
		{
			"<leader>cd",
			":Crates show_dependencies_popup<cr>",
			opts,
		},
		{
			"<leader>cu",
			":Crates update_crates<cr>",
			opts,
		},
		{
			"<leader>cu",
			":Crates update_crates<cr>",
			opts,
			mode = { "v" },
		},
		{
			"<leader>ca",
			":Crates update_all_crates<cr>",
			opts,
		},
		{
			"<leader>cU",
			":Crates upgrade_crate<cr>",
			opts,
		},
		{
			"<leader>cU",
			":Crates upgrade_crates<cr>",
			opts,
			mode = { "v" },
		},
		{
			"<leader>cA",
			":Crates upgrade_all_crates<cr>",
			opts,
		},
		{
			"<leader>ce",
			":Crates expand_plain_crate_to_inline_table<cr>",
			opts,
		},
		{
			"<leader>cE",
			":Crates extract_crate_into_table<cr>",
			opts,
		},
		{
			"<leader>cH",
			":Crates open_homepage<cr>",
			opts,
		},
		{
			"<leader>cR",
			":Crates open_repository<cr>",
			opts,
		},
		{
			"<leader>cD",
			":Crates open_documentation<cr>",
			opts,
		},
		{
			"<leader>cC",
			":Crates open_crates_io<cr>",
			opts,
		},
		{
			"<leader>K",
			show_documentation,
			opts,
		},
	},
}
