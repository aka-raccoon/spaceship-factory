{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.modules.themes.cyberdream;
in
{
  options.modules.themes.cyberdream = {
    enable = lib.mkEnableOption "cyberdream";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      fira-code
      jetbrains-mono
      iosevka
    ];
    fonts.fontconfig.enable = true;

    stylix = {
      enable = true;
      image = pkgs.fetchurl {
        url = "https://www.pixelstalk.net/wp-content/uploads/images7/Froggy-Forest-Wallpaper-HD-Free-download.jpg";
        sha256 = "sha256-GRdgOHm7Hi7vaxBv9HjSygRhhnplb9b0MbuVC4uGoXE=";
      };
      base16Scheme = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/scottmckendry/cyberdream.nvim/main/extras/base16/cyberdream.yaml";
        sha256 = "1bfi479g7v5cz41d2s0lbjlqmfzaah68cj1065zzsqksx3n63znf";
      };
      cursor = {
        size = 25;
      };
      opacity = {
        terminal = 0.9;
      };
      polarity = "dark";
      fonts = {
        sizes.applications = 19;
        serif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Serif";
        };

        sansSerif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans";
        };

        monospace = {
          package = pkgs.unstable.aporetic;
          name = "JetBrains Mono";
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
      };
    };
  };
}
