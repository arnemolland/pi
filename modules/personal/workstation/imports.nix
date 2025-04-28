{ config, ... }: {
  flake.modules.nixos."nixosConfigurations/workstation".imports =
    with config.flake.modules.nixos; [
      desktop
      kde
      nvidia-gpu
      personal
    ];
}
