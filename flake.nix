{
  nixConfig = {
    abort-on-warn = true;
    extra-experimental-features = [ "pipe-operators" ];
    allow-import-from-derivation = false;
    allowUnfree = true;
  };

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
      inputs.nixpkgs-fmt.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = { url = "github:hyprwm/Hyprland"; };

    zen-browser = { url = "github:0xc000022070/zen-browser-flake"; };

    nixos-facter-modules = { url = "github:numtide/nixos-facter-modules"; };

    nuschtos-search = {
      url = "github:NuschtOS/search";
      inputs = { nixpkgs.follows = "nixpkgs"; };
    };

    cpu-microcodes = {
      flake = false;
      url = "github:platomav/CPUMicrocodes";
    };

    ucodenix = {
      url = "github:e-tho/ucodenix";
      inputs.cpu-microcodes.follows = "cpu-microcodes";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        nuschtosSearch.follows = "nuschtos-search";
      };
    };

    refjump-nvim = {
      flake = false;
      url = "github:mawkler/refjump.nvim";
    };

    sink-rotate = {
      url = "github:mightyiam/sink-rotate";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
    };

    smart-scrolloff-nvim = {
      flake = false;
      url = "github:tonymajestro/smart-scrolloff.nvim";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vim-autoread = {
      flake = false;
      url =
        "github:djoshea/vim-autoread/24061f84652d768bfb85d222c88580b3af138dab";
    };

    zsh-auto-notify = {
      flake = false;
      url = "github:MichaelAquilina/zsh-auto-notify";
    };

  };

  outputs = 
    inputs:
    let
      lib = inputs.nixpkgs.lib;
      modulesPath = ./modules;
    in
    inputs.flake.parts.lib.mkFlake
    {
      inherit inputs;
      specialArgs = {
        lib = lib;
      };
    }
    {
      imports =
        modulesPath
        |> lib.filesystem.listFilesRecursive
        |> lib.filter (lib.hasSuffix ".nix")
          |> lib.filter (
            path:
            path
            |> lib.path.removePrefix modulesPath
            |> lib.path.subpath.components
            |> lib.all (component: !(lib.hasPrefix "_" component))
          );

        systems = [
          "x86_64-linux"
          "aarch64-linux"
        ];
    };
}
