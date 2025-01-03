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

    homebrew = {
      taps = [ ];
      brews = [ ];
      masApps = { };
    };
  };
}
