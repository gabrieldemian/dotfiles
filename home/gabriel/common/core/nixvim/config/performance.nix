{
  flake.modules.homeManager.core = {
    programs.nixvim = {
      luaLoader.enable = true;

      performance = {
        combinePlugins = {
          enable = true;
        };
        byteCompileLua.enable = true;
      };
    };
  };
}
