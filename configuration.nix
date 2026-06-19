{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Загрузчик
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev"; # для UEFI
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true; # полезно при проблемах с NVRAM


    # Plymouth (заставка)
  boot.plymouth.enable = true;
  boot.plymouth.theme = "breeze";   # или "bgrt", "spinner", "fade-in"
  boot.kernelParams = [ "quiet" "splash" ];

  # Сеть
  networking.hostName = "user-nixos";
  networking.networkmanager.enable = true;

  # Часовой пояс
  time.timeZone = "Europe/Vienna";

  # Локализация (русский язык)
  i18n.defaultLocale = "ru_RU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Консоль
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # KDE Plasma 6
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.xserver.xkb.layout = "us,ru";
  services.xserver.xkb.options = "grp:alt_shift_toggle";

  # Звук (PipeWire)
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  # Дополнительные сервисы
  services.printing.enable = true;
  services.libinput.enable = true;

  # Разрешить unfree пакеты (нужно для некоторых программ)
  nixpkgs.config.allowUnfree = true;

  services.flatpak.enable = true;
  programs.fish.enable = true;

  # Пользователь (ЗАМЕНИ p2411kh на своё имя)
  users.users.p2411kh = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      firefox
    ];
  };

  # Sudo без пароля
  security.sudo.extraRules = [
    {
      groups = [ "wheel" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];


  hardware.opengl = {
  enable = true;
  driSupport32Bit = true;
};


  # Системные пакеты
  environment.systemPackages = with pkgs; [
    nano
    git
    htop
    wget
    fish
    kitty
    firefox
    vim
    fastfetch
    cava
    steam
    steam-run
    flatpak
    discord
    telegram-desktop
    pywal
    lsd
    bat
    zoxide
    lazygit
    neovim
    tldr
  ];




  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Версия
  system.stateVersion = "26.05";
}
