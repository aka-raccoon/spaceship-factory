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

    # home = {
    #   sessionVariables = {
    #     XDG_DATA_DIRS = "\${XDG_DATA_DIRS}:$GHOSTTY_SHELL_INTEGRATION_XDG_DIR";
    #   };
    # };
    xdg.configFile."ghostty/config".source = ./config;
  };
}
