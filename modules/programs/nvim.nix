{
  flake.modules.nixos."programs/nvim" =
    { username, ... }:
    {
      # Set the default editor to nvim
      environment.variables.EDITOR = "nvim";

      home-manager = {
        users."${username}" =
          { pkgs, config, ... }:
          {
            programs.neovim = {
              enable = true;

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

            xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/dotfiles/nvim;
          };
      };
    };
}
