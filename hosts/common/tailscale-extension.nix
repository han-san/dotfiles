{ config, pkgs, lib, ... }:
{
  options.services.tailscale.tailnetName = lib.mkOption {
    default = null;
    type = lib.types.str;
    description = ''
      The tailnet name of the tailscale mesh network.
    '';
  };
}
