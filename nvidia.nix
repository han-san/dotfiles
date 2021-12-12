config:
{
  package = config.boot.kernelPackages.nvidiaPackages.legacy_390;
  modesetting.enable = true;
  prime = {
    sync.enable = true;
    nvidiaBusId = "PCI:1:0:0";
    intelBusId = "PCI:0:2:0";
  };
}
