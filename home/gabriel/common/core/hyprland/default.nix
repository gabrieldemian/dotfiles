{ configLib, pkgs, ... }:
let
  wallpapers = toString (configLib.relativeToRoot "wallpapers");
  wall =
    pkgs.callPackage (configLib.relativeToRoot "home/gabriel/common/core/waybar/scripts/wall.nix")
      { };
in
{
  config.wayland.windowManager.hyprland = {
    enable = true;

    xwayland = {
      enable = true;
    };

    # Whether to enable hyprland-session.target on hyprland startup
    # systemd.enable = true;

    settings = {
      monitor = "eDP-1,2560x1600@240,auto,1,bitdepth,10";
      exec-once = "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP & dunst & awww-daemon --no-cache --format xrgb & waybar & ${wall} ${wallpapers}/frieren_green_eyes.png & ghostty --gtk-single-instance=true --quit-after-last-window-closed=false --initial-window=false &";
      "$terminal" = "alacritty";
      # just because of the kitty image protocol
      "$fileManager" = "ghostty -e yazi";
      "$menu" = "wofi";
      "$mod" = "SUPER";

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "LIBVA_DRIVER_NAME,nvidia"
      ];

      input = {
        kb_layout = "us,it";
        kb_options = "grp:alt_shift_toggle";
        follow_mouse = 1;
        touchpad.natural_scroll = "no";
        sensitivity = 0; # -1.0 to 1.0, 0 means no modification.
        repeat_rate = 50;
        repeat_delay = 250;
      };

      general = {
        allow_tearing = true;
        gaps_in = 8;
        gaps_out = 12;
        border_size = 4;
        "col.active_border" = "rgba(c6a0f6ee) rgba(ed8796ee) 45deg";
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 5;
          passes = 2;
        };
      };

      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      misc.force_default_wallpaper = -1;
      misc.vfr = true;

      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bind = [
        # Toggle game mode to disable animations
        "$mod, G, exec, ${./scripts/gamemode.sh}"
        # essential
        "$mod, Return, exec, $terminal"
        "$mod, W, killactive"
        "$mod, M, exit"
        "$mod, Space, exec, $menu --show drun"
        "$mod, E, exec, [float;center;size 1600 900] $fileManager"
        # floating terminal
        "$mod SHIFT, Return, exec, [float;center;size 1600 900] alacritty"
        #volume
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        # toggles
        "$mod, P, pseudo," # dwindle
        "$mod, V, togglefloating,"
        "$mod, T, togglesplit," # dwindle
        "$mod, F, fullscreen,"
        # switch
        "$mod SHIFT, h, swapwindow, l"
        "$mod SHIFT, l, swapwindow, r"
        "$mod SHIFT, j, swapwindow, d"
        "$mod SHIFT, k, swapwindow, u"
        #resize
        "$mod CTRL, h, resizeactive, -15% 0"
        "$mod CTRL, l, resizeactive, 15% 0"
        "$mod CTRL, j, resizeactive, 0 15%"
        "$mod CTRL, k, resizeactive, 0 -15%"
        # move focus with mod + hjkl
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"
        # Light
        ",code:232,exec,brightnessctl -d intel_backlight set 2%-"
        ",code:233,exec,brightnessctl -d intel_backlight set +2%"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (
          builtins.genList (
            x:
            let
              ws =
                let
                  c = (x + 1) / 10;
                in
                toString (x + 1 - (c * 10));
            in
            [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
            ]
          ) 10
        )
      );
    };
  };
}
