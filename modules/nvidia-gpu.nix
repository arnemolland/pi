{ config, lib, pkgs, ... }: {
  flake.modules.nixos.nvidia-gpu = { config, pkgs, ... }: {
    hardware.nvidia = {
      # Modesetting is required.
      modesetting.enable = true;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      powerManagement.enable = false;
      powerManagement.finegrained = false;

      # Use the NVidia open source kernel module
      open = true;

      # Enable the Nvidia settings menu
      nvidiaSettings = true;

      # Package - fixed to not use config.boot path
      package = pkgs.linuxPackages.nvidiaPackages.beta;
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    # Add kernel parameters from your existing configuration
    boot.kernelParams = [ "module_blacklist=amdgpu,i915" "nvidia-drm.fbdev=1" ];
  };
  nixpkgs.allowedUnfreePackages = [ "nvidia-x11" "nvidia-settings" "cuda_cudart" "libcublas" "cuda_cccl" "cuda_nvcc" ];
}
