{ self, ... }:

{
  flake.modules.nixos.hypr =
    {
      username,
      ...
    }:
    {
      imports = [
        self.modules.nixos.quickshell
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

            xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/modules/programs/hypr;
          };
      };
    };
}
