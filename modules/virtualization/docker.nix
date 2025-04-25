{ config, ... }: {
  flake.modules.nixos.workstation = {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = true;
      daemon.settings.features.cdi = true;
    };
    users.extraGroups.docker.members = [ config.flake.meta.owner.username ];
  };
}
