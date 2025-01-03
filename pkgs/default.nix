# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'
{
  inputs,
  pkgs ? import <nixpkgs> { },
  ...
}@_inputs:
{
  shcopy = pkgs.callPackage ./shcopy.nix { };
  talhelper = inputs.talhelper.packages.${pkgs.system}.default;
}
