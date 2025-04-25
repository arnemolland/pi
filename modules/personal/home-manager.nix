{ config, ... }: {
  flake.modules.nixos.personal = {
    home-manager.users.${config.flake.meta.personal.username} =
      { osConfig, ... }: {
        home.stateVersion = osConfig.system.stateVersion;
        imports = [ config.flake.modules.homeManager.personal ];
      };
  };
}
