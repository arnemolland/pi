{
  flake.modules.nixos."nixosConfigurations/workstation".facter.reportPath =
    ./facter.json;
}
