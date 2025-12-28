{ ... }:
{
  config.programs.nixvim = {
    plugins.trouble = {
      enable = true;
      settings = {
        auto_close = true;
        modes = {
          lsp_float = {
            mode = "lsp";
            focus = true;
            win = {
              title = "Diagnostics";
              type = "float";
              border = "rounded";
              size.width = 0.3;
              size.height = 0.3;
            };
          };
          lsp_implementations = {
            mode = "lsp_implementations";
            focus = true;
            win = {
              title = "Implementations";
              type = "float";
              border = "rounded";
              size.width = 0.3;
              size.height = 0.3;
            };
          };
          preview_float = {
            mode = "diagnostics";
            focus = true;
            preview = {
              type = "split";
              relative = "win";
              position = "right";
              size.width = 0.5;
              size.height = 0.3;
            };
          };
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>xx";
        action = "<cmd>Trouble diagnostics preview_float<cr>";
        options = {
          silent = true;
          desc = "Diagnostics (Trouble)";
        };
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>Trouble diagnostics preview_float filter.buf=0<cr>";
        options = {
          silent = true;
          desc = "Buffer Diagnostics (Trouble)";
        };
      }
      {
        mode = "n";
        key = "gd";
        action = "<cmd>Trouble lsp_float<cr>";
        options = {
          silent = true;
          desc = "LSP Definitions / references / ... (Trouble)";
        };
      }
      {
        mode = "n";
        key = "gD";
        action = "<cmd>Trouble lsp_definitions<cr>";
        options = {
          silent = true;
          desc = "LSP go to definition";
        };
      }
      {
        mode = "n";
        key = "gi";
        action = "<cmd>Trouble lsp_implementations<cr>";
        options = {
          silent = true;
          desc = "Preview type";
        };
      }
      {
        mode = "n";
        key = "<leader>xL";
        action = "<cmd>Trouble loclist toggle<cr>";
        options = {
          silent = true;
          desc = "Location list (Trouble)";
        };
      }
      {
        mode = "n";
        key = "<leader>cs";
        action = "<cmd>Trouble symbols toggle focus=true<cr>";
        options = {
          silent = true;
          desc = "Symbols (Trouble)";
        };
      }
      {
        mode = "n";
        key = "<leader>xQ";
        action = "<cmd>Trouble qflist toggle<cr>";
        options = {
          silent = true;
          desc = "Quickfix list (Trouble)";
        };
      }
    ];
  };
}
