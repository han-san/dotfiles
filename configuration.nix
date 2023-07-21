# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Home Manager's channel must be added in order for this import to work.
      <home-manager/nixos>
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

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

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

  # Select internationalisation properties.

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
  #   # Versions and status of categories.
    LC_IDENTIFICATION = "sv_SE.UTF-8";
  #   # Character classification, case conversion and code transformation.
  #   LC_CTYPE = "sv_SE.UTF-8";
  #   # Collation order.
  #   LC_COLLATE = "sv_SE.UTF-8";
  #   # Date and time formats.
    LC_TIME = "sv_SE.UTF-8";
  #   # Numeric, non-monetary formatting.
    LC_NUMERIC = "sv_SE.UTF-8";
  #   # Monetary formatting.
    LC_MONETARY = "sv_SE.UTF-8";
  #   # Formats of informative and diagnostic messages and interactive responses.
  #   LC_MESSAGES = "sv_SE.UTF-8";
  #   # Character transliteration.
  #   LC_XLITERATE = "sv_SE.UTF-8";
  #   # Format of writing personal names.
    LC_NAME = "sv_SE.UTF-8";
  #   # Format of postal addresses.
    LC_ADDRESS = "sv_SE.UTF-8";
  #   # Format for telephone numbers, and other telephone information.
    LC_TELEPHONE = "sv_SE.UTF-8";
    # Paper format.
    LC_PAPER = "sv_SE.UTF-8";
  #   # Information on measurement system.
    LC_MEASUREMENT = "sv_SE.UTF-8";
  #   # Format for idenitfying keyboards.
  #   LC_KEYBOARD = "sv_SE.UTF-8";
  };

  console = {
  #   font = "Lat2-Terminus16";
    keyMap = "colemak";
  };

  # Enable the X11 windowing system.
  services = {
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

    # Enable the OpenSSH daemon.
    openssh.enable = true;

    fstrim.enable = true;

    tailscale.enable = true;
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

  nixpkgs.config.allowUnfree = true;

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

  documentation.dev.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  programs.adb.enable = true;
  boot.kernelModules = [ "kvm-amd" ];
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
    users.johan = import ./home.nix;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
