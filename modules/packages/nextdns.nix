{
  flake.modules.nixos."packages/nextdns" = {
    services.resolved = {
      enable = true;
      settings.Resolve = {
        # DNS-over-TLS (required by NextDNS for encryption)
        DNSOverTLS = true;
        DNSSEC = true;
        # Forward all requests to NextDNS
        Domains = [ "~." ];
      };
    };

    networking.nameservers = [
      "45.90.28.0#6f6af6.dns.nextdns.io"
      "45.90.30.0#6f6af6.dns.nextdns.io"
      "2a07:a8c0::#6f6af6.dns.nextdns.io"
      "2a07:a8c1::#6f6af6.dns.nextdns.io"
    ];
  };
}
