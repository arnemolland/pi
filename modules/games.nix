{
  flake.modules = {
    nixos.desktop = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        mangohud
        protonup-qt
        lutris
        bottles
        heroic
      ];
    };
  };
}
