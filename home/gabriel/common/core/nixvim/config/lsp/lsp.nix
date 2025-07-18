{ ... }:
{
  config.programs.nixvim.extraConfigLua = ''
    local _border = "rounded"

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, {
        border = _border
      }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help, {
        border = _border
      }
    )

    vim.diagnostic.config{
      float={border=_border}
    };

    require('lspconfig.ui.windows').default_options = {
      border = _border
    }
  '';
  config.programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      astro.enable = true;
      bashls.enable = true;
      volar.enable = true;
      biome.enable = true;
      clangd.enable = true;
      cssls.enable = true;
      eslint.enable = true;
      # marksman.enable = true;
      nil_ls.enable = true;
      ruff.enable = true;
      tailwindcss.enable = true;
      zls.enable = true;
      rust_analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
        settings = {
          hint = {
            enable = true;
          };
          cargo.features = "all";
          checkOnSave = true;
          check.command = "clippy";
          inlayHints = {
            enable = true;
            showParameterNames = true;
            parameterHintsPrefix = "<- ";
            otherHintsPrefix = "=> ";
          };
          procMacro = {
            enable = true;
          };
        };
      };
      lua_ls = {
        enable = true;
        extraOptions = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace";
              };
              telemetry = {
                enabled = false;
              };
              hint = {
                enable = true;
              };
            };
          };
        };
      };
      ts_ls = {
        enable = true;
        filetypes = [
          "vue"
          "javascript"
          "javascriptreact"
          "typescript"
          "typescriptreact"
        ];
        extraOptions = {
          settings = {
            javascript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true;
                includeInlayFunctionLikeReturnTypeHints = true;
                includeInlayFunctionParameterTypeHints = true;
                includeInlayParameterNameHints = "all";
                includeInlayParameterNameHintsWhenArgumentMatchesName = true;
                includeInlayPropertyDeclarationTypeHints = true;
                includeInlayVariableTypeHints = true;
              };
            };
            typescript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true;
                includeInlayFunctionLikeReturnTypeHints = true;
                includeInlayFunctionParameterTypeHints = true;
                includeInlayParameterNameHints = "all";
                includeInlayParameterNameHintsWhenArgumentMatchesName = true;
                includeInlayPropertyDeclarationTypeHints = true;
                includeInlayVariableTypeHints = true;
              };
            };
          };
        };
      };
    };
  };
}
