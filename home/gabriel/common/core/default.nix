# Gabriel user config that will be inherited by all hosts
{
  config,
  lib,
  pkgs,
  outputs,
  configLib,
  ...
}:
{
  # import everything from core
  imports = (configLib.scanPaths ./.) ++ (builtins.attrValues outputs.homeModules);

  services.ssh-agent.enable = true;

  home = {
    username = lib.mkDefault "gabriel";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "23.11";
    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/.cargo/bin"
    ];
    sessionVariables = {
      TERM = "ghostty";
      TERMINAL = "ghostty";
    };
    preferXdgDirectories = true; # whether to make programs use XDG directories whenever supported
  };

  xdg = {
    enable = true;
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
      ];
      config = {
        pantheon = {
          default = [
            "pantheon"
          ];
          "org.freedesktop.impl.portal.Secret" = [
            "gnome-keyring"
          ];
        };
        x-cinnamon = {
          default = [
            "xapp"
          ];
        };
      };
    };
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "${config.home.homeDirectory}/.desktop";
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/images";
      videos = "${config.home.homeDirectory}/videos";
      extraConfig = {
        # publicshare and templates defined as null here instead of as options because
        XDG_PUBLICSHARE_DIR = "/var/empty";
        XDG_TEMPLATES_DIR = "/var/empty";
      };
    };
  };

  home.packages = builtins.attrValues {
    inherit (pkgs)
      # Packages that don't have custom configs go here
      coreutils # basic gnu utils
      eza # ls replacement
      fd # tree style ls
      fzf # fuzzy search
      neofetch # fancier system info than pfetch
      ncdu # TUI disk usage
      p7zip # compression & encryption
      ripgrep # better grep
      lazygit
      tealdeer
      killall
      unzip # zip extraction
      xdg-utils # provide cli tools such as `xdg-mime` and `xdg-open`
      xdg-user-dirs
      bottom
      ;
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };
  };

  programs = {
    home-manager.enable = true;
    neovim.defaultEditor = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
