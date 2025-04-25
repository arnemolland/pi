{
  flake.modules.nixos.personal = {
    services = {
      xserver = {
        enable = true;
        xkb = {
          layout = "no";
          variant = "";
        };
      };

      # Moved from xserver.displayManager
      displayManager = {
        sddm.enable = true;
        autoLogin = {
          enable = true;
          user = "arne";
        };
      };

      # Moved from xserver.desktopManager
      desktopManager.plasma6.enable = true;
    };
  };
}
