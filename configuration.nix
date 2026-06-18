{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix  # Auto-generated hardware config
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "your-hostname";  # Set your system's hostname
  time.timeZone = "Region/City";          # Timezone config

  # User account setup
  users.users.yourusername = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # sudo + networking access
    packages = with pkgs; [
      firefox
      vscode
      # add your user-specific packages here
    ];
  };

  # KDE Plasma setup
  services.xserver.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.displayManager.sddm.enable = true;

  # Enable sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    git
    htop
    # add more system-wide packages here
  ];

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable OpenSSH if needed
  services.openssh.enable = true;

  system.stateVersion = "24.05"; # Match this to your installed NixOS version
}
