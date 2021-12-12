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

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    enable = true;
    version = 2;
    # Define on which hard drive you want to install Grub.
    device = "/dev/sda"; # or "nodev" for efi only
  };
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  networking = {
    hostName = "hansan-laptop"; # Define your hostname.

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces = {
      ens5.useDHCP = true;
      wls1.useDHCP = true;
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

      # Configure keymap in X11
      layout = "us";
      xkbVariant = "colemak,";
      xkbOptions = "grp:win_space_toggle";
      # xkbOptions = "eurosign:e";

      displayManager.lightdm.enable = true;
      desktopManager.xfce.enable = true;

      # Enable touchpad support (enabled default in most desktopManager).
      libinput.enable = true;
    };

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable the OpenSSH daemon.
    openssh.enable = true;
  };

  programs.nm-applet.enable = true; # Networking app for xfce.


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
    mpv #hm
    p7zip
    #(steam.override {
        #withPrimus = true;
        #extraPkgs = pkgs: [ bumblebee glxinfo ];
        #nativeOnly = true;
    #}).run
    syncthing #hm
    tmux #hm
    ungoogled-chromium #hm
    xclip
    zathura #hm
    zoom-us

    # Development
    ## General
    arduino
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
    ## Dotnet
    fsharp
    mono

    # Document
    (texlive.combine { inherit (texlive) scheme-basic listings; }) #hm
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

  #services.xserver.videoDrivers = [ "nvidia" ];
  #hardware.nvidia = import ./nvidia.nix config;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  users.extraGroups.vboxusers.members = [ "johan" ];

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
    description = "Johan Sandred";
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.johan = import ./home.nix;
  };
}
