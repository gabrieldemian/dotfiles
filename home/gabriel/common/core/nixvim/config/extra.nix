{ pkgs, ... }:
{
  config.programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      plenary-nvim
      lazygit-nvim
      catppuccin-nvim
      (pkgs.vimUtils.buildVimPlugin {
        name = "black-metal";
        src = pkgs.fetchFromGitHub {
          owner = "metalelf0";
          repo = "black-metal-theme-neovim";
          rev = "d7ce1c4b9196b3b34e70ca4fa9af108bb4207818";
          hash = "sha256-0RY/kek2QoL3ZIWehJFQIFOOpAgCrh/POpKklzQ2UKw=";
        };
      })
      everforest
    ];

    extraConfigLua = ''
      local Map = vim.keymap.set

      require("catppuccin").setup({
        flavour = "macchiato",
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          notify = false,
        },
      })

      Map("n", "<leader>lg", ": LazyGit<cr>")

    '';
  };
}
