# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'
{
  inputs,
  pkgs ? import <nixpkgs> { },
  ...
}@_inputs:
{
  karabiner-config = pkgs.callPackage ./karabiner-config { };
  talhelper = inputs.talhelper.packages.${pkgs.system}.default;
}
