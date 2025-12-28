{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./config/opts.nix
    ./config/extra.nix
    ./config/lualine.nix
    ./config/conform.nix
    ./config/lsp/lsp.nix
    ./config/lsp/lspkind.nix
    ./config/none-ls.nix
    ./config/bufferline.nix
    ./config/rustaceanvim.nix
    ./config/cmp.nix
    ./config/keymaps.nix
    ./config/dap.nix
  ];

  config.programs.nixvim = {
    enable = true;
    defaultEditor = true;

    extraPackages =
      with pkgs;
      [
        coreutils
        lldb
        netcoredbg
      ]
      ++ lib.optionals pkgs.stdenv.isLinux [
        pkgs.gdb
      ];

    # plugins that dont deserve their own module
    plugins = {
      floaterm.enable = true;
      web-devicons.enable = true;
      indent-blankline.enable = true;
      gitsigns.enable = true;
      vim-surround.enable = true;
      nvim-autopairs.enable = true;
      autoclose.enable = true;
      comment.enable = true;
      colorizer.enable = true;
      luasnip.enable = true;
      zen-mode.enable = true;
      snacks = {
        enable = true;
        settings = {
          image.enable = true;
          picker.enable = true;
        };
      };
      flash.enable = true;
      oil = {
        enable = true;
        settings = {
          default_file_explorer = true;
          columns = [ "icon" ];
          keymaps = {
            "g?" = "actions.show_help";
            "<CR>" = "actions.select";
            "<C-s>" = "actions.select_vsplit";
            "<C-h>" = "actions.select_split";
            "<C-t>" = "actions.select_tab";
            "<C-p>" = "actions.preview";
            "<C-c>" = "actions.close";
            "<C-l>" = "actions.refresh";
            "-" = "actions.parent";
            "_" = "actions.open_cwd";
            "`" = "actions.cd";
            "~" = "actions.tcd";
            "gs" = "actions.change_sort";
            "gx" = "actions.open_external";
            "g." = "actions.toggle_hidden";
            "g\\" = "actions.toggle_trash";
          };
        };
      };
      fidget = {
        enable = true;
      };
      gitsigns.settings = {
        signs = {
          add.text = "+";
          change.text = "~";
          delete.text = "_";
          topdelete.text = "‾";
          changedelete.text = "~";
        };
        current_line_blame = false;
      };
      illuminate = {
        enable = true;
        underCursor = true;
        filetypesDenylist = [
          "DressingSelect"
          "Outline"
          "TelescopePrompt"
          "alpha"
          "harpoon"
          "toggleterm"
          "neo-tree"
          "Spectre"
          "reason"
        ];
      };
      lsp-signature = {
        enable = true;
      };
      treesitter-context = {
        enable = true;
        autoLoad = true;
      };
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent = {
            enable = true;
          };
          ensure_installed = [
            "rust"
            "bash"
            "norg"
            "typescript"
            "c"
            "json"
            "lua"
            "zig"
            "css"
            "markdown"
            "vim"
            "html"
            "git_config"
            "git_rebase"
            "gitattributes"
            "gitcommit"
            "gitignore"
          ];
        };
      };
    };
  };
}
