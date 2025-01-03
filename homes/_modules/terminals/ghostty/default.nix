{
  lib,
  config,
  ...
}:
let
  cfg = config.modules.terminals.ghostty;
in
{
  options.modules.terminals.ghostty = {
    enable = lib.mkEnableOption "ghostty";
  };

  config = lib.mkIf cfg.enable {

    home = {
      sessionVariables = {
        TERM = "xterm-256color";
      };
    };
    xdg.configFile."ghostty/config".source = ./config;
  };
}
