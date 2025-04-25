{
  flake.modules.homeManager.gui = { pkgs, ... }: {
    home.packages = with pkgs; [ vscode ];
  };
}
