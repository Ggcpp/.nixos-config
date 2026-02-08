{ self, ... }:

{
  flake.modules.nixos."packages/networkmanager" =
    { username, ... }:
    {
      # Enable networking
      networking.networkmanager.enable = true;
      systemd.services.NetworkManager-wait-online.enable = false;

      # Disabling dhcpcd since networkmanager uses its own dhcp
      networking.dhcpcd.enable = false;

      # Add user to networkmanager group
      users.users."${username}".extraGroups = [ "networkmanager" ];
    };
}
