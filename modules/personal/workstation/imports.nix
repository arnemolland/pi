{ config, ... }: {
  flake.modules.nixos."nixosConfigurations/workstation".imports =
    with config.flake.modules.nixos; [
      # kde already imports desktop, so we don't need to import desktop separately
      kde
      nvidia-gpu
      personal
    ];
}
