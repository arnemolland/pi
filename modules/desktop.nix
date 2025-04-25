{
  # Define the desktop module for the flake structure
  flake.modules.nixos.desktop = { pkgs, ... }: {
    services = {
      xserver = {
        enable = true;
        xkb = {
          layout = "no";
          variant = "";
        };
      };
      
      displayManager = {
        sddm.enable = true;
        autoLogin = {
          enable = true;
          user = "arne";
        };
      };
      
      desktopManager.plasma6.enable = true;
    };
    
    # Wayland Support
    environment.sessionVariables = { NIXOS_OZONE_WL = "1"; };
    
    # XDG Portal Configuration
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };
}