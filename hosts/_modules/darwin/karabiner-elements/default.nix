{
  lib,
  config,
  ...
}:
let
  cfg = config.modules.karabiner-elements;
in
{
  options.modules.karabiner-elements = {
    enable = lib.mkEnableOption "karabiner-elements";
  };
  config = lib.mkIf cfg.enable {
    services.karabiner-elements = {
      enable = true;
    };
  };
}
