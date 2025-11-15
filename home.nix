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

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/nvim;
  xdg.configFile."tmux".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/tmux;

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

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

    extraPackages = with pkgs; [
      wl-clipboard
      rust-analyzer
      typescript-language-server
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
