{
  flake.modules.nixos.starship =
    { username, ... }:
    {
      home-manager = {
        users."${username}" =
          { config, pkgs, ... }:
          {
            programs.starship = {
              enable = true;
              settings = {
                add_newline = false;
                aws.disabled = true;
                gcloud.disabled = true;
                line_break.disabled = true;
              };
            };
          };
      };
    };
}
