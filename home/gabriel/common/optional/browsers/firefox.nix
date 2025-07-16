{ config, inputs, ... }:
let
  home_dir = config.home.homeDirectory;
in
{
  imports = [ inputs.betterfox.homeManagerModules.betterfox ];
  programs.firefox = {
    enable = true;

    betterfox = {
      enable = true;
      version = "main"; # Set version here, defaults to main branch
    };

    # Refer to https://mozilla.github.io/policy-templates or `about:policies#documentation` in firefox
    policies = {
      AppAutoUpdate = false; # Disable automatic application update
      BackgroundAppUpdate = false; # Disable automatic application update in the background, when the application is not running.
      DefaultDownloadDirectory = "${config.home.homeDirectory}/downloads";
      DisableBuiltinPDFViewer = false;
      DisableFirefoxStudies = true;
      DisableFirefoxAccounts = false; # Enable Firefox Sync
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      OfferToSaveLogins = false; # Managed by Proton
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
        # Exceptions = ["https://example.com"]
      };
      ExtensionUpdate = false;

      # To copy extensions from an existing profile you can do something like this:
      # cat ~/.mozilla/firefox/fb8sickr.default/extensions.json | jq '.addons[] | [.defaultLocale.name, .id]'
      #
      # To add additional extensions, find it on addons.mozilla.org, find
      # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
      # Then, download the XPI by filling it in to the install_url template, unzip it,
      # run `jq .browser_specific_settings.gecko.id manifest.json` or
      # `jq .applications.gecko.id manifest.json` to get the UUID
      ExtensionSettings =
        let
          extension = shortId: uuid: {
            name = uuid;
            value = {
              install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
              installation_mode = "normal_installed";
            };
          };
        in
        builtins.listToAttrs [
          # quality of life
          (extension "dark" "{firefox-compact-dark@mozilla.org}")

          # Privacy / Security
          (extension "bitwarden" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
          # (extension "noscript" "{73a6fe31-595d-460b-a920-fcc0f8843232}")
          (extension "ublock-origin" "uBlock0@raymondhill.net")
          # (extension "ignore-cookies" "jid1-KKzOGWgsW3Ao4Q@jetpack") # failed # Ignore cookie setting pop-ups
          # (extension "privacy-badger17" "jid1-MnnxcxisBPnSXQ@jetpack")
          # (extension "cookie-autodelete" "CookieAutoDelete@kennydo.com")

          # Layout / Themeing
          # (extension "tree-style-tab" "treestyletab@piro.sakura.ne.jp")
          (extension "darkreader" "addon@darkreader.org")

          # Voice
          (extension "domain-in-title" "{966515fa-4c81-4afe-9879-9bbaf8576390}")
          #(extension "rango" "rango@david-tejada")

          # Misc
          (extension "s3download-statusbar" "{6913849f-c79f-4f3e-83e4-890d91ad6154}")
          # (extension "auto-tab-discard" "{c2c003ee-bd69-42a2-b0e9-6f34222cb046}")
        ];
    };

    profiles.main = {
      id = 0;
      name = "betterfox";
      isDefault = true;

      betterfox = {
        enable = true;
        enableAllSections = true;

        # To enable/disable specific sections
        fastfox.enable = true;

        # To enable/disable specific subsections
        peskyfox = {
          enable = true;
          mozilla-ui.enable = false;
        };

        # To enable/disable specific options
        securefox = {
          enable = true;
          tracking-protection."browser.download.start_downloads_in_tmp_dir".value = false;
        };
      };
    };
  };
  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox.desktop" ];
    "text/xml" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
  };
}
