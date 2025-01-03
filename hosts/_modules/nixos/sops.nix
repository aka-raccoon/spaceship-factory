# TODO: Figure out dependency on user profile
{
  pkgs,
  config,
  ...
}: let
  ageKeyFile = "${config.users.users.c4300n.home}/.config/age/keys.txt";
in {
  config = {
    environment.systemPackages = [
      pkgs.sops
      pkgs.age
    ];

    sops = {
      age.keyFile = ageKeyFile;
      age.generateKey = true;
    };
  };
}
