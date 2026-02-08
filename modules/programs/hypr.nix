{ self, ... }:

{
  flake.modules.nixos."programs/hypr" =
    {
      username,
      ...
    }:
    {
      imports = [
        self.modules.nixos."programs/quickshell"
      ];

      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };

      home-manager = {
        users."${username}" =
          { pkgs, config, ... }:
          {
            home.packages = with pkgs; [
              hyprsunset
              hyprcursor
              wofi
              kitty
              brightnessctl
              apple-cursor
            ];

            xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/dotfiles/hypr;
          };
      };
    };
}
