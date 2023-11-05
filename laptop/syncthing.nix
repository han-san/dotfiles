{ config, ... }:
{
  services.syncthing = {
    enable = true;
    user = "johan";
    dataDir = "/home/johan/Sync";
    openDefaultPorts = true;

    settings.devices = with config.services.tailscale;
      {
        Phone = {
          id = "KYLVEZL-RUMAOH3-EN43MXV-QXSTIMT-ABMWQCB-A3SNTTJ-MUYJK7C-KYIFJQT";
        };
        Gaia = {
          id = "MMQBJXB-G3RVVZO-AQYIX4P-TTVK4II-YV2VIRC-EETDNXE-D7362BO-VPVETAM";
          addresses = [ "tcp://gaia.${tailnetName}:22000" ];
        };
        Federer = {
          id = "YFXUNZH-6V2DILS-H2BKHKD-7C4EOY7-7745UPQ-Z6TYDLI-V32JYT2-PGFAEQJ";
          addresses = [ "tcp://federer.${tailnetName}:22000" ];
        };
      };

    settings.folders = with config.services.syncthing; {
      "${dataDir}/Keepass" = {
        id = "cncxg-cggmc";
        label = "Keepass";
        devices = [ "Phone" "Gaia" "Federer" ];
      };
      "${dataDir}/Todos" = {
        id = "nxmmm-bfstv";
        label = "Todos";
        devices = [ "Gaia" "Federer" ];
      };
      "/home/johan/Projects" = {
        id = "gqiul-n9por";
        label = "Projects";
        devices = [ "Gaia" "Federer" ];
      };
    };
  };
}
