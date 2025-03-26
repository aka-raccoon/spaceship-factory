{ pkgs, ... }:
{
  imports = [
    ./mutability.nix
    ./secrets.nix

    ./browsers
    ./desktop
    ./deployment
    ./editor
    ./karabiner-elements
    ./kbs
    ./kubernetes
    ./security
    ./shell
    ./terminals
    ./themes
    ./virtualisation
  ];

  config = {
    home.stateVersion = "23.11";

    programs = {
      home-manager.enable = true;
    };

    xdg.enable = true;

    home.packages = [ pkgs.home-manager ];
  };
}
