{
  inputs,
  hostname,
  ...
}:
{
  imports = [
    ../_modules
    ./hosts/${hostname}.nix
  ];

  modules = {
    editor = {
      nvim = {
        enable = true;
        makeDefaultEditor = true;
      };
    };

    security = {
      ssh = {
        enable = true;
      };
    };

    shell = {
      atuin = {
        enable = false;
      };
      fish.enable = true;

      git = {
        enable = true;
        inherit (inputs.secrets.corporate) username;
        inherit (inputs.secrets.corporate) email;
        services = {
          inputs.secrets.corporate.gitUrl = "github:${inputs.secrets.corporate.gitUrl}";
        };
      };

      go-task.enable = true;
    };
    virtualisation = {
      docker-cli = {
        enable = true;
      };
      colima = {
        enable = true;
        startService = true;
      };
    };
    themes = {
      cyberdream = {
        enable = true;
      };
    };
  };
}
