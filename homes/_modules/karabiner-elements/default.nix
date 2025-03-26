{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.modules.karabiner-elements;
  rules = import ./rules.nix { inherit config pkgs lib; };
in
{
  options.modules.karabiner-elements = {
    enable = lib.mkEnableOption "karabiner-elements";
  };
  config = lib.mkIf cfg.enable {
    xdg.configHome."karabiner".text = builtins.toJSON {
      global = {
        show_in_menu_bar = false;
      };
      profiles = [
        {
          name = "Default";
          complex_modifications = {
            inherit rules;
          };
        }
      ];
    };
  };
}
