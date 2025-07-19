{ ... }:
{
  config.programs.nixvim.plugins.lualine = {
    enable = true;

    settings = {
      options = {
        theme = "catppuccin";
        alwaysDivideMiddle = true;
        globalstatus = true;

        # sectionSeparators = {
        #   left = "❘";
        #   right = "❘";
        # };

        sectionSeparators = {
          left = "";
          right = "";
        };
      };

      # +-------------------------------------------------+
      # | A | B | C                             X | Y | Z |
      # +-------------------------------------------------+
      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" ];
        lualine_c = [
          "filename"
          "diff"
        ];
        lualine_x = [
          "diagnostics"

          # Show active language server
          {
            __unkeyed.__raw = ''
              function()
                  local msg = ""
                  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                  local clients = vim.lsp.get_clients()
                  if next(clients) == nil then
                      return msg
                  end
                  for _, client in ipairs(clients) do
                      local filetypes = client.config.filetypes
                      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                          return client.name
                      end
                  end
                  return msg
              end
            '';
            icon = "";
            color.fg = "#ffffff";
          }
          "encoding"
          "fileformat"
          "filetype"
        ];
        lualine_y = [ "progress" ];
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
