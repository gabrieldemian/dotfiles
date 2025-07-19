{ config, ... }:
{
  config.programs.nixvim = {
    globals = {
      mapleader = " ";
    };
    colorschemes.catppuccin.enable = true;
    globals = {
      # Disable useless providers
      loaded_ruby_provider = 0; # Ruby
      loaded_perl_provider = 0; # Perl
      loaded_python_provider = 0; # Python 2
    };
    opts = {
      relativenumber = true;
      termguicolors = true;
      cursorline = true;
      number = true;
      tabstop = 2;
      shiftwidth = 2;
      softtabstop = 0;
      expandtab = true;
      swapfile = false;
      showmode = false;
    };
  };
}
