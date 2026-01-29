{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./common/core

    ./common/core/git.nix
    ./common/core/fonts.nix
    ./common/core/gtk.nix
    ./common/core/quickshell.nix

    ./common/core/bat.nix
    ./common/core/dunst.nix
    ./common/core/hyprland
    ./common/core/nixvim
    ./common/core/ghostty.nix
    ./common/core/starship.nix
    ./common/core/waybar
    ./common/core/wofi
    ./common/core/yazi
    ./common/core/zsh.nix
    ./common/optional/browsers
  ];

  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = 41.4575;
    longitude = 12.661111;
    temperature.day = 6000;
    temperature.night = 2000;
  };

  home.packages = with pkgs; [
    imagemagick
    chafa
    irssi
    qbittorrent
    lutris
    protonup-rs
    winePackages.waylandFull
    winetricks
    google-chrome
    libreoffice-fresh
    discord
    cargo
    mpv
    zathura
    ani-cli
    feh
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
