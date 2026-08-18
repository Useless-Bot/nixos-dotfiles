{
  config,
  lib,
  pkgs,
  inputs,
  ly-balatro,
  ...
}:
{

  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.alsa.enablePersistence = true;
  services.pipewire.enable = true;
  services.upower.enable = true;

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 5;
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "metis"; # Define your hostname.

  networking.networkmanager.enable = true;
  services.udisks2.enable = true;
  time.timeZone = "America/Los_Angeles";

  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
  };

  programs.niri.enable = true;
  services.displayManager.ly.package = lib.mkForce ly-balatro.packages.${pkgs.stdenv.hostPlatform.system}.default;

  services.displayManager.ly.settings = {
    animation = "balatro";
    full_color = true;
    clock = "%H:%M";

    balatro_col1 = "0x00DE443B";
    balatro_col2 = "0x000055B4";
    balatro_col3 = "0x20000000";
  };

  services.picom = {
    enable = true;
    backend = "glx";
    fade = true;
  };

  users.users.hayden = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
    ]; 
    packages = with pkgs; [
      tree
      discord
      steam
      burpsuite
    ];
  };

  environment.systemPackages = with pkgs; [
    neovim
    pfetch
    wget
    alacritty
    git
    ranger
    feh
    librewolf
    mullvad-vpn
    picom
    bat
    xclip
    tealdeer
    keepassxc
    nmap
    pulsemixer
    luarocks
    gnumake
    unzip
    zig
    quickshell
    swaybg
    xwayland-satellite
    tree-sitter
    inputs.noctalia.packages.${stdenv.hostPlatform.system}.default
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "26.05";

}
