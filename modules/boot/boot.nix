{ lib, ... }:
{
  flake.modules.nixos.desktop =
    { config, ... }:
    {
      boot.loader = {
        timeout = 4;
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = true;
        systemd-boot.configurationLimit = 10;  # Optional: limit number of generations
      };
      
      # Use a simple single boot partition config instead of redundancy
      fileSystems."/boot" = {
        device = "/dev/disk/by-label/boot";  # Use filesystem label
        fsType = "vfat";
        options = [
          "fmask=0022"
          "dmask=0022"
        ];
      };
    };
}