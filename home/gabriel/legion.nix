{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./common/core

    ./common/core/bat.nix
    ./common/core/dunst.nix
    ./common/core/fonts.nix
    ./common/core/git.nix
    ./common/core/gtk.nix

    ./common/core/hyprland
    ./common/core/nixvim
    ./common/core/rio.nix
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
    latitude = 48.85661400;
    longitude = 2.35222190;
    temperature.day = 6000;
    temperature.night = 2000;
  };

  home.packages = with pkgs; [
    qbittorrent-nox
    hexchat
    weechat
    nicotine-plus
    cross-seed
    google-chrome
    libreoffice-fresh
    discord
    cargo
    mpv
    slack
    tor-browser
    zathura
    ani-cli
    transmission_4-gtk
    feh
    inputs.zen-browser.packages.${pkgs.system}.default
  ];
}
