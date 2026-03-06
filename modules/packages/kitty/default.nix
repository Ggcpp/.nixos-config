{
  flake.modules.nixos."packages/kitty" =
    { username, ... }:
    {
      home-manager = {
        users."${username}" =
          { pkgs, config, ... }:
          {
            #programs.kitty = {
            #  enable = true;
            #};
            home.packages = with pkgs; [
              kitty
            ];

            xdg.configFile."kitty".source = config.lib.file.mkOutOfStoreSymlink ./config;
          };
      };
    };
}
