{
  flake.modules.homeManager.gui = { pkgs, ... }: {
    home.packages = with pkgs; [ android-studio ];
  };
  nixpkgs.allowedUnfreePackages = [ "android-studio-stable" ];
}
