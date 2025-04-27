{
  flake.modules.nixos.desktop = {
    # Keep ZFS supported for other filesystems if needed
    boot.supportedFilesystems = ["zfs"];
    
    # Keep ZFS maintenance settings for any other ZFS datasets you might have
    services.zfs.autoScrub.enable = true;
    services.zfs.autoScrub.interval = "monthly";

    # Root filesystem configuration matching your actual hardware
    fileSystems."/" = {
      device = "/dev/disk/by-uuid/a329e443-a34a-481e-91a8-f109a4c866d9";
      fsType = "ext4";
    };
    
    # Boot filesystem configuration
    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/CA58-0EC0";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  };
}
