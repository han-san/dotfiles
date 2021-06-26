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

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
  };

  fileSystems = {
      # enable trim for SSDs
      "/".options = [ "noatime" "nodiratime" "discard" ];
      "/boot".options = [ "noatime" "nodiratime" "discard" ];

      # mount internal drives
      "/home/johan/Drives/NVMe" = {
          device = "/dev/disk/by-uuid/862AB33C2AB32857";
          fsType = "ntfs";
          options = [ "noatime" "nodiratime" "discard" ]; # SSD trim
      };

      "/home/johan/Drives/Intern1" = {
          device = "/dev/disk/by-uuid/38E420B0E42071F4";
          fsType = "ntfs";
      };

      "/home/johan/Drives/Intern2" = {
          device = "/dev/disk/by-uuid/7E3096073095C715";
          fsType = "ntfs";
      };
  };

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  networking = {
    hostName = "johan-desktop"; # Define your hostname.

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces = {
      enp24s0.useDHCP = true;
      wlo1.useDHCP = true;
    };

    networkmanager.enable = true;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
  #   # Versions and status of categories.
  #   LC_IDENTIFICATION = "sv_SE.UTF-8";
  #   # Character classification, case conversion and code transformation.
  #   LC_CTYPE = "sv_SE.UTF-8";
  #   # Collation order.
  #   LC_COLLATE = "sv_SE.UTF-8";
  #   # Date and time formats.
    LC_TIME = "en_GB.UTF-8";
  #   # Numeric, non-monetary formatting.
  #   LC_NUMERIC = "sv_SE.UTF-8";
  #   # Monetary formatting.
  #   LC_MONETARY = "sv_SE.UTF-8";
  #   # Formats of informative and diagnostic messages and interactive responses.
  #   LC_MESSAGES = "sv_SE.UTF-8";
  #   # Character transliteration.
  #   LC_XLITERATE = "sv_SE.UTF-8";
  #   # Format of writing personal names.
  #   LC_NAME = "sv_SE.UTF-8";
  #   # Format of postal addresses.
  #   LC_ADDRESS = "sv_SE.UTF-8";
  #   # Format for telephone numbers, and other telephone information.
  #   LC_TELEPHONE = "sv_SE.UTF-8";
    # Paper format.
    LC_PAPER = "en_GB.UTF-8";
  #   # Information on measurement system.
    LC_MEASUREMENT = "en_GB.UTF-8";
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
      videoDrivers = [ "nvidia" ];

      # Configure keymap in X11
      layout = "us";
      xkbVariant = "colemak";
      # xkbOptions = "eurosign:e";

      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    # gnome systray
    udev.packages = [ pkgs.gnome3.gnome-settings-daemon ];

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable the OpenSSH daemon.
    openssh.enable = true;
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

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
    dunst #hm
    firefox #hm
    gnomeExtensions.appindicator
    gnome.gnome-tweaks
    mpv #hm
    ntfs3g
    p7zip
    syncthing #hm
    tmux #hm
    ungoogled-chromium #hm
    xclip
    zathura #hm

    # Development
    ## General
    git #hm
    git-lfs #hm
    kak-lsp #hm
    kakoune #hm
    neovim #hm
    ## Haskell
    cabal-install
    ghc
    haskell-language-server #lsp
    stack
    ## JS
    nodejs
    deno #lsp
    ## Python
    python
    python-language-server #lsp
    ## Shell
    shellcheck
    ## Rust
    cargo
    clippy
    rls #lsp
    rust-analyzer
    rustc
    rustfmt
    ## C++
    clang_12
    clang-analyzer
    clang-tools
    cmake
    gcc
    gdb
    gnumake
    lldb
    qt5Full

    # Document
    texlive.combined.scheme-basic #hm
    texlab #lsp
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.johan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.johan = import ./home.nix;
  };
}
