{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, disko, ... }:
    let
      system = "x86_64-linux";
      hostName = "workstation";
      rootAuthorizedKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGPoHVrToSwWfz+DaUX68A9v70V7k3/REqGxiDqjLOS+"
      ];
    in
    {
      nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./disk-config.nix
          disko.nixosModules.disko
          ({ pkgs, ... }: {
            # Basic system configuration
            networking = { 
              inherit hostName;
            };
            
            # Boot configuration
            boot.loader = {
              efi.canTouchEfiVariables = true;
              systemd-boot.enable = true;
            };
            
            # ZFS support (essential for your storage setup)
            boot.supportedFilesystems = ["zfs"];
            boot.initrd.supportedFilesystems = ["zfs"];
            boot.initrd.kernelModules = [ "zfs" ];
            boot.zfs.forceImportRoot = true;
            boot.zfs.forceImportAll = true;
            
            # SSH for remote access
            services.openssh = {
              enable = true;
              settings.PasswordAuthentication = false;
            };

            # Root user configuration
            users.users.root = {
              openssh.authorizedKeys.keys = rootAuthorizedKeys;
            };
            
            # Enable flakes
            nix.settings.experimental-features = [ "nix-command" "flakes" ];

            # Only the most essential tools for bootstrapping
            environment.systemPackages = with pkgs; [
              git
              neovim
            ];

            system.stateVersion = "24.05";
          })
        ];
      };
    };
}