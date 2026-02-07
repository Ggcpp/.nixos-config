{ self, inputs, ... }:

{
  flake.modules.nixos.plymouth =
    { pkgs, username, ... }:
    {
      boot = {
        plymouth = {
          enable = true;
          theme = "hexagon_hud";
          themePackages = with pkgs; [
            (adi1090x-plymouth-themes.override {
              selected_themes = [ "hexagon_hud" ];
            })
          ];
        };
        # Enable "Silent boot"
        consoleLogLevel = 3;
        initrd.systemd.enable = true;
        initrd.verbose = false;
        kernelParams = [
          "boot.shell_on_fail"
          "quiet"
          "splash"
          "udev.log_level=3"
          "udev.log_priority=3"
          "systemd.show_status=false"
          "vga=current"
          "console=/dev/null"
        ];

        loader = {
          # Hide the OS choice for bootloaders.
          # It's still possible to open the bootloader list by pressing any key
          # It will just not appear on screen unless a key is pressed
          timeout = 0;
        };
      };
    };
}
