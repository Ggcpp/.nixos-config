{ self, inputs, ... }:

{
  flake.modules.nixos.test =
    { pkgs, username, ... }:
    {

      environment.systemPackages = with pkgs; [
        ghostty
      ];
    };
}
