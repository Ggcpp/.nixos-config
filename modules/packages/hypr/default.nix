{ self, ... }:

{
  flake.modules.nixos."packages/hypr" =
    {
      username,
      ...
    }:
    {
      imports = [
        self.modules.nixos."packages/quickshell"
        self.modules.nixos."packages/kitty"
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
              brightnessctl
              apple-cursor
            ];

            xdg.configFile."hypr".source =
              config.lib.file.mkOutOfStoreSymlink "/etc/nixos/modules/packages/hypr/config";
          };
      };
    };
}
