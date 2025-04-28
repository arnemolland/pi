{ config, ... }: {
  # Define the personal home-manager module that will be imported by the main home-manager config
  flake.modules.homeManager.personal = {};
  
  # The following is commented out to prevent duplicate Home Manager user configuration
  # since we're now importing the personal module directly in home-manager/nixos.nix
  # flake.modules.nixos.personal = {
  #   home-manager.users.${config.flake.meta.owner.username} =
  #     { osConfig, ... }: {
  #       home.stateVersion = osConfig.system.stateVersion;
  #       imports = [ config.flake.modules.homeManager.personal ];
  #     };
  # };
}
