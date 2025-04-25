{
  flake.modules.homeManager.gui = { pkgs, ... }: {
    home.packages = with pkgs; [ google-cloud-sdk ];
  };
}
