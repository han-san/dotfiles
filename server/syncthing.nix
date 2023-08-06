{ config, ... }:

{
  environment.etc.foo.text = builtins.readFile ./syncthingpass.txt;
  services.syncthing = {
    enable = true;
    user = "johan";
    dataDir = "/home/johan/Sync";
    openDefaultPorts = true;
    guiAddress = "0.0.0.0:8384";
    extraOptions.gui = {
      user = "johan";
      # FIXME: Temporary solution
      password = builtins.readFile ./syncthingpass.txt;
    };

    devices = with config.services.tailscale; {
      Laptop = {
        id = "WVY2A3Q-R5OBFOW-UPSG77Z-FDMGETT-K4AIIGM-MSSXJRE-BRTQXSN-HC2KVAF";
        introducer = true;
        addresses = [ "tcp://hansan-laptop.${tailnetName}:22000" ];
      };
      Phone = {
        id = "KYLVEZL-RUMAOH3-EN43MXV-QXSTIMT-ABMWQCB-A3SNTTJ-MUYJK7C-KYIFJQT";
        introducer = true;
      };
      Desktop = {
        id = "I4VJCRD-G2YEKD6-YEI3UYN-CP6KT3T-F25MBXL-WNQFSBQ-JESNMZO-JYF7NQZ";
        introducer = true;
        addresses = [ "tcp://hansan-desktop.${tailnetName}:22000" ];
      };
    };

    folders = with config.services.syncthing; {
      "${dataDir}/Keepass" = {
        id = "cncxg-cggmc";
        label = "Keepass";
        devices = [ "Laptop" "Phone" "Desktop" ];
      };
      "${dataDir}/Todos" = {
        id = "nxmmm-bfstv";
        label = "Todos";
        devices = [ "Laptop" "Desktop" ];
      };
      "${dataDir}/Projects" = {
          id = "gqiul-n9por";
          label = "Projects";
          devices = [ "Laptop" "Desktop" ];
      };
    };
  };

  # Web GUI.
  networking.firewall.allowedTCPPorts = [ 8384 ];
}
