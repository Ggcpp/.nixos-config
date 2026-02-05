{ self, inputs, ... }:

{
  flake.nixosConfigurations.swift3 = inputs.nixpkgs.lib.nixosSystem {
    #system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      self.nixosModules.swift3
      #inputs.home-manager.flakeModules.home-manager
      #self.homeModules.swift3
      #self.homeConfigurations.swift3
    ];
  };

  flake.nixosModules.swift3 =
    { pkgs, ... }:
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
      ];

      home-manager = {
        extraSpecialArgs = { inherit inputs; };
        useUserPackages = true;
        useGlobalPkgs = true;
        backupFileExtension = "backup";

        users.daremo =
          { config, ... }:
          {
            # Home Manager needs a bit of information about you and the
            # paths it should manage.
            home.username = "daremo";
            home.homeDirectory = "/home/daremo";

            programs.starship = {
              enable = true;
              settings = {
                add_newline = false;
                aws.disabled = true;
                gcloud.disabled = true;
                line_break.disabled = true;
              };
            };

            programs.zsh = {
              enable = true;
              dotDir = config.home.homeDirectory + "/.config/zsh";
              enableCompletion = true;

              shellAliases = {
                vim = "nvim";
                v = "nvim";
              };

              sessionVariables = {
                EDITOR = "nvim";
                VISUAL = "nvim";
              };

              history = {
                saveNoDups = true;
                save = 10000;
                size = 10000;
                share = true;
              };

              initContent = ''
                bindkey '^H' backward-kill-word
              '';
            };

            programs.tmux = {
              enable = true;
              extraConfig = ''
                # Default shell
                set -g default-shell "${pkgs.zsh}/bin/zsh"

                # Prefix
                unbind C-b
                set -g prefix C-a;

                unbind r

                bind r source-file ~/.config/tmux/tmux.conf

                # Enable mouse support (scrolling)
                setw -g mouse on

                # Vi based keys
                set -g status-keys vi
                set -g mode-keys   vi

                # Split window
                unbind V
                unbind H

                bind V split-window -h -c "#{pane_current_path}"
                bind H split-window -v -c "#{pane_current_path}"

                # Create/rename window
                unbind n
                unbind r

                bind n new-window -c "#{pane_current_path}"
                bind r command-prompt -p "Rename Window:" "rename-window '%%'"

                # Rename Session
                unbind R
                bind R command-prompt -p "Rename Session:" "rename-session '%%'"

                # Kill session
                unbind Q
                bind Q kill-session
                set-option -g detach-on-destroy off

                # Kill window
                unbind q
                bind q kill-window

                # Close pane
                unbind x
                bind x kill-pane

                # New session
                unbind N
                bind N command-prompt -p "New Session:" "new-session -A -s '%%'"

                # New empty popup
                unbind Space
                bind Space popup "tmux new -A -s scratch -c $HOME"

                # Windows navigation
                unbind y
                unbind e
                unbind i
                unbind a
                unbind -
                unbind g
                unbind o
                unbind u
                unbind .
                unbind /

                bind y select-window -t 1
                bind e select-window -t 2
                bind i select-window -t 3
                bind a select-window -t 4
                bind - select-window -t 5
                bind g select-window -t 6
                bind o select-window -t 7
                bind u select-window -t 8
                bind . select-window -t 9
                bind / select-window -t 10

                # Panes navigation
                unbind j
                unbind k
                unbind l
                unbind h

                bind j select-pane -D
                bind k select-pane -U
                bind l select-pane -R
                bind h select-pane -L

                unbind -n M-h
                unbind -n M-j
                unbind -n M-k
                unbind -n M-l

                bind -n M-h select-pane -L
                bind -n M-j select-pane -D
                bind -n M-k select-pane -U
                bind -n M-l select-pane -R

                # Set indexes to 1 (instead of 0)
                set -g base-index 1
                set-window-option -g pane-base-index 1

                # Get rid of some crappy defaults
                unbind -n Tab
                set -s escape-time 0
                unbind -n C-v
                unbind -n C-h

                # Automatically renumber windows
                set -g renumber-windows on

                # Stylizing status bar
                set -g focus-events on
                set -g status-position top
                set -g status-left-length 100
                set -g status-style "bg=default"
                set -g status-left " #[bold] #S  #[nobold]| "
                set -g status-right "" # Prevent default rendering
                set -g window-status-current-format "#[bold]  #[underscore]#W"
                set -g window-status-format " #I:#W"
                set -g message-style "bg=default"
              '';
            };

            xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/modules/programs/nvim;
            xdg.configFile."ghostty".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/modules/programs/ghostty;
            xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/modules/programs/hypr;
            xdg.configFile."fish".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/modules/programs/fish;
            xdg.configFile."waybar".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/modules/programs/waybar;
            xdg.configFile."foot".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/modules/programs/foot;
            xdg.configFile."quickshell".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/modules/programs/quickshell;

            programs.neovim = {
              enable = true;

              # extraLuaConfig = "${builtins.readFile ./nvim/init.lua}";
              # plugins = with pkgs.vimPlugins; [
              #   {
              #     plugin = nvim-lspconfig;
              #     # type = "lua";
              #     # config
              #   }
              # ];

              # Maybe I don't need to add lazy-nvim through home manager and install it
              # normally, so the nvim configs would be more cross-platform
              plugins = with pkgs.vimPlugins; [
                lazy-nvim
              ];

              extraPackages = with pkgs; [
                wl-clipboard

                # LSPs
                rust-analyzer
                typescript-language-server
                nixd
                nil

                # required by treesitter.nvim
                tree-sitter
                gcc
              ];
            };

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
      ########################################################################
      # Bootloader.
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
        ];

        loader = {
          # Hide the OS choice for bootloaders.
          # It's still possible to open the bootloader list by pressing any key
          # It will just not appear on screen unless a key is pressed
          timeout = 0;
          systemd-boot.enable = true;

          grub = {
            enable = false;
            device = "nodev";
            useOSProber = true;
            #efiInstallAsRemovable = true;
            efiSupport = true;
            timeoutStyle = "hidden";
          };

          efi.canTouchEfiVariables = true;
          efi.efiSysMountPoint = "/boot";
        };

      };

      networking.hostName = "mizumi";
      # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

      # Configure network proxy if necessary
      # networking.proxy.default = "http://user:password@proxy:port/";
      # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

      # Enable networking
      networking.networkmanager.enable = true;

      # Set your time zone.
      time.timeZone = "Europe/Zurich";

      # Select internationalisation properties.
      i18n.defaultLocale = "en_US.UTF-8";

      # Apply system keymap to decrypt/login on boot
      console = {
        earlySetup = true;
        useXkbConfig = true;
      };

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

      services.keyd = {
        enable = true;
        keyboards.default = {
          ids = [ "*" ];
          extraConfig = ''
            [main]

            # Maps capslock to escape when pressed and control when held.
            # capslock = overload(control, esc)
            capslock = overload(ctrl_vim, esc)

            # Remaps the escape key to capslock
            esc = capslock

            rightalt = overload(alt, enter)
            tab = backspace

            backspace = capslock

            [ctrl_vim:C]

            l = tab

            # Should be outside of terminal
            m = C-backspace
          '';
        };
      };

      # Fonts
      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        nerd-fonts.iosevka
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
      ];

      # Enable sound with pipewire
      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        wireplumber.enable = true;
        pulse.enable = true;
        jack.enable = false;
      };

      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };

      environment.sessionVariables = {
        WLR_NO_HARDWARE_CURSORS = "1";
        NIXOS_OZONE_WL = "1";
      };

      hardware = {
        graphics.enable = true;
        graphics.enable32Bit = true;
      };

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

      programs.fish.enable = true;

      programs.zsh.enable = true;

      programs.nix-ld.enable = true;

      programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
      };

      programs.gamemode.enable = true;

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users.daremo = {
        isNormalUser = true;
        description = "daremo";
        # kvm and adbusers are for hardware acceleration (see the android studio guide)
        extraGroups = [
          "networkmanager"
          "wheel"
          "kvm"
          "adbusers"
        ];
        shell = pkgs.zsh;
        packages = with pkgs; [ ];
      };

      # Set the default editor to nvim
      environment.variables.EDITOR = "nvim";

      # Agree android_sdk license and tos
      nixpkgs.config = {
        android_sdk.accept_license = true;
        allowUnfree = true;
      };

      # List packages installed in system profile. To search, run:
      # $ nix search wget
      environment.systemPackages = with pkgs; [
        chromium
        neovim
        wget
        git
        kitty
        keyd
        hyprsunset
        hyprpaper
        hyprcursor
        waybar
        pavucontrol
        tree
        fh
        ghostty
        wezterm
        wofi
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
        brightnessctl
        apple-cursor
        starship
        foot
        quickshell
      ];

      programs.chromium = {
        enable = true;
        extensions = [
          "annfbnbieaamhaimclajlajpijgkdblo" # dark theme
          "eimadpbcbfnmbkopoojfekhnkhdbieeh" # dark reader
          "cfhdojbkjhnklbpkdaibdccddilifddb" # adblock plus
          "khncfooichmfjbepaaaebmommgaepoid" # unhook
        ];
      };

      # KDE Plasma desktop environment
      # services.displayManager.sddm.enable = true;
      # services.displayManager.sddm.wayland.enable = true;
      # services.desktopManager.plasma6.enable = true;

      # Some programs need SUID wrappers, can be configured further or are
      # started in user sessions.
      # programs.mtr.enable = true;
      # programs.gnupg.agent = {
      #   enable = true;
      #   enableSSHSupport = true;
      # };

      # List services that you want to enable:
      services.upower.enable = true; # for quickshell battery info

      # Enable the OpenSSH daemon.
      # services.openssh.enable = true;

      # Open ports in the firewall.
      # networking.firewall.allowedTCPPorts = [ ... ];
      # networking.firewall.allowedUDPPorts = [ ... ];
      # Or disable the firewall altogether.
      networking.firewall.enable = false;

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "25.05"; # Did you read the comment?
    };
}
