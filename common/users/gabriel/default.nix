#
{
  pkgs,
  config,
  configLib,
  ...
}:
# pubKeys = lib.filesystem.listFilesRecursive ./keys;
{
  config =
    # lib.recursiveUpdate fullUserConfig
    #this is the second argument to recursiveUpdate
    {
      home-manager.users."gabriel" = import (
        configLib.relativeToRoot "home/gabriel/${config.networking.hostName}.nix"
      );
      users = {
        # mutableUsers = false; # Only allow declarative credentials; Required for sops
        users."gabriel" = {
          home = "/home/gabriel";
          isNormalUser = true;
          # password = "nixos"; # Overridden if sops is working

          extraGroups = [
            "adm"
            "audio"
            "bluetooth"
            "input"
            "git"
            "networkmanager"
            "plugdev"
            "video"
            "wheel"
            "docker"
          ];
          # These get placed into /etc/ssh/authorized_keys.d/<name> on nixos
          # openssh.authorizedKeys.keys = lib.lists.forEach pubKeys (key: builtins.readFile key);

          shell = pkgs.zsh;
        };

        # Proper root user required for borg and some other specific operations
        users.root = {
          shell = pkgs.zsh;
          # hashedPasswordFile = config.users.users.${configVars.username}.hashedPasswordFile;
          # password = lib.mkForce config.users.users.${configVars.username}.password;
          # root's ssh keys are mainly used for remote deployment.
          # openssh.authorizedKeys.keys = config.users.users.${configVars.username}.openssh.authorizedKeys.keys;
        };
      };

      # -- packages and programs that this user will have in all hosts --

      # create ssh sockets directory for controlpaths when homemanager not loaded (i.e. isminimal)
      # systemd.tmpfiles.rules = let
      #   user = config.users.users.${configVars.username}.name;
      #   group = config.users.users.${configVars.username}.group;
      # in ["d /home/${configVars.username}/.ssh/sockets 0750 ${user} ${group} -"];

      # No matter what environment we are in we want these tools for root, and the user(s)
      programs = {
        direnv.enable = true;
        direnv.enableZshIntegration = true;
        zsh.enable = true;
        git.enable = true;
      };

      environment = {
        shells = [ pkgs.zsh ];

        variables = {
          EDITOR = "$(which nvim)";
          SYSTEM_EDITOR = "$(which nvim)";
          VISUAL = "$(which nvim)";
        };
      };

      environment.systemPackages = with pkgs; [
        # just
        # rsync
        nodejs
      ];
    };
}
