{
  inputs,
  pkgs,
  lib,
  hostname,
  ...
}:
{
  config = {
    networking = {
      computerName = "amb";
      hostName = hostname;
      localHostName = hostname;
    };

    users.users.c4300n = {
      name = "c4300n";
      home = "/Users/c4300n";
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = lib.strings.splitString "\n" (
        builtins.readFile inputs.secrets.ssh_pub_key
      );
    };

    system.activationScripts.postActivation.text = ''
      # Must match what is in /etc/shells
      sudo chsh -s /run/current-system/sw/bin/fish c4300n
    '';

    homebrew = {
      taps = [ ];
      brews = [ ];
      masApps = { };
    };
  };
}
