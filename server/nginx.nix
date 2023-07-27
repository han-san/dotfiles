{ ... }:

{
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    # Note: should be domain name instead of IP. Also IP probably(?) isn't static ATM.
    virtualHosts."185.113.96.232" = {
      root = "/var/www";
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
