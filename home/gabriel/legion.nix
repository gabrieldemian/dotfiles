{
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

    # inputs.nixosModules.battery-notifier
    # ../../modules/nixos/battery-notifier.nix

    ./common/core/hyprland
    ./common/core/nixvim
    ./common/core/rio.nix
    ./common/core/starship.nix
    ./common/core/waybar
    ./common/core/wofi
    ./common/core/yazi
    ./common/core/zsh.nix
    ./common/optional/browsers
  ];

  home.packages = with pkgs; [
    google-chrome
    libreoffice-fresh
    # foundry
    discord
    cargo
    mpv
    slack
    tor-browser
    # goxel
    zathura
    ani-cli
    ani-skip
    transmission_4-gtk
    webtorrent_desktop
    ollama-cuda

    (builtins.getFlake "github:fufexan/zen-browser-flake?rev=ef45869321b222cf004728f01e4ec6b4f7ea5f14")
    .packages.x86_64-linux.zen
  ];
}
