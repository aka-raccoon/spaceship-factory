_: {
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false; # Don't update during rebuild
      cleanup = "zap"; # Uninstall all programs not declared
      upgrade = true;
    };
    global = {
      brewfile = true; # Run brew bundle from anywhere
      lockfiles = false; # Don't save lockfile (since running from anywhere)
    };
    taps = [ ];
    brews = [ ];
    casks = [
      "1password"
      "ghostty"
      "notion"
      "notion-calendar"
      "raycast"
    ];
    masApps = {
      "1Password For Safari" = 1569813296;
      "Ghostery Privacy Ad Blocker" = 6504861501;
      "Notion Web Clipper" = 1559269364;
      "Vimari" = 1480933944;
    };
  };
}
