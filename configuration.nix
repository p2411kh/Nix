{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Загрузчик
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Сеть
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Часовой пояс
  time.timeZone = "Europe/Kiev";

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
  services.xserver.desktopManager.plasma6.enable = true;
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

  # Пользователь (ЗАМЕНИ p2411kh на своё имя)
  users.users.p2411kh = {
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

  # Системные пакеты
  environment.systemPackages = with pkgs; [
    nano
    git
    htop
    wget
  ];

  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Версия
  system.stateVersion = "26.05";
}
