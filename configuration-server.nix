# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [
      <home-manager/nixos>
      ./server/syncthing.nix
      ./server/nginx.nix
      #      ./server/tinytinyrss.nix
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
      group = "media";
    };

    transmission = {
      enable = true;
      openPeerPorts = true;
      openRPCPort = true;
      group = "media";
      #credentialsFile = somearcnixthing?;
      settings = {
        #download-dir = "/media/johan/downloads";
        rpc-bind-address = "0.0.0.0";
        rpc-whitelist-enabled = false;
        rpc-host-whitelist-enabled = true;
        rpc-host-whitelist = "federer.${config.services.tailscale.tailnetName}";
        ratio-limit-enabled = true;
        ratio-limit = 0;
      };
    };

    sonarr = {
      enable = true;
      openFirewall = true;
      group = "media";
      #group = "";
    };

    radarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "johan.sandred@protonmail.com";
  };

  users.groups = {
    media = { };
  };

  users.users.johan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "media" ];
    packages = with pkgs; [
      kakoune
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINHog6/0hxWQiHsnbomKBn1nLK7smKYfHGk0YcfOVq4n johan@hansan-laptop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGxlasMoSJCYmVmT3T8HLmWYqoUX+0NO5gM5xaiRYto7 johan@hansan-desktop"
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

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.johan = import ./home/home-server.nix;
  };
}

