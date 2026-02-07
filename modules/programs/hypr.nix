{ self, ... }:

{
  flake.modules.homeManager.hypr =
    { config, pkgs, ... }:
    {
      imports = [
        self.modules.homeManager.quickshell
      ];
      #programs.hyprland = {
      #    enable = true;
      #    xwayland.enable = true;
      #};

      xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/modules/programs/hypr;

      home.packages = with pkgs; [
        hyprsunset
        hyprcursor
        wofi
        kitty
        brightnessctl
        apple-cursor
      ];
    };
}
