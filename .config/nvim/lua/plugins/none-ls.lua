local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "none-ls"
		end,
		bufnr = bufnr,
	})
end

return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.rustfmt,
				null_ls.builtins.formatting.rustywind,
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					Map("n", "<leader>f", function()
						vim.lsp.buf.format({ async = true })
						--       vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						--       vim.api.nvim_create_autocmd("BufWritePre", {
						--         group = augroup,
						--         buffer = bufnr,
						--         callback = function()
						--           lsp_formatting(bufnr)
						--         end,
						--       })
					end, { silent = true })
				end
			end,
		})
	end,
}
