{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.modules.shell.git;
  inherit (pkgs.stdenv) isDarwin;
in
{
  options.modules.shell.git = {
    enable = lib.mkEnableOption "git";
    username = lib.mkOption { type = lib.types.str; };
    email = lib.mkOption { type = lib.types.str; };
    config = lib.mkOption {
      type = lib.types.attrs;
      default = { };
    };
    includes = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      default = [ ];
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      programs.gh.enable = true;
      programs.git = {
        enable = true;

        userName = cfg.username;
        userEmail = cfg.email;

        extraConfig = lib.mkMerge [
          {
            core = {
              autocrlf = "input";
            };
            init = {
              defaultBranch = "main";
            };
            pull = {
              rebase = true;
            };
            rebase = {
              autoStash = true;
            };
          }
          cfg.config
        ];

        includes = cfg.includes;

        aliases = {
          co = "checkout";
        };
        ignores = [
          # Mac OS X hidden files
          ".DS_Store"
          # Windows files
          "Thumbs.db"
          # asdf
          ".tool-versions"
          # mise
          ".mise.toml"
          # Sops
          ".decrypted~*"
          "*.decrypted.*"
          # Python virtualenvs
          ".venv"
        ];
      };

      home.packages = [
        pkgs.git-filter-repo
        pkgs.tig
      ];

      programs.lazygit = {
        enable = true;
        settings = {
          gui = {
            nerdFontsVersion = 3;
            border = "rounded";
            theme = {
              activeBorderColor = [ "#5ef1ff" ];
              inactiveBorderColor = [ "#7b8496" ];
              searchingActiveBorderColor = [ "#ff5ef1" ];
              optionsTextColor = [ "#3c4048" ];
              selectedLineBgColor = [ "#3c4048" ];
              cherryPickedCommitBgColor = [ "#3c4048" ];
              cherryPickedCommitFgColor = [ "#ff5ea0" ];
              unstagedChangesColor = [ "#ffbd5e" ];
              defaultFgColor = [ "#ffffff" ];
            };
          };
        };
      };
    })
    (lib.mkIf (cfg.enable && isDarwin) {
      programs.git = {
        extraConfig = {
          credential = {
            helper = "osxkeychain";
          };
        };
      };
    })
  ];
}
