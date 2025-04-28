# Arne's Dotfiles & System Configurations

This repository contains my NixOS and macOS (Darwin) system configurations and home-manager dotfiles, structured for maximum reusability and cross-platform compatibility.

## Repository Structure

```
pi/
├── machines/        # Installation flakes for various systems 
│   └── workstation/ # NixOS installation configuration with ZFS
├── hosts/           # Host-specific configurations
│   ├── common.nix   # Common configuration for all hosts
│   ├── nixos.nix    # NixOS-specific configuration
│   └── darwin.nix   # Darwin-specific configuration
├── users/           # User-specific configurations
│   └── arne/        # My user directory
│       ├── default.nix  # User base configuration
│       ├── home.nix     # Home-manager configuration
│       ├── nixos.nix    # NixOS-specific user config
│       └── darwin.nix   # Darwin-specific user config
└── modules/         # Reusable configuration modules
    ├── home-manager/  # Home Manager modules
    │   ├── cli/       # CLI tools configs
    │   └── desktop/   # GUI tools configs
    ├── nixos/         # NixOS-specific modules
    └── darwin/        # Darwin-specific modules
```

## Installation

### Fresh NixOS Installation with ZFS (Machines/Workstation)

1. Boot from a NixOS installation media

2. Install Nix flakes if not already installed:
   ```bash
   nix-shell -p nixFlakes git
   ```

3. Clone this repository:
   ```bash
   git clone https://github.com/arnemolland/pi.git
   cd pi/machines/workstation
   ```

4. Find your disk ID:
   ```bash
   ls -l /dev/disk/by-id/
   ```

5. Run the installation with the correct disk ID:
   ```bash
   sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko --flake .#workstation --arg device '"/dev/disk/by-id/your-disk-id"'
   
   # Install NixOS
   sudo nixos-install --flake .#workstation
   ```

6. Reboot into your newly installed system and set up users as needed.

### Applying Home Manager Configuration to Existing System

#### On NixOS:

```bash
# Clone the repo
git clone https://github.com/arnemolland/pi.git
cd pi

# Build and apply the configuration
sudo nixos-rebuild switch --flake .#workstation
```

#### On macOS:

1. Install nix-darwin first:
   ```bash
   # Install Nix
   sh <(curl -L https://nixos.org/nix/install)
   
   # Install nix-darwin
   nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
   ./result/bin/darwin-installer
   ```

2. Apply the configuration:
   ```bash
   # Clone the repo
   git clone https://github.com/arnemolland/pi.git
   cd pi
   
   # Build and apply
   nix run nix-darwin -- switch --flake .#macbook
   ```

#### Standalone Home Manager:

```bash
# Clone the repo
git clone https://github.com/arnemolland/pi.git
cd pi

# Build and apply (for NixOS)
nix run home-manager/master -- switch --flake .#arne@workstation

# Build and apply (for macOS)
nix run home-manager/master -- switch --flake .#arne@macbook
```

## Updating

```bash
# Update flake inputs
nix flake update

# Apply the updated configuration
# NixOS:
sudo nixos-rebuild switch --flake .#workstation

# macOS:
nix run nix-darwin -- switch --flake .#macbook
```

## Adding New Modules

1. Create a new module file in the appropriate directory
2. Import the module in the respective configuration file
3. Apply the configuration

## License

MIT