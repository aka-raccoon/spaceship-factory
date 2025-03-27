{ inputs, ... }:
{

  additions =
    final: _prev:
    import ../pkgs {
      inherit inputs;
      pkgs = final;
    };

  # The unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through `pkgs.unstable`
  unstable-packages = final: prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final) system;
      config.allowUnfree = true;
      overlays = [
        # overlays of unstable packages are declared here
        # (final: prev: { })
      ];
    };
  };

  nixpkgs-overlays = final: prev: {
    _1password-gui = prev._1password-gui.override { polkitPolicyOwners = inputs.nixpkgs.lib.users; };
    # services.karabiner-elements is broken after Karabiner-Elements v15.0
    # https://github.com/LnL7/nix-darwin/issues/1041
    karabiner-elements = prev.karabiner-elements.overrideAttrs (oldAttrs: {
      version = "14.13.0";
      src = prev.fetchurl {
        inherit (oldAttrs.src) url;
        hash = "sha256-gmJwoht/Tfm5qMecmq1N6PSAIfWOqsvuHU8VDJY8bLw=";
      };
    });
    tmuxPlugins = prev.tmuxPlugins // {
      catppuccin = prev.tmuxPlugins.catppuccin.overrideAttrs (oldAttrs: {
        postInstall =
          (oldAttrs.postInstall or "")
          + ''
            cat >> $out/share/tmux-plugins/catppuccin/themes/catppuccin_cyberdream.tmuxtheme << 'END'
            # cyberdream theme for tmux (catppuccin)
            thm_bg="#1e2124"
            thm_fg="#ffffff"
            thm_cyan="#5ef1ff"
            thm_black="#3c4048"
            thm_gray="#3c4048"
            thm_magenta="#ff5ef1"
            thm_pink="#ff5ea0"
            thm_red="#ff6e5e"
            thm_green="#5eff6c"
            thm_yellow="#f1ff5e"
            thm_blue="#5ea1ff"
            thm_orange="#ffbd5e"
            thm_black4="#7b8496"
            END
          '';
      });
    };
  };
}
