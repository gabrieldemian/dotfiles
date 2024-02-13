-- twilight
Map("n", "tw", ":Twilight<enter>", { noremap = false, silent = true })

-- Leap Highlight
vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" }) -- or some grey
vim.api.nvim_set_hl(0, "LeapMatch", {

	-- For light themes, set to 'black' or similar.
	fg = "white",
	bold = true,
	nocombine = true,
})

-- Specify some nicer shades instead of the default "red" and "blue".
vim.api.nvim_set_hl(0, "LeapLabelPrimary", {
	fg = "yellow",
	bold = true,
	nocombine = true,
})
vim.api.nvim_set_hl(0, "LeapLabelSecondary", {
	fg = "pink",
})

Map("n", "<leader>u", vim.cmd.UndotreeToggle)

-- keep cursor in place
-- Map("n", "J", "mzJ`z")
Map("x", "<leader>p", '"_dP')

-- Copy to clipboard
Map("n", "<leader>y", '"+y')
Map("v", "<leader>y", '"+y')
Map("n", "<leader>Y", '"+Y')

Map("n", "x", '"_x')

-- Git (vim-fugitive)
Map("n", "<leader>gs", vim.cmd.Git)
Map("n", "<leader>gc", ':G commit -m "', { noremap = false })
Map("n", "<leader>gp", ":G push -u origin HEAD<CR>", { noremap = false })

-- Noice
Map("n", "<leader>nn", ":NoiceDismiss<CR>")

-- files
Map("n", "QQ", ":q!<enter>", { noremap = false, silent = true })
Map("n", "WW", ":w!<enter>", { noremap = false, silent = true })
Map("n", "E", "$", { noremap = false, silent = true })
Map("n", "B", "^", { noremap = false, silent = true })
Map("n", "TT", ":TransparentToggle<CR>", { noremap = true, silent = true })
Map("n", "st", ":TodoTelescope<CR>", { noremap = true, silent = true })
Map("n", "ss", ":noh<CR>", { noremap = true, silent = true })

-- Options through Telescope
vim.api.nvim_set_keymap(
	"n",
	"<Leader><tab>",
	"<Cmd>lua require('telescope.builtin').commands()<CR>",
	{ noremap = false }
)

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- stage current file, similar to `Git add %`
Map("n", "<leader>gw", vim.cmd.Gwrite)

-- remove current file on the next commit
Map("n", "<leader>rm", vim.cmd.Gremove)

-- Discard unstaged changes to the current file
Map("n", "<leader>rd", vim.cmd.Gread)

-- Git blame
Map("n", "<leader>gb", "<Cmd>G blame<CR>")
