{ config, ... }:
{
  services.syncthing = {
    enable = true;
    user = "johan";
    dataDir = "/home/johan/Sync";
    openDefaultPorts = true;

    devices =
      let
        tailscaleDomain = "tailf7aba.ts.net";
      in
      {
        Phone = {
          id = "KYLVEZL-RUMAOH3-EN43MXV-QXSTIMT-ABMWQCB-A3SNTTJ-MUYJK7C-KYIFJQT";
        };
        Desktop = {
          id = "I4VJCRD-G2YEKD6-YEI3UYN-CP6KT3T-F25MBXL-WNQFSBQ-JESNMZO-JYF7NQZ";
          addresses = [ "tcp://hansan-desktop.${tailscaleDomain}:22000" ];
        };
        Federer = {
          id = "YFXUNZH-6V2DILS-H2BKHKD-7C4EOY7-7745UPQ-Z6TYDLI-V32JYT2-PGFAEQJ";
          addresses = [ "tcp://federer.${tailscaleDomain}:22000" ];
        };
      };

    folders = {
      "${config.services.syncthing.dataDir}/Keepass" = {
        id = "cncxg-cggmc";
        label = "Keepass";
        devices = [ "Phone" "Desktop" "Federer" ];
      };
      "${config.services.syncthing.dataDir}/Todos" = {
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
