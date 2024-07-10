{ config, pkgs, lib, ... }:

with config.services.tailscale;
let
  serverDomain = "federer.${tailnetName}";
in
{
  services.tt-rss = {
    enable = true;
    selfUrlPath = "http://${serverDomain}/www/";
    virtualHost = null; # We are setting up the virtual host manually.
    singleUserMode = true;
  };

  services.nginx = {
    enable = true;
    virtualHosts = {
      "${serverDomain}" = {

        # Warning: Massive hack. Since the location name will be added to the root path,
        # we use the name "www" since that is the directory containing the source files.
        locations."/www" = {
          root = "${config.services.tt-rss.root}";
          index = "index.php";
        };

        # TODO: These locations aren't restricted to the "www" location.
        locations."^~ /feed-icons" = {
          root = "${config.services.tt-rss.root}";
        };

        locations."~ ^/www/.*\\.php$" = {
          root = "${config.services.tt-rss.root}";
          extraConfig = ''
            fastcgi_split_path_info ^(.+\.php)(/.+)$;
            fastcgi_pass unix:${config.services.phpfpm.pools.${config.services.tt-rss.pool}.socket};
            fastcgi_index index.php;
          '';
        };
      };
    };
  };
}
