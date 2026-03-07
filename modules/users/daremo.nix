{ self, inputs, ... }:

{
  flake.modules.nixos.daremo =
    { pkgs, username, ... }:
    let
      bundleModules = [
        "base-system"
      ];

      packageModules = [
        "hypr"
        "quickshell"
        "plymouth"
        "chromium"
        "steam"
        "starship"
        #"nextdns"
        "virt-manager"
      ];

      extraPackages = with pkgs; [
        wget
        git
        pavucontrol
        tree
        fh
        unzip
        htop
        blender
        ncdu
        lutris
        feh
        vlc
        nodejs
        anki-bin
        foot
      ];
    in
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
      ]
      ++ map (packageName: self.modules.nixos."packages/${packageName}") packageModules
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
      i18n.supportedLocales = [
        "en_US.UTF-8/UTF-8"
        "ja_JP.UTF-8/UTF-8"
      ];

      # Prevent screen flickering in some apps when using NVIDIA cards
      # Note: Wayland specific
      #environment.sessionVariables = {
      #  WLR_NO_HARDWARE_CURSORS = "1";
      #  NIXOS_OZONE_WL = "1";
      #};

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

      # List packages installed in system profile. To search, run:
      # $ nix search wget
      # environment.systemPackages = [];

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

          home.packages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.install ] ++ extraPackages;

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
