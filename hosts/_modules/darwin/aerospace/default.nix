{
  lib,
  config,
  ...
}:
let
  cfg = config.modules.aerospace;
in
{
  options.modules.filesystems.aerospace = {
    enable = lib.mkEnableOption "aerospace";
  };
  config = lib.mkIf cfg.enable {
    services.aerospace = {
      enable = true;
      settings = {
        start-at-login = false;
      };
    };
  };
}
