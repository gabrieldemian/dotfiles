{ pkgs, ... }:
{
  config.programs.nixvim.plugins.none-ls = {
    enable = true;
    enableLspFormat = false;
    settings.update_in_insert = false;
    # onAttach = ''
    #   function(client, bufnr)
    #       if client.supports_method "textDocument/formatting" then
    #         vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    #       end
    #     end
    # '';
    sources = {
      code_actions = {
        gitsigns.enable = true;
        statix.enable = true;
      };
      diagnostics = {
        checkstyle = {
          enable = true;
        };
        statix = {
          enable = true;
        };
        markdownlint = {
          enable = true;
        };
      };
      formatting = {
        mdformat = {
          enable = true;
        };
        nixfmt = {
          enable = true;
          package = pkgs.nixfmt-rfc-style;
        };
        stylua = {
          enable = true;
        };
        rustywind = {
          enable = true;
        };
      };
    };
  };
}
