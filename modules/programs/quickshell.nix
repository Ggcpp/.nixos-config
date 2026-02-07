{
  flake.modules.homeManager.quickshell =
    { config, pkgs, ... }:
    {
      home.packages = with pkgs; [ quickshell upower ];
      xdg.configFile."quickshell".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/modules/programs/quickshell;
    };
}
