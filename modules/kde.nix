{ config, ... }: {
  flake.modules.nixos.kde = {
    # Import base desktop configuration
    imports = [ config.flake.modules.nixos.desktop ];

    # KDE-specific settings
    services = {
      displayManager = {
        sddm.enable = true;
        autoLogin = {
          enable = false;
          user = "${config.flake.meta.owner.username}";
        };
      };
      desktopManager.plasma6.enable = true;
    };
  };
}