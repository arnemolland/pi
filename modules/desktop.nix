{
  flake.modules.nixos.desktop = { pkgs, ... }: {
    # Common X server configuration
    services.xserver = {
      enable = true;
      xkb = {
        layout = "no";
        variant = "";
      };
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