{
  config,
  lib,
  ...
}:

{
  config = lib.mkIf config.services.karabiner-elements.enable or false {
    xdg.configFile."karabiner/karabiner.json".text = ''
      {
        "profiles": [
          {
            "name": "Default profile",
            "selected": true,
            "simple_modifications": {
              "caps_lock": "left_control"
            }
          }
        ]
      }
    '';
  };
}
