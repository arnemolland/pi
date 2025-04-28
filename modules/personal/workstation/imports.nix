{ config, ... }: {
  flake.modules.nixos."nixosConfigurations/workstation".imports =
    with config.flake.modules.nixos; [
      kde
      nvidia-gpu
      personal
    ];
}
