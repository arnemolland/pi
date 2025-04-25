{ config, ... }: {
  flake.modules.nixos."nixosConfigurations/workstation".imports =
    with config.flake.modules.nixos; [
      desktop
      nvidia-gpu
      personal
    ];
}
