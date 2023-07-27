{ pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "johan" ];
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      # type database DBuser origin-address auth-method
      # ipv4
      host   all      all    0.0.0.0/0      trust
      local  all      all                   trust
    '';
    package = pkgs.postgresql_15;
  };
}
