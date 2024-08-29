{ inputs, config, pkgs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../common/configuration.nix
    ./syncthing.nix
    ./desktop-environment.nix
  ];
  # Make X11 start on intel integrated graphics
  boot.kernelParams = [ "i915.force_probe=46a6" ];

  # sops.secrets.eduroam-cert = {
  #   sopsFile = ./secrets.yaml;
  # };

  # For some reason this doesn't work.
  # Eduroam certificate
  # security.pki.certificateFiles = [ config.sops.secrets.eduroam-cert.path ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.supportedFilesystems = [ "ntfs" ];

  networking = {
    hostName = "Hermes"; # Define your hostname.

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces = {
      wlp0s20f3.useDHCP = true;
    };

    networkmanager.enable = true;

    firewall = {
      trustedInterfaces = [ config.services.tailscale.interfaceName ];
      allowedUDPPorts = [ config.services.tailscale.port ];
    };
  };

  services = {
    # Enable CUPS to print documents.
    printing.enable = true;

    fstrim.enable = true;
  };

  fonts.packages = with pkgs; [
    iosevka
    noto-fonts-cjk
    font-awesome
  ];

  # Enable sound with pipewire.
  #sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # An extraLuaConfig option should be available soon. Check https://nixos.wiki/wiki/PipeWire.
  services.pipewire.wireplumber.configPackages = [
    (pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
      bluez_monitor.properties = {
        ["bluez5.enable-sbc-xq"] = true,
        ["bluez5.enable-msbc"] = true,
        ["bluez5.enable-hw-volume"] = true,
        ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
      }
    '')
  ];

  hardware.graphics= {
    enable = true;
    # Don't know which ones are actually necessary.
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Other
    dmenu
    dunst #hm
    eva
    file
    firefox #hm
    gnuplot
    mpv #hm
    onedrive
    p7zip
    tailscale
    tmux #hm
    tree
    zathura #hm
    wl-clipboard
    wl-clipboard-x11

    # Development
    ## General
    git #hm
    git-lfs #hm
    kakoune #hm
    man-pages
    man-pages-posix
    neovim #hm
    ## Python
    python3
    ## C++
    clang_14
    gcc
    gnumake
    # Nix
    nixpkgs-fmt
  ];

  # Required to add sway to GDM.
  programs.sway.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  programs.light.enable = true;

  programs.adb.enable = true;
  virtualisation.libvirtd.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.johan = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Johan Sandred";
    extraGroups = [
      "wheel"
      "networkmanager"
      "adbusers"
      "video"
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useUserPackages = true;
    useGlobalPkgs = true;
    users.johan = import ./home/home.nix;
  };

}
