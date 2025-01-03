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
      computerName = "pmb";
      hostName = hostname;
      localHostName = hostname;
    };

    users.users.thrash-panda-v91-beta = {
      name = "thrash-panda-v91-beta";
      home = "/Users/thrash-panda-v91-beta";
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = lib.strings.splitString "\n" (
        builtins.readFile inputs.secrets.ssh_pub_key
      );
    };

    system.activationScripts.postActivation.text = ''
      # Must match what is in /etc/shells
      sudo chsh -s /run/current-system/sw/bin/fish thrash-panda-v91-beta
    '';

    homebrew = {
      taps = [ ];
      brews = [ ];
      masApps = { };
    };
  };
}
