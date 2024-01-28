
{ config, pkgs, ... }:

{
  imports = [
      # Home Manager's channel must be added in order for this import to work.
      <home-manager/nixos>
      <nixos-wsl/modules>
      ./configuration-common.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "johan";

  networking = {
    hostName = "Ouranos"; # Define your hostname.

    #firewall = {
      #trustedInterfaces = [ config.services.tailscale.interfaceName ];
      #allowedUDPPorts = [ config.services.tailscale.port ];
    #};
  };

  #fonts.packages = with pkgs; [
    #iosevka
    #noto-fonts-cjk
  #];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Other
    eva
    file
    gnuplot
    #p7zip
    tailscale
    #tmux #hm
    #tree
    #zathura #hm
    #wl-clipboard
    #wl-clipboard-x11

    # Development
    ## General
    gnumake
    git #hm
    #git-lfs #hm
    kakoune #hm
    #man-pages
    #man-pages-posix
    neovim #hm
    ## Python
    #python3
    ## C++
    #clang_14
    #gcc
    #gnumake
    # Nix
    #nixpkgs-fmt
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.johan = {
    isNormalUser = true;
    description = "Johan Sandred";
    extraGroups = [
      "wheel"
    ];
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.johan = import ./home/home-wsl.nix;
  };

}
