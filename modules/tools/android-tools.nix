{
  flake.modules.homeManager.gui = { pkgs, ... }: {
    home.packages = with pkgs; [ android-tools ];
  };
}
