local function branch()
	local ohgod = vim.fn.system("git branch --show-current")
	local branch = string.gsub(ohgod, "%s+$", "")
	if not branch or branch == "" or branch:find("^fatal: not a git repo") then
		return ""
	end
	return "     " .. branch
end

local function smart_enter()
	local line        = vim.fn.getline('.')
	local col         = vim.fn.col('.')
	local left        = line:sub(1, col - 1):match('^(.*%S)%s*$')
	local right, rest = line:sub(col):match('^%s*(%S)(.*)')
	local pairs       = { ['{'] = '}', ['('] = ')', ['['] = ']', ['<'] = '>' }
	if left and right and pairs[left:sub(-1)] == right then
		local indent = line:match('^%s*')
		local tab = vim.bo.expandtab and ' ' or '\t'
		local inner = indent .. string.rep(tab, vim.bo.shiftwidth)
		vim.api.nvim_buf_set_lines(0, vim.fn.line('.') - 1, vim.fn.line('.'), false, {
			indent .. left,        -- opening bracket + preceding text
			inner,                 -- indented blank line (cursor lands here)
			indent .. right .. (rest or '') -- closing bracket + everything after
		})
		vim.api.nvim_win_set_cursor(0, { vim.fn.line('.') + 1, #inner + 1 })
		return
	end
	-- normal enter
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<CR>', true, true, true), 'n', true)
end

-------------------
----- options -----
-------------------

vim.g.mapleader = " "
vim.cmd("colorscheme default")
vim.g.autoformat = true
vim.g.markdown_recommended_style = 0
vim.o.number = true
vim.o.numberwidth = 2
vim.o.scrolloff = 8
vim.o.sidescrolloff = 4
vim.o.list = true
vim.o.undofile = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
-- vim.wo.breakindent = true
-- vim.treesitter.indent = true
-- vim.bo.autoindent = true
local statusline = {
	' %<%f',
	branch(),
	'%m',
	'%=',
	'',
	'%{&filetype}',
	'  0x%B',
	' %2p%%',
	' %3l:%-2c '
}
vim.o.statusline = table.concat(statusline, '')
vim.o.winborder = '╭,-,╮,|,╯,-,╰,|'
vim.o.autocomplete = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.o.termguicolors = true
vim.o.wildmenu = true
vim.o.wildmode = "longest:full,full"
vim.o.showcmd = true
vim.o.showmode = false

-- Disable clipboard in SSH servers
vim.o.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
vim.o.textwidth = 80
vim.opt.completeopt = { "menuone", "noselect", "popup" }
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.undofile = true
vim.o.autoread = true
vim.o.synmaxcol = 300 -- Syntax highlighting limit
vim.o.redrawtime = 10000
vim.o.maxmempattern = 20000

local colors = require("colors")
vim.api.nvim_set_hl(0, 'Normal', { bg = colors.black, fg = colors.white_bright })
vim.api.nvim_set_hl(0, '@variable', { fg = colors.white_bright })
vim.api.nvim_set_hl(0, 'PreProc', { fg = colors.cyan })
vim.api.nvim_set_hl(0, 'Special', { fg = colors.cyan_bright })
vim.api.nvim_set_hl(0, 'StatusLine', { bg = colors.black })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = colors.black })
vim.api.nvim_set_hl(0, 'Search', { fg = colors.yellow, bg = colors.black_bright })
vim.api.nvim_set_hl(0, 'Visual', { bg = colors.black_bright })

vim.api.nvim_set_hl(0, 'String', { fg = colors.green })
vim.api.nvim_set_hl(0, 'Character', { fg = colors.green })
vim.api.nvim_set_hl(0, 'Comment', { fg = colors.white })
vim.api.nvim_set_hl(0, 'Function', { fg = colors.blue_bright })
vim.api.nvim_set_hl(0, 'Number', { fg = colors.magenta_bright })
vim.api.nvim_set_hl(0, 'Float', { fg = colors.magenta_bright })
vim.api.nvim_set_hl(0, 'Type', { fg = colors.cyan_bright })
vim.api.nvim_set_hl(0, 'Statement', { fg = colors.white_bright })
vim.api.nvim_set_hl(0, 'Identifier', { fg = colors.white_bright })
vim.api.nvim_set_hl(0, 'Define', { fg = colors.white_bright })
vim.api.nvim_set_hl(0, 'Special', { fg = colors.yellow })
vim.api.nvim_set_hl(0, 'Boolean', { fg = colors.yellow_bright })
vim.api.nvim_set_hl(0, 'Delimiter', { fg = colors.white_bright })
vim.api.nvim_set_hl(0, 'Operator', { fg = colors.white_bright })
vim.api.nvim_set_hl(0, 'Error', { fg = colors.red })
vim.api.nvim_set_hl(0, 'Constant', { fg = colors.white_bright })
vim.api.nvim_set_hl(0, 'TabLine', { bg = colors.black, fg = colors.black_bright })
vim.api.nvim_set_hl(0, 'TabLineSel', { fg = colors.white })

vim.filetype.add({
	extension = {
		env = "dotenv",
	},
	filename = {
		[".env"] = "dotenv",
		["env"] = "dotenv",
	},
	pattern = {
		["[jt]sconfig.*.json"] = "jsonc",
		["%.env%.[%w_.-]+"] = "dotenv",
	},
})

-------------------
----- keymaps -----
-------------------

local map = vim.keymap.set
local opts = { noremap = true, silent = true }
local function with_desc(desc)
	return { desc = desc, noremap = true, silent = true }
end

