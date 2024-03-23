{ ... }:

{
  imports = [
    ./services

    ../../modules
    ../../hardware/thinkpad.nix
  ];

  services.serial-reader.enable = true;
  services.f0runald.enable = true;

  services.logind.lidSwitch = "ignore";

  virtualisation.docker.enable = true;
  virtualisation.docker.logDriver = "json-file";

  nixpkgs.config.allowUnfree = true;
  services.zerotierone = {
    enable = true;
    joinNetworks = [ "856127940c577285" ];
  };

  networking.firewall.allowedTCPPorts = [
    22 # ssh
    2053 # shadowsocks control panel
    8388 # shadowsocks
    42777 # telegram-bot

    # gameservers:
    # 	minecraft
    25565 # minecraft
    8200 # bluemap
    4326 # web rcon
    4327 # web rcon ws
    19132 # minecraft bedrock
  ];
  networking.firewall.allowedUDPPorts = [
    19132 # minecraft bedrock
  ];

  networking = { hostName = "thinkpad"; };


  environment.systemPackages = with pkgs; [
    # mpg123
    # pipewire
    alsa-utils # Добавляем утилиты ALSA (включая aplay)
    pulseaudio
  ];

  sound.enable = true;
  # 
  #   security.rtkit.enable = true;

  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   pulse.enable = true;
  #   wireplumber.enable = true;
  # };

  # hardware.pulseaudio.enable = true;  # Включаем PulseAudio

  # sound.enable = true;  # Включаем поддержку звука в NixOS

  # Если вы используете звуковую карту или драйвер, которому нужны дополнительные настройки, укажите их здесь

  services.udev.packages =
    [ pkgs.alsa-utils ]; # Добавляем правила udev для ALSA

}
