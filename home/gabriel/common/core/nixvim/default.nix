{
  inputs,
  pkgs,
  lib,
  configLib,
  ...
}:
let
  asciiArt = toString (configLib.relativeToRoot "art.txt");
in
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
        under_cursor = true;
        filetypes_denylist = [
          "DressingSelect"
          "Outline"
          "TelescopePrompt"
          "alpha"
          "snacks_dashboard"
          "harpoon"
          "toggleterm"
          "neo-tree"
          "Spectre"
          "reason"
        ];
      };
      treesitter = {
        enable = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          qmljs
          bash
          json
          lua
          rust
          markdown
          nix
          toml
          vim
          vimdoc
          yaml
          c
          zig
          css
          html
        ];
        settings = {
          highlight.enable = true;
          indent.enable = false;
        };
      };
      lsp-signature = {
        enable = true;
      };
      treesitter-context = {
        enable = true;
        autoLoad = true;
      };
      flash.enable = true;
      snacks = {
        enable = true;
        settings = {
          image.enable = true;
          picker.enable = true;
          dashboard = {
            enable = true;
            # centralize col and row
            row = null;
            col = null;
            sections = [
              {
                section = "keys";
                gap = 1;
                padding = 1;
              }
              {
                icon = " ";
                title = "Projects";
                section = "projects";
                indent = 2;
                padding = 1;
              }
              {
                icon = " ";
                title = "Git Status";
                section = "terminal";
                enabled = ''
                            function()
                  return Snacks.git.get_root() ~= nil end
                '';

                cmd = "git status --short --branch --renames";
                height = 5;
                padding = 1;
                ttl = 5 * 60;
                indent = 3;
              }
              {
                pane = 2;
                section = "terminal";
                cmd = "cat ${asciiArt}";
                height = 30;
                padding = 1;
              }
            ];
          };
        };
      };
    };
  };
}