map('i', '<CR>', smart_enter, opts)
map("n", "WW", ":wa<CR>", opts)
map("n", "<C-t>", ":tabedit<CR>", with_desc("Create tab"))
map("n", "<C-b>", ":bd<CR>", with_desc("Delete buffer"))
map("n", "<Tab>", ":tabnext<CR>", with_desc("Next tab"))
map("n", "<S-Tab>", ":tabprev<CR>", with_desc("Previous tab"))
map("n", "<C-Tab>", ":bn<CR>", with_desc("Next buffer"))
map("n", "<leader>fzf", ":FzfLua<CR>", opts)
map("n", "ff", ":FzfLua files<CR>", opts)
map("n", "fg", ":FzfLua grep_visual<CR>", opts)
map("n", "fk", ":FzfLua keymaps<CR>", opts)
map("n", "x", "\"_x", opts)
map({ "n", "v" }, "<leader>y", "\"+y", opts)
map({ "n", "x" }, "]d", vim.diagnostic.goto_next, with_desc("Next Diagnostic"))
map({ "n", "x" }, "[d", vim.diagnostic.goto_prev, with_desc("Prev Diagnostic"))
map("v", "p", '"_dP', opts)
map({ "i", "c" }, "<C-h>", "<Left>", opts)
map({ "i", "c" }, "<C-j>", "<Down>", opts)
map({ "i", "c" }, "<C-k>", "<Up>", opts)
map({ "i", "c" }, "<C-l>", "<Right>", opts)

-- git signs
map("n", "<leader>gsh", ':Gitsigns stage_hunk<cr>', opts)
map("n", "<leader>gSh", ':Gitsigns undo_stage_hunk<cr>', opts)
map("n", "<leader>gsb", ':Gitsigns stage_buffer<cr>', opts)
map("n", "<leader>gSb", ':Gitsigns undo_stage_buffer<cr>', opts)
map("n", "<leader>grb", ':Gitsigns reset_buffer<cr>', opts)
map("n", "<leader>grh", ':Gitsigns reset_hunk<cr>', opts)
map("n", "<leader>gph", ':Gitsigns preview_hunk<cr>', opts)
map("n", "<leader>gd", ':Gitsigns diff_this<cr>', opts)

-- auto close pairs
map("i", "`", "``<left>")
map("i", '"', '""<left>')
map("i", "'", "''<left>")
map("i", "(", "()<left>")
map("i", "[", "[]<left>")
map("i", "{", "{}<left>")

map("n", "-", "<cmd>Oil<cr>", with_desc("Open parent directory"))
map("n", "<leader>fm", ":lua vim.lsp.buf.format()<CR>", opts)
-- Fix spelling (picks first suggestion)
map("n", "z0", "1z=", with_desc("Fix word under cursor"))

-----------------
---- plugins ----
-----------------

vim.pack.add({
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
})
require("mason").setup({})
require("oil").setup()
require("fzf-lua").setup()
require("gitsigns").setup()

-----------------
------ lsp ------
-----------------

local function attachme(client, bufnr)
	vim.lsp.completion.enable(true, client.id, bufnr, {
		autotrigger = true,
		convert = function(item)
			return { abbr = item.label:gsub("%b()", "") }
		end,
	})
	vim.keymap.set("i", "<C-space>", vim.lsp.completion.get, { desc = "trigger autocompletion" })
end

vim.lsp.config['lua_ls'] = {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
	on_attach = attachme,
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			}
		}
	}
}
vim.lsp.config['zls'] = {
	cmd = { 'zls' },
	filetypes = { 'zig' },
	on_attach = attachme,
	settings = {
		enable_build_on_save = true,
		warn_style = true
	}
}
vim.lsp.config['rust-analyzer'] = {
	cmd = { 'rust-analyzer' },
	filetypes = { 'rust' },
	on_attach = attachme,
}
vim.lsp.config['bash_ls'] = {
	cmd = { 'bash-language-server', 'start' },
	filetypes = { 'sh', 'bash' },
	on_attach = attachme,
}
vim.lsp.enable({
	'lua_ls',
	'zls',
	'rust-analyzer',
	'bash_ls',
})

-----------------
--- treesitter---
-----------------

vim.treesitter.language.add(
	'javascript',
	{ path = "/home/gabriel/.config/nvim/parser/js.so" }
)
vim.treesitter.language.add(
	'rust',
	{ path = "/home/gabriel/.config/nvim/parser/rust.so" }
)
vim.treesitter.language.add(
	'zig',
	{ path = "/home/gabriel/.config/nvim/parser/zig.so" }
)
vim.treesitter.language.add(
	'html',
	{ path = "/home/gabriel/.config/nvim/parser/html.so" }
)
vim.treesitter.language.add(
	'css',
	{ path = "/home/gabriel/.config/nvim/parser/css.so" }
)
vim.treesitter.language.add(
	'tsx',
	{ path = "/home/gabriel/.config/nvim/parser/tsx.so" }
)
vim.treesitter.language.add(
	'typescript',
	{ path = "/home/gabriel/.config/nvim/parser/ts.so" }
)
vim.treesitter.language.register('rust', { 'rust' })
vim.treesitter.language.register('javascript', { 'js', 'jsx' })
vim.treesitter.language.register('zig', { 'zig' })
vim.treesitter.language.register('html', { 'html' })
vim.treesitter.language.register('css', { 'css' })
vim.treesitter.language.register('tsx', { 'typescriptreact' })
vim.treesitter.language.register('typescript', { 'typescript' })

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'python', 'javascript', 'typescript', 'typescriptreact', 'rust', 'c', 'zig', 'html', 'css' },
	callback = function()
		vim.treesitter.start()
	end,
})
