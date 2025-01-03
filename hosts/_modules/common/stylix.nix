{ pkgs, ... }:
{
  stylix.enable = true;
  stylix.image = pkgs.fetchurl {
    url = "https://www.pixelstalk.net/wp-content/uploads/images7/Froggy-Forest-Wallpaper-HD-Free-download.jpg";
    sha256 = "sha256-GRdgOHm7Hi7vaxBv9HjSygRhhnplb9b0MbuVC4uGoXE=";
  };
  stylix.base16Scheme = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/scottmckendry/cyberdream.nvim/main/extras/base16/cyberdream.yaml";
    sha256 = "1bfi479g7v5cz41d2s0lbjlqmfzaah68cj1065zzsqksx3n63znf";
  };
}
