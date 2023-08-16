{ config, ... }:
{
  services.syncthing = {
    enable = true;
    user = "johan";
    dataDir = "/home/johan/Sync";
    openDefaultPorts = true;

    devices = with config.services.tailscale;
      {
        Phone = {
          id = "KYLVEZL-RUMAOH3-EN43MXV-QXSTIMT-ABMWQCB-A3SNTTJ-MUYJK7C-KYIFJQT";
        };
        Desktop = {
          id = "76GGNXJ-XQFOS4V-YNPSQG3-7DT7I5O-LE7KXO6-XBU4FEG-HGMG7ZH-HFXPWQO";
          addresses = [ "tcp://hansan-desktop.${tailnetName}:22000" ];
        };
        Federer = {
          id = "YFXUNZH-6V2DILS-H2BKHKD-7C4EOY7-7745UPQ-Z6TYDLI-V32JYT2-PGFAEQJ";
          addresses = [ "tcp://federer.${tailnetName}:22000" ];
        };
      };

    folders = with config.services.syncthing; {
      "${dataDir}/Keepass" = {
        id = "cncxg-cggmc";
        label = "Keepass";
        devices = [ "Phone" "Desktop" "Federer" ];
      };
      "${dataDir}/Todos" = {
        id = "nxmmm-bfstv";
        label = "Todos";
        devices = [ "Desktop" "Federer" ];
      };
      "/home/johan/Projects" = {
        id = "gqiul-n9por";
        label = "Projects";
        devices = [ "Desktop" "Federer" ];
      };
    };
  };
}
