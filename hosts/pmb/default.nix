{
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
    modules.aerospace.enable = true;
    modules.karabiner-elements.enable = true;
    homebrew = {
      taps = [ ];
      brews = [ ];
      casks = [
        "notion"
      ];
      masApps = {
      };
    };
  };
}
