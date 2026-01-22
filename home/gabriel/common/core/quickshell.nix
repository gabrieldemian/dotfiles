{
  pkgs,
  ...
}:
{
  config.home.packages = [
    pkgs.quickshell
    pkgs.kdePackages.qtdeclarative
  ];
  config.home.sessionVariables = {
    QML_IMPORT_PATH = "/home/gabriel/.nix-profile/lib/qt-6/qml";
  };
}
