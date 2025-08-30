{ config, ... }:
{
  config.programs.nixvim.plugins.rustaceanvim = {
    enable = true;

    settings = {
      dap = {
        autoloadConfigurations = true;
      };
      server = {
        standalone = false;
        # cmd = [
        #   "rustup"
        #   "run"
        #   "nightly"
        #   "rust-analyzer"
        # ];

        enable = true;

        default_settings = {

          rustc.source = "discover";

          rust_analyzer = {
            check = {
              command = "clippy";
            };
            inlayHints = {
              lifetimeElisionHints = {
                enable = "always";
              };
            };
          };
        };
      };
    };

  };
}
