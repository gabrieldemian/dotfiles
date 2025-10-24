{ ... }:
{
  config.programs.nixvim.keymaps = [
    # rustacean
    {
      mode = [ "n" ];
      key = "<leader>rt";
      action = "<cmd>:RustLsp testables<cr>";
      options.silent = true;
    }
    # add border on hover
    {
      mode = [ "n" ];
      key = "K";
      action = "<cmd>lua vim.lsp.buf.hover({border = \"rounded\", width = 70})<cr>";
      options.silent = true;
    }
    {
      mode = [ "n" ];
      key = "<leader>rn";
      action = "<cmd>lua vim.lsp.buf.rename()<cr>";
    }

    # move in insert mode with hjkl
    {
      mode = [
        "i"
        "c"
      ];
      key = "<C-h>";
      action = "<Left>";
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<cmd>lua vim.diagnostic.goto_next()<cr>";
    }
    {
      mode = "n";
      key = "<leader>ca";
      action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<cmd>lua vim.diagnostic.goto_prev()<cr>";
    }
    {
      mode = [
        "i"
        "c"
      ];
      key = "<C-j>";
      action = "<Down>";
    }
    {
      mode = [
        "i"
        "c"
      ];
      key = "<C-k>";
      action = "<Up>";
    }
    {
      mode = [
        "i"
        "c"
      ];
      key = "<C-l>";
      action = "<Right>";
    }
    # keep cursor in place
    {
      mode = "x";
      key = "<leader>p";
      action = "_dP";
    }
    # copy to clipboard
    {
      mode = "n";
      key = "<leader>y";
      action = "\"+y";
    }
    {
      mode = "v";
      key = "<leader>y";
      action = "\"+y";
    }
    {
      mode = "n";
      key = "<leader>Y";
      action = "\"+Y";
    }
    {
      mode = "n";
      key = "x";
      action = "\"_x";
    }
    {
      mode = "n";
      key = "x";
      action = "\"_x";
    }
    # files
    {
      mode = "n";
      key = "WW";
      action = ":w!<enter>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "QQ";
      action = ":q!<enter>";
    }
    {
      mode = "n";
      key = "TT";
      action = ":TransparentToggle<CR>";
    }
    {
      mode = "n";
      key = "<leader>f";
      action = "<cmd>lua vim.lsp.buf.format()<cr>";
    }
    # bufferline keys
    {
      key = "<Tab>";
      action = "<cmd>BufferLineCycleNext<cr>";
    }
    {
      key = "<S-Tab>";
      action = "<cmd>BufferLineCyclePrev<cr>";
    }
    {
      key = "<C-p>";
      action = "<cmd>BufferLinePick<cr>";
    }
    {
      key = "<leader>1";
      action = "<cmd>BufferLineGoToBuffer 1<cr>";
    }
    {
      key = "<leader>2";
      action = "<cmd>BufferLineGoToBuffer 2<cr>";
    }
    {
      key = "<leader>3";
      action = "<cmd>BufferLineGoToBuffer 3<cr>";
    }
    {
      key = "<leader>4";
      action = "<cmd>BufferLineGoToBuffer 4<cr>";
    }
    {
      key = "<leader>5";
      action = "<cmd>BufferLineGoToBuffer 5<cr>";
    }
    {
      key = "<leader>6";
      action = "<cmd>BufferLineGoToBuffer 6<cr>";
    }
    {
      key = "<leader>7";
      action = "<cmd>BufferLineGoToBuffer 7<cr>";
    }
    {
      key = "<leader>8";
      action = "<cmd>BufferLineGoToBuffer 8<cr>";
    }
    {
      key = "<leader>9";
      action = "<cmd>BufferLineGoToBuffer 9<cr>";
    }
    # transparent keys
    {
      key = "TT";
      action = ":TransparentToggle<cr>";
      options.silent = true;
    }
    # zenmode keys
    {
      key = "<C-w>o";
      action = ":Zen<cr>";
      options.silent = true;
    }
    # gitsigns keys
    {
      key = "<leader>gsh";
      action = ":Gitsigns stage_hunk<cr>";
      options.silent = true;
    }
    {
      key = "<leader>gSh";
      action = ":Gitsigns undo_stage_hunk<cr>";
      options.silent = true;
    }
    {
      key = "<leader>gsb";
      action = ":Gitsigns stage_buffer<cr>";
      options.silent = true;
    }
    {
      key = "<leader>gSb";
      action = ":Gitsigns undo_stage_buffer<cr>";
      options.silent = true;
    }
    {
      key = "<leader>grb";
      action = ":Gitsigns reset_buffer<cr>";
      options.silent = true;
    }
    {
      key = "<leader>grh";
      action = ":Gitsigns reset_hunk<cr>";
      options.silent = true;
    }
    {
      key = "<leader>gph";
      action = ":Gitsigns preview_hunk<cr>";
      options.silent = true;
    }
    {
      key = "<leader>gd";
      action = ":Gitsigns diffthis<cr>";
      options.silent = true;
    }
    {
      mode = [
        "o"
        "x"
      ];
      key = "<leader>gh";
      action = ":<C-U>Gitsigns select_hunk<cr>";
    }
    # oil
    {
      key = "<leader>-";
      action = ":Oil<cr>";
      options.silent = true;
    }
    # floaterm
    {
      key = "<leader>t";
      action = ":FloatermNew --width=0.6 --height=0.4<cr>";
      options.silent = true;
    }
    # expand macro
    {
      key = "<leader>em";
      action = ":RustLsp expandMacro <cr>";
      options.silent = true;
    }
  ];
}
