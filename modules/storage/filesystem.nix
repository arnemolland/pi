{
  flake.modules.nixos.desktop = {
    # Ensure ZFS support is enabled
    boot.supportedFilesystems = ["zfs"];
    
    # Force import root pool (important for ZFS root)
    boot.zfs.forceImportRoot = true;
    
    # ZFS maintenance settings
    services.zfs.autoScrub.enable = true; 
    services.zfs.autoScrub.interval = "monthly";

    # Root filesystem using ZFS
    fileSystems."/" = {
      device = "rpool/root";
      fsType = "zfs";
      options = [ "zfsutil" "X-mount.mkdir" ];
    };
    
    # Boot filesystem using vfat (EFI System Partition)
    fileSystems."/boot" = {
      device = "/dev/disk/by-label/boot";  # During install, label the boot partition "boot"
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  };
}
