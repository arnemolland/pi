{ config, ... }: {
  flake = {
    meta.personal.username = config.flake.meta.owner.username;
    
    # Comment out any duplicate user definition that conflicts with owner.nix
    # modules.nixos.personal.users.users.${config.flake.meta.personal.username} =
    #   {
    #     isNormalUser = true;
    #     initialPassword = "temp";
    #   };
  };
}