{
  ...
}:
{
  programs.hyprland = {
    enable = true;
    # The above option generates a new desktop entry, hyprland-uwsm.desktop, which will be available in display managers.
    withUWSM = true;
  };

  # environment.systemPackages = [
  #   pkgs.hyprlandPlugins.hy3
  #   inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
  # ];
}
