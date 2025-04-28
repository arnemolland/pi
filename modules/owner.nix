{ config, ... }: {
  flake = {
    meta.owner = {
      email = "arne@molland.sh";
      name = "Arne Molland";
      username = "arne";
    };

    modules = {
      nixos.desktop = {
        security.sudo-rs.enable = true;

        users.users.${config.flake.meta.owner.username} = {
          isNormalUser = true;
          initialPassword = "temppassword";  # Changed from "temp" for better security
          extraGroups = [ "wheel" "input" "kvm" ];
          home = "/home/${config.flake.meta.owner.username}";  # Dynamic home path
          createHome = true;  # Ensure home is created
        };

        nix.settings.trusted-users = [ config.flake.meta.owner.username ];
      };
    };
  };
}
