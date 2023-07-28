{ config, pkgs, ... }:

{
  imports = [
      # Home Manager's channel must be added in order for this import to work.
      <home-manager/nixos>
      ./configuration-common.nix
      ./laptop/syncthing.nix
  ];
  # Make X11 start on intel integrated graphics
  boot.kernelParams = [ "i915.force_probe=46a6" ];

  # Eduroam certificate
  security.pki.certificateFiles = [ ./eduroam.pem ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.supportedFilesystems = [ "ntfs" ];

  networking = {
    hostName = "hansan-laptop"; # Define your hostname.

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
    # Enable the X11 windowing system.
    xserver = {
      enable = true;

      # Configure keymap in X11
      layout = "us";
      xkbVariant = "colemak";
      xkbOptions = "grp:win_space_toggle";

      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    # Make sure systray icons work
    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

    # Enable CUPS to print documents.
    printing.enable = true;

    fstrim.enable = true;
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    epiphany # browser
    geary # mail client
    gnome-music
    totem # video player
    yelp # help viewer
    gnome-contacts
    gnome-maps
  ]);

  fonts.fonts = with pkgs; [
    iosevka
    noto-fonts-cjk
  ];

  # Enable sound with pipewire.
  #sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable  = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.etc = {
    "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
      bluez_monitor.properties = {
        ["bluez5.enable-sbc-xq"] = true,
        ["bluez5.enable-msbc"] = true,
        ["bluez5.enable-hw-volume"] = true,
        ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
      }
    '';
  };

  hardware.opengl.enable = true;

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
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
    xclip
    zathura #hm

    # gnome extensions
    gnome.gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.x11-gestures
    touchegg # Required for x11-gestures
    #gnomeExtensions.gesture-improvements

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

  # Required for x11-gestures.
  services.touchegg.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  programs.adb.enable = true;
  virtualisation.libvirtd.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.johan = {
    isNormalUser = true;
    description = "Johan Sandred";
    extraGroups = [
      "wheel"
      "networkmanager"
      "adbusers"
    ];
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.johan = import ./laptop/home/home.nix;
  };

}
