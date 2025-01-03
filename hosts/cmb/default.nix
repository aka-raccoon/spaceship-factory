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
      computerName = "cmb";
      hostName = hostname;
      localHostName = hostname;
    };

    users.users.I572068 = {
      name = "I572068";
      home = "/Users/I572068";
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = lib.strings.splitString "\n" (
        builtins.readFile inputs.secrets.ssh_pub_key
      );
    };

    system.activationScripts.postActivation.text = ''
      # Must match what is in /etc/shells
      sudo chsh -s /run/current-system/sw/bin/fish I572068
    '';

    homebrew = {
      taps = [ ];
      casks = [ ];
      masApps = { };
    };
  };
}
