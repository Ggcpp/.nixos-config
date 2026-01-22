{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "daremo";
  home.homeDirectory = "/home/daremo";

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  programs.tmux = {
    enable = true;
    extraConfig = ''
      # Default shell
      set -g default-shell "${pkgs.zsh}/bin/fish"

      # Prefix
      unbind C-b
      set -g prefix C-a;
      
      unbind r
      
      bind r source-file ~/.config/tmux/tmux.conf
      
      # Enable mouse support (scrolling)
      setw -g mouse on
      
      # Split window
      unbind v
      unbind h
      unbind %
      unbind 'a'
      
      bind / split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      
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
      
      bind y select-window -t 1
      bind e select-window -t 2
      bind i select-window -t 3
      bind a select-window -t 4
      
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
      
      # C-backspace to C-w
      bind-key -n  C-h send-keys C-w
      
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

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/nvim;
  #xdg.configFile."tmux".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/tmux;
  xdg.configFile."ghostty".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/ghostty;
  xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/hypr;
  xdg.configFile."fish".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/fish;
  xdg.configFile."waybar".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/waybar;
  xdg.configFile."foot".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/foot;

  programs.neovim = {
    enable = true;
    
    # extraLuaConfig = "${builtins.readFile ./nvim/init.lua}";
    # plugins = with pkgs.vimPlugins; [
    #   {
    #     plugin = nvim-lspconfig;
    #     # type = "lua";
    #     # config
    #   }
    # ];

    # Maybe I don't need to add lazy-nvim through home manager and install it
    # normally, so the nvim configs would be more cross-platform
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

    extraPackages = with pkgs; [
      wl-clipboard

      # LSPs
      rust-analyzer
      typescript-language-server

      # required by treesitter.nvim
      tree-sitter
      gcc
    ];
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
