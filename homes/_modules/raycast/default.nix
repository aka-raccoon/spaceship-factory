{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.raycast;
in
{
  options.modules.raycast = {
    enable = lib.mkEnableOption "Raycast";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [ raycast ];
  };
}
