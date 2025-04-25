{
  flake.modules.homeManager.gui = { pkgs, ... }: {
    home.packages = with pkgs; [ python3 pytyon3Packages.pipenv ];
  };
}
