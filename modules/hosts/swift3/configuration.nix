{ self, inputs, ... }:

{
  flake.nixosConfigurations.swift3 =
    let
      username = "daremo";
    in
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
        inherit username;
      };
      modules = [
        self.modules.nixos.swift3
        self.modules.nixos."${username}"
      ];
    };

  flake.modules.nixos.swift3 =
    { pkgs, ... }:
    {

      networking.hostName = "mizumi";
      # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

      # Configure network proxy if necessary
      # networking.proxy.default = "http://user:password@proxy:port/";
      # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

      # Apparently good for Android emulator
      #programs.adb.enable = true;
      #virtualisation.libvirtd.enable = true;

      #hardware.nvidia = {
      #  modesetting.enable = true;
      #  powerManagement.enable = true;
      #  powerManagement.finegrained = false;

      #  open = true;

      #  nvidiaSettings = true;

      #  package = config.boot.kernelPackages.nvidiaPackages.stable;
      #};
      #services.xserver.videoDrivers = [ "nvidia" ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      # List packages installed in system profile. To search, run:
      # $ nix search wget
      environment.systemPackages = with pkgs; [
        wget
        git
        keyd
        pavucontrol
        tree
        fh
        unzip
        htop
        blender
        ncdu
        lutris
        wine
        winetricks
        feh
        vlc
        nodejs
        anki-bin
        foot
      ];

      # Some programs need SUID wrappers, can be configured further or are
      # started in user sessions.
      # programs.mtr.enable = true;
      # programs.gnupg.agent = {
      #   enable = true;
      #   enableSSHSupport = true;
      # };

      # List services that you want to enable:

      # Enable the OpenSSH daemon.
      # services.openssh.enable = true;

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "25.05"; # Did you read the comment?
    };
}
