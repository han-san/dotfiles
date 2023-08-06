{ config, ... }:

{
  services.nginx = with config.services.tailscale; {
      enable = true;
      recommendedGzipSettings = true;

      virtualHosts."${tailnetName}" =
        {
          root = "/var/www";
          locations = {
            "/jellyfin" = {
              return = "301 http://${tailnetName}:8096/";
            };
            "/syncthing" = {
              return = "301 http://${tailnetName}:8384/";
            };
          };
        };
    };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
