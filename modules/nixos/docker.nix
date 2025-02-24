{
  ...
}:
{
  config = {
    virtualisation.docker = {
      enable = true;
      extraOptions = "";
      enableOnBoot = false;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };
}
