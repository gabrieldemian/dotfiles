return {
	"mrcjkb/rustaceanvim",
	version = "^4",
	ft = { "rust" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"mfussenegger/nvim-dap",
		{
			"lvimuser/lsp-inlayhints.nvim",
			opts = {},
		},
	},
	config = function()
		local M = {}
		local cfg = require("rustaceanvim.config")
		HOME_PATH = os.getenv("HOME") .. "/"
		MASON_PATH = HOME_PATH .. ".local/share/nvim/mason/packages/"
		local codelldb_path = MASON_PATH .. "codelldb/extension/adapter/codelldb"
		local liblldb_path = MASON_PATH .. "codelldb/extension/lldb/lib/liblldb.so"

		vim.g.rustaceanvim = {
			-- inlay_hints = {
			-- 	highlight = "NonText",
			-- },
			tools = {
				hover_actions = {
					auto_focus = true,
				},
			},
			server = {
				on_attach = function(client, bufnr)
					require("lsp-inlayhints").on_attach(client, bufnr)
					Map("n", "<leader>h", function()
						require("lsp-inlayhints").toggle()
					end)
				end,
				settings = {
					["rust-analyzer"] = {
            -- cache = {
            --   warmup = true
            -- },
            -- procMacro = {
            --   enable = true
            -- },
						diagnostics = {
							enable = true,
							disabled = { "unresolved-proc-macro" },
							enableExperimental = true,
						},
						inlay_hints = {
							auto = true,
						},
					},
				},
				-- handlers = {
				-- 	["experimental/serverStatus"] = function(_, result, ctx, _)
				-- 		if result.quiescent and not M.ran_once then
				-- 			for _, bufnr in ipairs(vim.lsp.get_buffers_by_client_id(ctx.client_id)) do
    --             require("lsp-inlayhints").disable()
    --             require("lsp-inlayhints").enable()
				-- 			end
				-- 			M.ran_once = true
				-- 		end
				-- 	end,
				-- },
			},
			dap = {
				adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
			},
		}
	end,
}
