{
  config.programs.rio = {
    enable = true;
    package =
      (builtins.getFlake "github:raphamorim/rio?rev=c89e640a672f8363c23b0022c84cf0485faa621d")
      .packages.x86_64-linux.rio;
    settings = {
      navigation.mode = "TopTab";
      padding-x = 10;
      padding-y = [
        10
        10
      ];
      window = {
        blur = true;
        opacity = 0.9;
      };
      fonts =
        let
          family = "Pixel Code";
        in
        {
          inherit family;
          size = 18;
          regular = {
            style = "Normal";
            inherit family;
            weight = 300;
          };
          bold = {
            style = "Normal";
            inherit family;
            weight = 700;
          };
          italic = {
            style = "Italic";
            inherit family;
            weight = 300;
          };
          "bold-italic" = {
            style = "Italic";
            inherit family;
            weight = 700;
          };
        };
      bindings = {
        keys =
          [
            {
              "with" = "control | shift";
              key = "space";
              action = "ToggleVIMode";
            }
            {
              "with" = "control | shift";
              key = "r";
              action = "SplitRight";
            }
            {
              "with" = "command | shift";
              key = "d";
              action = "SplitDown";
            }
            {
              "with" = "control | shift";
              key = "q";
              action = "CloseSplitOrTab";
            }
            {
              "with" = "control | shift";
              key = "t";
              action = "CreateTab";
            }
            {
              "with" = "control | shift";
              key = "o";
              action = "SelectNextSplit";
            }
            {
              "with" = "control | shift";
              key = "i";
              action = "SelectPrevSplit";
            }
          ]
          # keybindings for tab(index)
          ++ (builtins.concatLists (
            builtins.genList (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 9));
              in
              [
                {
                  key = "${ws}";
                  "with" = "control";
                  action = "SelectTab(${toString x})";
                }
              ]
            ) 9
          ));
      };
      renderer = {
        backend = "Vulkan";
      };
      editor.program = "nvim";
      editor.args = [ "$1" ];
      colors = {
        foreground = "#cdd6f4";
        background = "#1e1e2e";
        black = "#45475a";
        blue = "#89b4fa";
        cyan = "#94e2d5";
        green = "#a6e3a1";
        magenta = "#f5c2e7";
        red = "#f38ba8";
        white = "#bac2de";
        yellow = "#f9e2af";
        cursor = "#f38ba8";
        vi-cursor = "#a6e3a1";
        tabs = "#1e1e2e";
        tabs-active = "#f38ba8";
        selection-background = "#f5e0dc";
        search-match-background = "#89b4f4";
        search-match-foreground = "#FFFFFF";
        search-focused-match-background = "#f9e2af";
        search-focused-match-foreground = "#FFFFFF";
        selection-foreground = "#0F0D0E";
        dim-black = "#45475a";
        dim-blue = "#89b4fa";
        dim-cyan = "#94e2d5";
        dim-foreground = "#cdd6f4";
        dim-green = "#a6e3a1";
        dim-magenta = "#f5c2e7";
        dim-red = "#f38ba8";
        dim-white = "#bac2de";
        dim-yellow = "#f9e2af";
        light-black = "#585b70";
        light-blue = "#89b4fa";
        light-cyan = "#94e2d5";
        light-foreground = "#cdd6f4";
        light-green = "#a6e3a1";
        light-magenta = "#f5c2e7";
        light-red = "#f38ba8";
        light-white = "#a6adc8";
        light-yellow = "#f9e2af";
      };
    };
  };
}
