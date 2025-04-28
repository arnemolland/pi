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
          initialPassword = "temp";  # Changed from "temp"
          extraGroups = [ "wheel" "input" "kvm" ];
          home = "/home/arne";       # Explicitly set home directory
          createHome = true;         # Ensure home is created
        };

        nix.settings.trusted-users = [ config.flake.meta.owner.username ];
      };
    };
  };
}
