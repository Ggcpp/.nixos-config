{ self, ... }:

{
  flake.modules.nixos."packages/virt-manager" =
    {
      username,
      pkgs,
      ...
    }:
    {
      virtualisation.libvirtd = {
        enable = true;
        qemu = {
          vhostUserPackages = with pkgs; [ virtiofsd ];
          swtpm.enable = true;
        };
      };

      programs.virt-manager.enable = true;
      programs.dconf.enable = true;

      users.users."${username}".extraGroups = [ "libvirtd" ];

      services.qemuGuest.enable = true;
      services.spice-vdagentd.enable = true; # enable copy and paste between host and guest

      networking.firewall.trustedInterfaces = [ "virbr0" ];

      home-manager = {
        users."${username}" =
          { pkgs, ... }:
          {
            home.packages = with pkgs; [
              virt-viewer
              spice
              spice-gtk
              spice-protocol
              virtio-win
              win-spice
              adwaita-icon-theme
              dnsmasq # Required for DNS and DCHP functionality within the network.
            ];
          };
      };
    };
}
