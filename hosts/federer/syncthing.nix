{ config, ... }:

{
  sops.secrets.syncthing-pass.sopsFile = ./secrets.yaml;
  services.syncthing = {
    enable = true;
    user = "johan";
    dataDir = "/home/johan/Sync";
    openDefaultPorts = true;
    guiAddress = "0.0.0.0:8384";
    settings = {
      gui = {
        user = "johan";
        password = builtins.readFile config.sops.secrets.syncthing-pass.path;
      };

      devices = with config.services.tailscale; {
        Hermes = {
          id = "WVY2A3Q-R5OBFOW-UPSG77Z-FDMGETT-K4AIIGM-MSSXJRE-BRTQXSN-HC2KVAF";
          introducer = true;
          addresses = [ "tcp://hermes.${tailnetName}:22000" ];
        };
        Phone = {
          id = "KYLVEZL-RUMAOH3-EN43MXV-QXSTIMT-ABMWQCB-A3SNTTJ-MUYJK7C-KYIFJQT";
          introducer = true;
        };
        Gaia = {
          id = "MMQBJXB-G3RVVZO-AQYIX4P-TTVK4II-YV2VIRC-EETDNXE-D7362BO-VPVETAM";
          introducer = true;
          addresses = [ "tcp://gaia.${tailnetName}:22000" ];
        };
      };

      folders = with config.services.syncthing; {
        "${dataDir}/CV" = {
          id = "CV";
          label = "CV";
          devices = [ "Hermes" "Gaia" ];
        };
        "${dataDir}/Keepass" = {
          id = "cncxg-cggmc";
          label = "Keepass";
          devices = [ "Hermes" "Phone" "Gaia" ];
        };
        "${dataDir}/Todos" = {
          id = "nxmmm-bfstv";
          label = "Todos";
          devices = [ "Hermes" "Gaia" ];
        };
        "${dataDir}/Projects" = {
          id = "gqiul-n9por";
          label = "Projects";
          devices = [ "Hermes" "Gaia" ];
        };
      };
    };
  };

  # Web GUI.
  networking.firewall.allowedTCPPorts = [ 8384 ];
}

