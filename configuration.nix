{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];   # сгенерируется автоматически

  # ---- Загрузчик ----
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ---- Сеть ----
  networking.hostName = "nixos";          # поменяй на своё имя
  networking.networkmanager.enable = true;

  # ---- Часовой пояс и локализация ----
  time.timeZone = "Europe/Kiev";          # поменяй под свой регион
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

  # ---- Консоль ----
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # ---- KDE Plasma 6 (Wayland по умолчанию) ----
  services.xserver.enable = true;
  services.xserver.xkb.layout = "us,ru";
  services.xserver.xkb.options = "grp:alt_shift_toggle";
  services.xserver.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;

  # ---- Звук (PipeWire) ----
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };
  # hardware.pulseaudio.enable = true;   # НЕ ИСПОЛЬЗУЙ, если включён PipeWire

  # ---- Печать ----
  services.printing.enable = true;

  # ---- Тачпад ----
  services.libinput.enable = true;

  # ---- OpenSSH (опционально) ----
  services.openssh.enable = true;

  # ---- Пользователь (замени "p2411kh" на своё имя) ----
  users.users.p2411kh = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      firefox
      vscode
    ];
  };

  # ---- Sudo без пароля (опционально) ----
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

  # ---- Пакеты для всей системы ----
  environment.systemPackages = with pkgs; [
    nano
    git
    htop
    wget
    # добавь сюда свои системные пакеты
  ];

  # ---- Включение Flakes ----
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # ---- Версия системы (оставь 26.05) ----
  system.stateVersion = "26.05";
}
