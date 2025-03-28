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
    modules = {
      aerospace.enable = true;
      karabiner-elements.enable = true;
      hammerspoon.enable = true;
    };
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
