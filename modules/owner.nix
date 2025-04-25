{ config, ... }: {
  flake = {
    meta.owner = {
      email = "arne@molland.sh";
      name = "Arne Molland";
      username = "arnemolland";
    };

    modules = {
      nixos.desktop = {
        security.sudo-rs.enable = true;

        users.users.${config.flake.meta.owner.username} = {
          isNormalUser = true;
          initialPassword = "";
          extraGroups = [ "wheel" "input" "kvm" ];
        };

        nix.settings.trusted-users = [ config.flake.meta.owner.username ];
      };
    };
  };
}
