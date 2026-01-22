{
  inputs,
  pkgs,
  config,
  ...
}:
{
  config.home = {
    packages = [
      inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    file."${config.xdg.configHome}/ghostty/config" = {
      recursive = true;
      text = ''
        font-size = "18"
        font-family = "Pixel Code"
        window-theme = ghostty
        adw-toolbar-style = flat
        theme = Kanagawa Wave
        background-opacity = 0.88
        background-blur = 30
        window-padding-x = 5

        keybind = "ctrl+super+h=goto_split:left"
        keybind = "ctrl+super+l=goto_split:right"
        keybind = "ctrl+super+j=goto_split:down"
        keybind = "ctrl+super+k=goto_split:up"

        keybind = "ctrl+super+shift+h=resize_split:left,10"
        keybind = "ctrl+super+shift+l=resize_split:right,10"
        keybind = "ctrl+super+shift+j=resize_split:down,10"
        keybind = "ctrl+super+shift+k=resize_split:up,10"
      '';
    };
  };
}
