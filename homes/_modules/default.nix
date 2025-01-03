{ pkgs, ... }:
{
  imports = [
    ./mutability.nix

    ./browsers
    ./desktop
    ./deployment
    ./editor
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
