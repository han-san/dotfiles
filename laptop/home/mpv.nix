{ config, ... }:
{
  programs.mpv = {
    enable = true;
    defaultProfiles = [ "gpu-hq" ];
    config = {
      cscale = "ewa_lanczos";
      scale = "ewa_lanczos";
      tscale = "oversample";
      interpolation = true;
      video-sync = "display-resample";
      vo = "gpu-next";
      hwdec = "auto-safe";
    };
  };

  xdg.configFile."jellyfin-mpv-shim/mpv.conf".source = config.xdg.configFile."mpv/mpv.conf".source;
}
