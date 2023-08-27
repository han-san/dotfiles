{ pkgs, ... }:
{
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

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnomeExtensions.appindicator

    xclip
  ];
}
