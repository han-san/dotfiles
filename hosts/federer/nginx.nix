{ config, ... }:

{
  sops.secrets.federer-cert.sopsFile = ./secrets.yaml;
  sops.secrets.federer-key.sopsFile = ./secrets.yaml;
  services.nginx = with config.services.tailscale; {
    enable = true;
    recommendedGzipSettings = true;

    virtualHosts."federer.${tailnetName}" =
      {
        sslCertificate = config.sops.secrets.federer-cert.path;
        sslCertificateKey = config.sops.secrets.federer-key.path;
        root = "/var/www";
        locations = {
          "/jellyfin" = {
            #proxyPass = "http://federer.${tailnetName}:8096/";
            return = "301 http://federer.${tailnetName}:8096/";
          };
          "/syncthing" = {
            return = "301 http://federer.${tailnetName}:8384/";
          };
          "/transmission" = {
            return = "301 http://federer.${tailnetName}:9091/";
          };
          "/sonarr" = {
            return = "301 http://federer.${tailnetName}:8989/";
          };
          "/radarr" = {
            return = "301 http://federer.${tailnetName}:7878/";
          };
        };
      };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
