{ inputs, ... }:
{
  config.programs.nixvim.diagnostic.settings.virtual_text = true;
  config.programs.nixvim.plugins.lsp = {
    enable = true;
    inlayHints = false;

    servers = {
      qmlls = {
        enable = true;
        cmd = ["qmlls" "-E"];
      };

      jsonls.enable = true;
      nixd.enable = true;
      bashls.enable = true;
      biome.enable = true;
      clangd.enable = true;
      cssls.enable = true;
      eslint.enable = true;
      nil_ls.enable = true;
      ruff.enable = true;
      tailwindcss.enable = true;
      zls = {
        enable = true;
        package = inputs.zls-overlay.packages."x86_64-linux".zls;
        settings = {
          enable_build_on_save = true;
          build_on_save_step = "check";
        };
      };
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
