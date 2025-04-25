{ config, ... }: {
  flake = {
    meta.personal.username = "arne";
    modules.nixos.personal.users.users.${config.flake.meta.personal.username} =
      {
        isNormalUser = true;
        initialPassword = "";
      };
  };
}
