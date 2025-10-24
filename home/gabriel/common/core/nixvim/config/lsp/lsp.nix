{ ... }:
{
  config.programs.nixvim.diagnostic.settings.virtual_text = true;
  config.programs.nixvim.plugins.lsp = {
    enable = true;
    inlayHints = false;

    servers = {
      astro.enable = true;
      bashls.enable = true;
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
        enable = false;
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
