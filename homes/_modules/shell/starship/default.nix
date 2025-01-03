{ pkgs, ... }:
{
  config = {
    programs.starship = {
      enable = true;
      package = pkgs.unstable.starship;
      enableFishIntegration = true;
      enableTransience = true;
      settings = {
        add_newline = false;
      };
    };
  };
}
