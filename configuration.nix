{
  config,
  lib,
  pkgs,
  inputs,
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
  
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;
  hardware.alsa.enablePersistence = true;
  services.pipewire.enable = true;
  security.rtkit.enable = true;
  services.upower.enable = true;
  services.udev.packages = [ pkgs.dolphin-emu ];
  programs.gamemode.enable = true;

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 5;
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "metis";

  networking.networkmanager.enable = true;
  services.udisks2.enable = true;
  time.timeZone = "America/Los_Angeles";

  programs.niri.enable = true;
  services.greetd = {
    enable = true;
    settings = {
	default_session = {
	    command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
	};
    };
  };

  users.users.hayden = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
    ]; 
    packages = with pkgs; [
    ];
  };

  environment.systemPackages = with pkgs; [
     # Editors, language servers & dev tools
    neovim
    nixd
    pyright
    vim-language-server
    lua-language-server
    rust-analyzer
    lua
    luarocks
    nodejs
    zig
    git
    gnumake
    nil
    nixpkgs-fmt
    ripgrep
    gcc
    
    # Terminal & CLI utilities
    alacritty
    ranger
    fastfetch
    bat
    xclip
    tealdeer
    pulsemixer
    unzip
    wget
    feh
    btop
        
    # Security & networking
    mullvad-vpn
    keepassxc
    nmap

    # Browser
    librewolf

    # Wayland desktop (niri) & compositing
    quickshell
    swaybg
    xwayland-satellite
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
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
