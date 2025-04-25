{
  flake.modules.homeManager.base = { pkgs, ... }: {
    home.packages = with pkgs; [
      eza
      bat
      fd
      ripgrep
      dust
      fzf
      procs
      bashInteractive
    ];
  };
}
