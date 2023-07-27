{ config, ... }:
{
  programs.mpv = {
    enable = true;
    defaultProfiles = [ "gpu-hq" ];
    config = {
      cscale = "ewa_lanczos";
      scale = "ewa_lanczossharp";
      tscale = "oversample";
      interpolation = true;
      video-sync = "display-resample";
    };
  };

  xdg.configFile."jellyfin-mpv-shim/mpv.conf".source = config.xdg.configFile."mpv/mpv.conf".source;
}
