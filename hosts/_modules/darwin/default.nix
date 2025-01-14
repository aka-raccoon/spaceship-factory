{ ... }:
{
  imports = [
    ./homebrew.nix
    ./nix.nix
    ./os-defaults.nix
    ./sops.nix
    ./users.nix
  ];

  system = {
    stateVersion = 4; # nix-darwin stateVersion
  };
}
