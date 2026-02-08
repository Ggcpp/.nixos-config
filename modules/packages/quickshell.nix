{
  flake.modules.nixos."packages/quickshell" =
    { username, ... }:
    {
      services.upower.enable = true; # for quickshell battery info

      home-manager = {
        users."${username}" =
          { pkgs, config, ... }:
          {
            home.packages = with pkgs; [
              quickshell
            ];

            xdg.configFile."quickshell".source =
              config.lib.file.mkOutOfStoreSymlink /etc/nixos/dotfiles/quickshell;
          };
      };
    };
}
