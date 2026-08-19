# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
 
  # Testing now
  
  networking.hostName = "nixos-btw"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "no";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "no";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."koppanix" = {
    isNormalUser = true;
    description = "koppanix";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = true;

  # programs.waybar.enable = true;  
  
  programs.hyprland = {
  enable = true;
  withUWSM = true;
  };

  services.greetd = {
  enable = true;
  settings = {
    default_session = { 
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --cmd 'uwsm start hyprland-uwsm.desktop'";
      user = "greeter";
      };
    };
  };

 hardware.graphics.enable = true;

 services.gvfs.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    git
    neovim
    vim
    fastfetch
    alacritty
   # foot
    kitty
    waybar
    grim
    slurp
    awww
    waypaper
    kdePackages.kate
    kdePackages.dolphin
    kdePackages.polkit-kde-agent-1
  ];

  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];  


  system.stateVersion = "26.05";

}
