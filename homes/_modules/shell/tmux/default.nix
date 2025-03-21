{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.modules.shell.tmux;
in
{
  options.modules.shell.tmux = {
    enable = lib.mkEnableOption "tmux";
    package = lib.mkPackageOption pkgs "tmux" { };
  };

  config = lib.mkIf cfg.enable {
    stylix.targets.tmux.enable = true;
    programs.tmux = {
      baseIndex = 1;
      enable = true;
      inherit (cfg) package;
      mouse = true;
      keyMode = "vi";
      sensibleOnTop = false;
      shell = "${pkgs.fish}/bin/fish";
      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = resurrect;
          extraConfig = ''
            # Save and restore session
            set -g @resurrect-save 'S'
            set -g @resurrect-restore 'R'

            set -g @resurrect-strategy-nvim 'session'
          '';
        }
        {
          plugin = tmux-fzf;
          extraConfig = ''
            TMUX_FZF_ORDER="session|window|pane|command|keybinding"
            TMUX_FZF_OPTIONS="-p -w 90% -h 70% -m"
            bind w run-shell -b "~/.config/tmux/plugins/tmux-fzf/scripts/window.sh switch"
          '';
        }
        vim-tmux-navigator
        continuum
      ];
      extraConfig = lib.mkMerge [
        (lib.mkBefore ''
          # Set terminal colors
          set -g default-terminal "tmux-256color"
          set -as terminal-overrides ',xterm*:sitm=\E[3m'

          set-window-option -g pane-base-index 1
          set-option -g renumber-windows on

          # kill pane
          bind-key x kill-pane

          # Pane resizing
          bind -n M-h resize-pane -L
          bind -n M-l resize-pane -R
          bind -n M-k resize-pane -U
          bind -n M-j resize-pane -D

          # Use visual selection mode as vi
          bind-key -T copy-mode-vi v send-keys -X begin-selection
          bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
          bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

          set -g status-left-length 100
          set -g status-left ""
          set -g status-right-length 100
          set -g status-right ""

          set -g status-position bottom
          set -g status-justify "absolute-centre"

          setw -g pane-border-format ""
          setw -g pane-active-border-style "bg=#{@thm_bg},fg=#{@thm_overlay_0}"
          setw -g pane-border-style "bg=#{@thm_bg},fg=#{@thm_surface_0}"
          setw -g pane-border-lines single

          set -wg automatic-rename on
          set -g automatic-rename-format "Window"

          set -g window-status-format " #I "
          set -g window-status-style "bg=#{@thm_bg},fg=#{@thm_rosewater}"
          set -g window-status-last-style "bg=#{@thm_bg},fg=#{@thm_peach}"
          set -g window-status-activity-style "bg=#{@thm_red},fg=#{@thm_bg}"
          set -g window-status-bell-style "bg=#{@thm_red},fg=#{@thm_bg},bold"
          set -gF window-status-separator "#[bg=#{@thm_bg},fg=#{@thm_overlay_0}]│"

          set -g window-status-current-format " #I "
          set -g window-status-current-style "bg=#{@thm_peach},fg=#{@thm_bg},bold"


          set -gu default-command
          set -g default-shell "$SHELL"
        '')
        (lib.mkAfter ''
          set -g status-style "bg=default"
        '')
      ];
    };
  };
}
