# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./tailscale-extension.nix
    ];

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

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

  services = {
    tailscale = {
      enable = true;
      tailnetName = "siren-tuna.ts.net";
    };

    # Enable the OpenSSH daemon.
    openssh.enable = true;

    locate = {
      enable = true;
      package = pkgs.plocate;
      localuser = null; # plocate doesn't support this option.
    };
  };

  # For passphrases?
  programs.ssh.startAgent = true;

  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  documentation = {
    dev.enable = true;
    man.generateCaches = true;
  };

  security.sudo.execWheelOnly = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # NOTE: Not available with flakes.
  #system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
