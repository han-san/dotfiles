{ ... }:

{
  services.nginx =
    let tailscaleDomain = "federer.tailf7aba.ts.net";
    in {
      enable = true;
      recommendedGzipSettings = true;

      virtualHosts."${tailscaleDomain}" =
        {
          root = "/var/www";
          locations = {
            "/jellyfin" = {
              return = "301 http://${tailscaleDomain}:8096/";
            };
            "/syncthing" = {
              return = "301 http://${tailscaleDomain}:8384/";
            };
          };
        };
    };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
