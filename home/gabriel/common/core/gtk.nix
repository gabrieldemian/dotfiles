{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  config = {
    gtk = {
      enable = true;
      colorScheme = "dark";
      theme.name = "Breeze-Dark";
      theme.package = pkgs.kdePackages.breeze-gtk;
      iconTheme.name = "Papirus-Dark";
    };
    home = {
      packages = with pkgs; [
        kdePackages.breeze-icons
      ];
      pointerCursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 24;
        gtk.enable = true;
        x11.enable = true;
      };
      sessionVariables = {
        GTK_USE_PORTAL = "1";
      };
    };
  };
}
