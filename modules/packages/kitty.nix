{
  flake.modules.nixos."packages/kitty" =
    { username, ... }:
    {
      home-manager = {
        users."${username}" =
          { pkgs, config, ... }:
          {
            home.programs.kitty = {
              enable = true;
            };
          };
      };
    };
}
