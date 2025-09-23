{
  inputs,
  pkgs,
  config,
  ...
}:
{
  config.home = {
    packages = [
      inputs.ghostty.packages.${pkgs.system}.default
    ];

    file."${config.xdg.configHome}/ghostty/config" = {
      recursive = true;
      text = ''
        font-size = "15"
        font-family = "Pixel Code"
        window-theme = ghostty
        adw-toolbar-style = flat
        # theme = dark:catppuccin-macchiato,light:catppuccin-latte
        theme = Catppuccin Macchiato
        background-opacity = 0.77
        background-blur = 20
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

    file."${config.xdg.configHome}/ghostty/themes/catppuccin-macchiato.conf" = {
      recursive = true;
      text = ''
        palette = 0=#494d64
        palette = 1=#ed8796
        palette = 2=#a6da95
        palette = 3=#eed49f
        palette = 4=#8aadf4
        palette = 5=#f5bde6
        palette = 6=#8bd5ca
        palette = 7=#b8c0e0
        palette = 8=#5b6078
        palette = 9=#ed8796
        palette = 10=#a6da95
        palette = 11=#eed49f
        palette = 12=#8aadf4
        palette = 13=#f5bde6
        palette = 14=#8bd5ca
        palette = 15=#a5adcb
        background = 24273a
        foreground = cad3f5
        cursor-color = f4dbd6
        cursor-text = 24273a
        selection-background = 3a3e53
        selection-foreground = cad3f5
      '';
    };

    file."${config.xdg.configHome}/ghostty/themes/catppuccin-frappe.conf" = {
      recursive = true;
      text = ''
        palette = 0=#51576d
        palette = 1=#e78284
        palette = 2=#a6d189
        palette = 3=#e5c890
        palette = 4=#8caaee
        palette = 5=#f4b8e4
        palette = 6=#81c8be
        palette = 7=#b5bfe2
        palette = 8=#626880
        palette = 9=#e78284
        palette = 10=#a6d189
        palette = 11=#e5c890
        palette = 12=#8caaee
        palette = 13=#f4b8e4
        palette = 14=#81c8be
        palette = 15=#a5adce
        background = 303446
        foreground = c6d0f5
        cursor-color = f2d5cf
        cursor-text = 303446
        selection-background = 44495d
        selection-foreground = c6d0f5
      '';
    };
  };
}
