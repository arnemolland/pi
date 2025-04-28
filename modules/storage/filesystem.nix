{
  flake.modules.nixos.desktop = {
    # Ensure ZFS support is enabled in both kernel and initrd
    boot.supportedFilesystems = ["zfs"];
    boot.initrd.supportedFilesystems = ["zfs"];
    
    # Force import root pool (important for ZFS root)
    boot.zfs.forceImportRoot = true;
    boot.zfs.forceImportAll = true;
    
    # ZFS maintenance settings
    services.zfs.autoScrub.enable = true; 
    services.zfs.autoScrub.interval = "monthly";

    # Root filesystem using ZFS with legacy mounting
    fileSystems."/" = {
      device = "rpool/root";
      fsType = "zfs";
      options = [ "X-mount.mkdir" ];  # Removed "zfsutil"
    };
    
    # Boot filesystem using vfat (EFI System Partition)
    fileSystems."/boot" = {
      device = "/dev/disk/by-label/boot";  # Make sure this partition is labeled "boot"
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  };
}
