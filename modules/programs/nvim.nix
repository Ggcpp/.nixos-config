{
  flake.modules.homeManager.nvim =
    { config, pkgs, ... }:
    {
      programs.neovim = {
        enable = true;

        #extraLuaConfig = "${builtins.readFile ./nvim/init.lua}";
        #plugins = with pkgs.vimPlugins; [
        #  {
        #    plugin = nvim-lspconfig;
        #    # type = "lua";
        #    # config
        #  }
        #];

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
          nixd
          nil

          # required by treesitter.nvim
          tree-sitter
          gcc
        ];
      };

      xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/modules/programs/nvim;
    };
}
