{ pkgs, ... }:
{
  config.programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      plenary-nvim
      lazygit-nvim
      catppuccin-nvim
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
