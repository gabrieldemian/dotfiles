{ pkgs, ... }:
let
  yaziOpener = pkgs.writeShellScriptBin "yazi-opener" ''
    exec ${pkgs.ghostty}/bin/ghostty \
      --working-directory="$1" \
      -e ${pkgs.yazi}/bin/yazi
  '';
in
{
  config = {
    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
      plugins = {
        smart_paste = ./plugins/smart_paste;
        smart_enter = ./plugins/smart_enter;
      };
    };
    xdg.desktopEntries.yazi-opener = {
      name = "Yazi Folder Opener";
      exec = "${yaziOpener}/bin/yazi-opener %u";
      type = "Application";
      terminal = false; # Ghostty is a terminal emulator itself
      mimeType = [ "inode/directory" ];
      categories = [
        "Utility"
        "FileManager"
      ];
      noDisplay = true; # Don't show in application menus
    };
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = [ "yazi-opener.desktop" ];
      };
    };
    nix.settings = {
      substituters = [
        "https://yazi.cachix.org"
      ];
      trusted-public-keys = [
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
      ];
    };
  };
}
