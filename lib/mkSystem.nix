{
  inputs,
  mkPkgsWithSystem,
  ...
}:
{
  mkNixosSystem =
    system: hostname: users:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      pkgs = mkPkgsWithSystem system;
      modules = [
        {
          nixpkgs.hostPlatform = system;
          _module.args = {
            inherit inputs system;
          };
        }
        inputs.home-manager.nixosModules.home-manager
        inputs.sops-nix.nixosModules.sops
        inputs.stylix.nixosModules.stylix
        {
          home-manager = {
            useUserPackages = true;
            useGlobalPkgs = true;
            sharedModules = [ inputs.sops-nix.homeManagerModules.sops ];
            extraSpecialArgs = {
              inherit inputs hostname system;
            };
            users = inputs.nixpkgs.lib.foldl' (
              acc: user: acc // { "${user}" = ../. + "/homes/${user}"; }
            ) { } users;
          };
        }
        ../hosts/_modules/common
        ../hosts/_modules/nixos
        ../hosts/${hostname}
      ];
      specialArgs = {
        inherit inputs hostname users;
      };
    };

  mkDarwinSystem =
    system: hostname: users:
    inputs.nix-darwin.lib.darwinSystem {
      inherit system;
      pkgs = mkPkgsWithSystem system;
      modules = [
        {
          nixpkgs.hostPlatform = system;
          _module.args = {
            inherit inputs;
          };
        }
        inputs.home-manager.darwinModules.home-manager
        inputs.stylix.darwinModules.stylix
        {
          home-manager = {
            useUserPackages = true;
            useGlobalPkgs = true;
            backupFileExtension = "backup";

            sharedModules = [
              inputs.sops-nix.homeManagerModules.sops
            ];
            extraSpecialArgs = {
              inherit inputs hostname system;
            };
            users = inputs.nixpkgs.lib.foldl' (
              acc: user: acc // { "${user}" = ../. + "/homes/${user}"; }
            ) { } users;
          };
        }
        ../hosts/_modules/common
        ../hosts/_modules/darwin
        ../hosts/${hostname}
      ];
      specialArgs = {
        inherit inputs hostname users;
      };
    };
}
