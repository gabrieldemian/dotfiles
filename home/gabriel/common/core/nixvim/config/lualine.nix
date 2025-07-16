{ ... }:
{
  config.programs.nixvim.plugins.lualine = {
    enable = true;

    settings = {
      options = {
        theme = "catppuccin";
        alwaysDivideMiddle = true;
        globalstatus = true;
        componentSeparators = {
          left = "❘";
          right = "❘";
        };
        sectionSeparators = {
          left = "";
          right = "";
        };
      };
      sections = {
        lualine_b = [
          {
            __unkeyed-1 = "branch";
            icon = "";
            color.bg = "#1e1e2e";
          }
          {
            __unkeyed-1 = "diagnostics";
            color.bg = "#1e1e2e";
          }
        ];
        lualine_c = [
          {
            __unkeyed-1 = "filename";
            color.bg = "#1e1e2e";
          }
        ];
        lualine_x = null;
        lualine_y = [
          {
            __unkeyed-1 = "progress";
            color.bg = "#1e1e2e";
          }
        ];
        # lualine_z = [
        #   {
        #     name = ''"" .. os.date("%R")'';
        #   }
        # ];
        lualine_z = [
          {
            __unkeyed-1 = "location";
          }
        ];
      };
      extensions = [
        "fzf"
        "oil"
        "nvim-dap-ui"
        "trouble"
      ];
    };

  };
}
