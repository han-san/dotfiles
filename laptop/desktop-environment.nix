{ pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;

      # Configure keymap in X11
      xkb = {
        layout = "us";
        variant = "colemak_dh_iso";
        options = "grp:win_space_toggle,caps:capslock";
      };

      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    # Make sure systray icons work
    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

    # Required for x11-gestures.
    touchegg.enable = true;
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
    gnomeExtensions.x11-gestures
    touchegg # Required for x11-gestures

    xclip
  ];
}
