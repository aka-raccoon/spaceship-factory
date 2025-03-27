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

    modules.karabiner-elements.enable = true;
    homebrew = {
      taps = [ ];
      brews = [ ];
      casks = [
        "notion"
        "notion-calendar"
      ];
      masApps = {
        "Notion Web Clipper" = 1559269364;
      };
    };
  };
}
