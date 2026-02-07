{ ... }:
{
  config.programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    plugins = {
      smart_paste = ./plugins/smart_paste;
      smart_enter = ./plugins/smart_enter;
    };
  };
}
