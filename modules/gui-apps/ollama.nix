{
  flake.modules.homeManager.gui = { pkgs, ... }: {
    home.packages = with pkgs; [ ollama-cuda ];
  };
}
