{
  pkgs,
  configLib,
  ...
}:
let
  root = builtins.toString (configLib.relativeToRoot "./");
in
{
  config = {
    home.packages = with pkgs; [
      zoxide
    ];
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;

      dotDir = ".config/zsh";

      oh-my-zsh = {
        enable = true;
        plugins = [ "docker" "fzf" "ssh" ];
      };

      history = {
        save = 10000;
        size = 10000;
      };

      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.7.0";
            # this can be obtained with:
            # nix-prefetch-git <url>
            sha256 = "1g3pij5qn2j7v7jjac2a63lxd97mcsgw6xq6k5p7835q9fjiid98";
          };
        }
      ];

      shellAliases = {
        nrs = "sudo nixos-rebuild switch --flake ${root}";
        "docker-clean" = "docker system prune --all -f --volumes";
        adog = "git log --all --decorate --oneline --graph";
        glog = "git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit";
        glog2 = "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all";
        nix-clean = "sudo nix-collect-garbage --delete-older-than";
        ".." = "cd ..";
        "..." = "cd ../..";
        "~" = "cd ~";
        v = "nvim";
        r = "yazi";
        l = "eza -al --icons --group-directories-first";
        ll = "eza -a --icons --group-directories-first";
        gs = "git status";
        gc = "git commit -m";
        gca = "git commit -a -m";
        gp = "git push";
        "gp!" = "git push --force";
        gpu = "git pull origin";
        gf = "git fetch --all";
      };

      initContent = ''
        export XDG_CONFIG_HOME="$HOME/.config";
        function yy() {
        	if [ -n "$YAZI_LEVEL" ]; then
        		exit
        	fi

        	local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
        	yazi "$@" --cwd-file="$tmp"
        	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        		cd -- "$cwd"
        	fi
        	rm -f -- "$tmp"
        }

        if uwsm check may-start && uwsm select; then
          exec systemd-cat -t uwsm_start uwsm start default
        fi
      '';
    };
  };
}
