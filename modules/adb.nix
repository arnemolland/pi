{ config, ... }: {
  flake.modules.nixos.desktop.programs.adb.enable = true;
  flake.modules.nixos.workstation.users.extraGroups.adb.members =
    [ config.flake.meta.owner.username ];
}
