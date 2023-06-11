{ inputs, outputs, lib, config, pkgs, ... }: {
  programs.tmux = {
    enable = false;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 0;
    prefix = "C-Space";
    extraConfig = ''
      set -g renumber-windows on
      bind -T prefix : command-prompt -p "COMMAND:"
      bind -T prefix r command-prompt -I "#W" "rename-window '%%'"
      bind -T prefix c new-window -c "#{pane_current_path}"
      bind -T prefix C-j select-pane -t ":.{next}"
      bind -T prefix C-k select-pane -t ":.{previous}"
      bind -T prefix C-h previous-window
      bind -T prefix C-l next-window
      bind -T prefix x split-window -v -c "#{pane_current_path}"
      bind -T prefix v split-window -h -c "#{pane_current_path}"
      bind -T prefix q kill-pane
      bind -T prefix Q kill-window
      bind -r -T prefix H swap-window -d -t ":{previous}"
      bind -r -T prefix L swap-window -d -t ":{next}"
      bind -r -T prefix M-h resize-pane -L 2
      bind -r -T prefix M-j resize-pane -D 2
      bind -r -T prefix M-k resize-pane -U 2
      bind -r -T prefix M-l resize-pane -R 2
    '';
  };
}
