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
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINHog6/0hxWQiHsnbomKBn1nLK7smKYfHGk0YcfOVq4n johan@hansan-laptop"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAsSoptyi4et13k8Fmngq211lsNyyF44yxj33a52BVXA johan@hansan-desktop"
    ];
  };

  environment.systemPackages = with pkgs; [
    neovim
    kakoune
    tailscale
    emacs
    git
    gnumake
    ripgrep
  ];
}

