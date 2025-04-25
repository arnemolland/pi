{
  nixpkgs.allowedUnfreePackages = [ "steam" "steam-unwrapped" ];
  flake.modules.nixos.desktop.programs.steam.enable = true;
  flake.modules.nixos.desktop.programs.gamemode.enable = true;
}
