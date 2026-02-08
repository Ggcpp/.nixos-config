{ self, inputs, ... }:

{
  flake.modules.nixos."packages/dwarf" =
    { pkgs, ... }:
    {
      # Configure keymap in X11
      services.xserver.xkb = {
        layout = "dwarf";
        variant = "";

        extraLayouts.dwarf = {
          description = "Dwarf keyboard layout";
          languages = [ "eng" ];
          symbolsFile = pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/Ggcpp/Dwarf/refs/heads/main/dwarf";
            hash = "sha256-dKMX2ZHMvavx9kRXil8b/qgqpunGmBppsB7lf6KLzCY=";
          };
        };
      };

      # Apply system keymap to decrypt/login on boot
      console = {
        earlySetup = true;
        useXkbConfig = true;
      };
    };
}
