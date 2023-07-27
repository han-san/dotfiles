# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [
      ./server/syncthing.nix
      ./server/nginx.nix
      ./server/postgresql.nix
      ./configuration-common.nix
    ];

  # Use the systemd-boot EFI boot loader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "/dev/sda";
  boot.supportedFilesystems = [ "ntfs" ];
  #fileSystems."/media/extssd" = {
  #  device = "/dev/disk/by-uuid/74D5F0B0357573B3";
  #  fsType = "ntfs-3g";
  #  options = [ "rw" "uid=${toString config.users.users.root.uid}" ];
  #};

  networking = {
    hostName = "Federer";
    networkmanager.enable = true;
  };

  services = {
      openssh.settings.PasswordAuthentication = false;

      jellyfin = {
          enable = true;
          openFirewall = true;
      };
  };

  users.users.johan = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      kakoune
    ];
    openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFEXDJBrK/nRUtN448qukWkkQa4eMfX7DX4Nf5quHGIVHQDM39qbwSOk/hbyglQjr5Oz+4zmo8U2zPV1IFQvTBTBIsfk9YdYpnqdADeIAwv2Oaq5w7qlCzMJtqSqMC8Dvb955SgbQSUWDfyddEpzB+Cqwdqh8ra3Hn+SJJMO8M8NcCZ4UkzEFh1D3VUOdDbF6GYxufcRunQqxAuss2l+vEN6howOpE3gerDtzVCLzrTMkt38BouoYZ9oByQRwIFvy2VVTrP/QCuhu5eFD0wN0wLNXQPCB31WJp+AAT5f/pY3QymWNEpsusKlnkCtW7JUypWhYbR7VkfFcd6ibZDO7b johan@DESKTOP-U1NK4GN"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDdeu5Ygm/qa+Fl7nFxWbesl+nEA8Gl9YQwaRf4kvKzWvWxMs/jnD5VK18aP6w+Q/r8RYvL4BxzJl5Po54YXesJ3BkxuLuKuXPjiLnSmrCiBmHlHGITYtklOQctW/F/Gq+hIOo0jnlGzP7MnlMIbeQUX5xoyBuXgemq/jYjDosCNkB9uocijHAsPSXF5mliDwBR6Qd236x3Z4eQybJbFc3METBdvxmELLU6Cj5Py1W8vfZHRhv3hchFU2RcGVCrG6aSaGmagT0KuaxkPXi7G0p9JIEgq6Qv1hN0AG3lF1+wJ9cyS1uCbe1WGmph/OY1ujgHisMF8E4LN/+Q4A1Ec+pwoJYpKjqvClhoLtzCTGea0BvSPgp3LifNAxJJYG9ORxb1QrxwwJQX3LpouKuPta+E3ojPG4xWA+5uYutnoJGHIS1treVzRYK45RgTcNsIH7dU71MmQEpu0xAqNhZkC/ljdiMvv3HLm8qt2tUqi/Itaez39V9YcP4aIqs9FPSgDwc= johan@hansan-laptop"
    ];
  };

  environment.systemPackages = with pkgs; [
    neovim
    kakoune
    tailscale
    emacs
    git
  ];
}

