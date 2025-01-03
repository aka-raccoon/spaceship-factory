{ config, lib, ... }:
let
  cfg = config.modules.security.ssh;
in
{
  options.modules.security.ssh = {
    enable = lib.mkEnableOption "ssh";
    identityAgent = lib.mkOption {
      type = lib.types.str;
      default = "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
      description = "Path to the identity agent socket";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      extraConfig = ''
        Host *
            IdentityAgent ${config.modules.security.ssh.identityAgent}
      '';
    };
  };
}
