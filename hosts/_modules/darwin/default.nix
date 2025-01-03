{ ... }:
{
  imports = [
    ./homebrew.nix
    ./nix.nix
    ./os-defaults.nix
  ];

  system = {
    stateVersion = 4; # nix-darwin stateVersion
  };
}
