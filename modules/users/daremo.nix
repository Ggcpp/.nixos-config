{ self, inputs, ... }:

{
  flake.modules.nixos.daremo =
    let
      bundleModules = [
        "base-system"
      ];

      programModules = [
        "hypr"
        "quickshell"
        "plymouth"
        "chromium"
        "steam"
        "starship"
      ];
    in
    { pkgs, username, ... }:
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
      ]
      ++ map (programName: self.modules.nixos."programs/${programName}") programModules
      ++ map (bundleName: self.modules.nixos."bundles/${bundleName}") bundleModules;

      # Bootloader.
      boot.loader = {
        systemd-boot.enable = true;

        grub = {
          enable = false;
          device = "nodev";
          useOSProber = true;
          #efiInstallAsRemovable = true;
          efiSupport = true;
        };

        efi.canTouchEfiVariables = true;
        efi.efiSysMountPoint = "/boot";
      };

      # Set your time zone.
      time.timeZone = "Europe/Zurich";

      # Select internationalisation properties.
      i18n.defaultLocale = "en_US.UTF-8";

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

      # Fonts
      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        nerd-fonts.iosevka
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
      ];

      # Prevent screen flickering in some apps when using NVIDIA cards
      # Note: Wayland specific
      environment.sessionVariables = {
        WLR_NO_HARDWARE_CURSORS = "1";
        NIXOS_OZONE_WL = "1";
      };

      # Enable hardware acceleration
      hardware = {
        graphics.enable = true;
      };

      # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users."${username}" = {
        isNormalUser = true;
        description = username;
        # kvm and adbusers are for hardware acceleration (see the android studio guide)
        extraGroups = [
          "wheel"
          "kvm"
          "adbusers"
        ];
      };

      # Agree android_sdk license and tos
      nixpkgs.config = {
        android_sdk.accept_license = true;
        allowUnfree = true;
      };

      # Open ports in the firewall.
      # networking.firewall.allowedTCPPorts = [ ... ];
      # networking.firewall.allowedUDPPorts = [ ... ];
      # Or disable the firewall altogether.
      networking.firewall.enable = false;

      # Configure Home Manager
      home-manager = {
        extraSpecialArgs = { inherit inputs; };
        useUserPackages = true;
        useGlobalPkgs = true;
        backupFileExtension = "backup";

        users."${username}" = {
          # Home Manager needs a bit of information about you and the
          # paths it should manage.
          home.username = username;
          home.homeDirectory = "/home/${username}";

          # This value determines the Home Manager release that your
          # configuration is compatible with. This helps avoid breakage
          # when a new Home Manager release introduces backwards
          # incompatible changes.
          #
          # You can update Home Manager without changing this value. See
          # the Home Manager release notes for a list of state version
          # changes in each release.
          home.stateVersion = "25.05";

          # Let Home Manager install and manage itself.
          programs.home-manager.enable = true;
        };
      };
    };
}
