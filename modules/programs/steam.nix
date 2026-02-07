{ self, inputs, ... }:

{
  flake.modules.nixos.steam = {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    programs.gamemode.enable = true;

    # Ensure hardware acceleration is enabled
    # and enable 32 bits version of the libraries
    hardware = {
      graphics.enable = true;
      graphics.enable32Bit = true;
    };
  };
}
