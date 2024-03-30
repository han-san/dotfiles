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
        Hermes = {
          id = "WVY2A3Q-R5OBFOW-UPSG77Z-FDMGETT-K4AIIGM-MSSXJRE-BRTQXSN-HC2KVAF";
          addresses = [ "tcp://hermes.${tailnetName}:22000" ];
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
        devices = [ "Phone" "Hermes" "Federer" ];
      };
      "${dataDir}/Todos" = {
        id = "nxmmm-bfstv";
        label = "Todos";
        devices = [ "Hermes" "Federer" ];
      };
      "/home/johan/Projects" = {
        id = "gqiul-n9por";
        label = "Projects";
        devices = [ "Hermes" "Federer" ];
      };
    };
  };
}
