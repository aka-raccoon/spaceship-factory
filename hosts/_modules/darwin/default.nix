{ ... }:
{
  imports = [
    ./aerospace
    ./karabiner-elements
    ./homebrew.nix
    ./nix.nix
    ./os-defaults.nix
    ./sops.nix
    ./users.nix
    ./hammerspoon
  ];

  system = {
    stateVersion = 4; # nix-darwin stateVersion
  };
}
