{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.modules.security._1password;
in
{
  options.modules.security._1password = {
    enable = lib.mkEnableOption "1password";
  };
  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      home.packages = [
        pkgs._1password-cli
      ];
    })
  ];
}
