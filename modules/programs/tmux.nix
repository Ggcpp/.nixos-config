{
  flake.modules.nixos.tmux =
    { username, ... }:
    {
      home-manager = {
        users."${username}" =
          { pkgs, config, ... }:
          {
            # Install zsh since the default-shell option will look for it
            # TODO: Might want to automate this with a global default shell in the future?
            home.packages = with pkgs; [
              zsh
            ];

            programs.tmux = {
              enable = true;
              extraConfig = ''
                # Default shell
                set -g default-shell "${pkgs.zsh}/bin/zsh"

                # Prefix
                unbind C-b
                set -g prefix C-a;

                unbind r

                bind r source-file ~/.config/tmux/tmux.conf

                # Enable mouse support (scrolling)
                setw -g mouse on

                # Vi based keys
                set -g status-keys vi
                set -g mode-keys   vi

                # Split window
                unbind V
                unbind H

                bind V split-window -h -c "#{pane_current_path}"
                bind H split-window -v -c "#{pane_current_path}"

                # Create/rename window
                unbind n
                unbind r

                bind n new-window -c "#{pane_current_path}"
                bind r command-prompt -p "Rename Window:" "rename-window '%%'"

                # Rename Session
                unbind R
                bind R command-prompt -p "Rename Session:" "rename-session '%%'"

                # Kill session
                unbind Q
                bind Q kill-session
                set-option -g detach-on-destroy off

                # Kill window
                unbind q
                bind q kill-window

                # Close pane
                unbind x
                bind x kill-pane

                # New session
                unbind N
                bind N command-prompt -p "New Session:" "new-session -A -s '%%'"

                # New empty popup
                unbind Space
                bind Space popup "tmux new -A -s scratch -c $HOME"

                # Windows navigation
                unbind y
                unbind e
                unbind i
                unbind a
                unbind -
                unbind g
                unbind o
                unbind u
                unbind .
                unbind /

                bind y select-window -t 1
                bind e select-window -t 2
                bind i select-window -t 3
                bind a select-window -t 4
                bind - select-window -t 5
                bind g select-window -t 6
                bind o select-window -t 7
                bind u select-window -t 8
                bind . select-window -t 9
                bind / select-window -t 10

                # Panes navigation
                unbind j
                unbind k
                unbind l
                unbind h

                bind j select-pane -D
                bind k select-pane -U
                bind l select-pane -R
                bind h select-pane -L

                unbind -n M-h
                unbind -n M-j
                unbind -n M-k
                unbind -n M-l

                bind -n M-h select-pane -L
                bind -n M-j select-pane -D
                bind -n M-k select-pane -U
                bind -n M-l select-pane -R

                # Set indexes to 1 (instead of 0)
                set -g base-index 1
                set-window-option -g pane-base-index 1

                # Get rid of some crappy defaults
                unbind -n Tab
                set -s escape-time 0
                unbind -n C-v
                unbind -n C-h

                # Automatically renumber windows
                set -g renumber-windows on

                # Stylizing status bar
                set -g focus-events on
                set -g status-position top
                set -g status-left-length 100
                set -g status-style "bg=default"
                set -g status-left " #[bold] #S  #[nobold]| "
                set -g status-right "" # Prevent default rendering
                set -g window-status-current-format "#[bold]  #[underscore]#W"
                set -g window-status-format " #I:#W"
                set -g message-style "bg=default"
              '';
            };
          };
      };
    };
}
