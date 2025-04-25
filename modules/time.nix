{
  flake.modules = let timeZone = "Europe/Oslo";
  in {
    nixos = {
      nixos.desktop.services.ntpd-rs.enable = true;
      homeManager.base.home.sessionVariables.TZ = timeZone;
    };
  };
}
