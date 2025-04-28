{ config, pkgs, ... }: {
  flake.modules.nixos.kde = {
    # Import desktop configuration
    imports = [ config.flake.modules.nixos.desktop ];

    # KDE-specific settings
    services = {
      displayManager = {
        sddm = {
          enable = true;
          wayland.enable = true;  # Enable Wayland session in SDDM
          theme = "breeze";       # Use Breeze theme for SDDM
        };
        autoLogin = {
          enable = false;
          user = "${config.flake.meta.owner.username}";
        };
      };
      desktopManager.plasma6.enable = true;
    };
  
    # Additional Wayland Support
    environment.sessionVariables = { 
      NIXOS_OZONE_WL = "1";             # For Electron apps
      MOZ_ENABLE_WAYLAND = "1";         # For Firefox
      QT_QPA_PLATFORM = "wayland";      # For Qt apps
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";  # Remove window decoration in Wayland
    };
    
    # XDG Portal Configuration for KDE
    xdg.portal = {
      extraPortals = with pkgs; [
        xdg-desktop-portal-kde     # Add KDE portal for better integration
      ];
      config.kde = {
        default = [
          "kde"
          "gtk"
        ];
      };
    };

    # Enable recommended KDE services
    services.pipewire = {
      enable = true;
      pulse.enable = true;  # Replace PulseAudio
      alsa.enable = true;   # ALSA support
    };

    # Hardware acceleration for KDE
    hardware.opengl = {
      enable = true;
      driSupport = true;
    };

    # KDE-specific packages
    environment.systemPackages = with pkgs; [
      # Core KDE apps
      libsForQt5.kate            # Text editor
      libsForQt5.ark             # Archive manager
      libsForQt5.okular          # Document viewer
      libsForQt5.dolphin         # File manager
      libsForQt5.spectacle       # Screenshot utility
      libsForQt5.kdeconnect-kde  # Connect to Android devices

      # KDE Plasma widgets and tools
      libsForQt5.plasma-browser-integration
      libsForQt5.plasma-nm       # Network management widget
      
      # Theming
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.breeze-gtk
      
      # Multimedia
      libsForQt5.ffmpegthumbs    # Video thumbnails in Dolphin
    ];
  };
}