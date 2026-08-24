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
  
  networking.hostName = "nixos"; # Define your hostname.
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

  # Automatic updating
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  # Automatic cleanup
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 10d";
  nix.settings.auto-optimise-store = true;


  # Virt-manager / KVM/QEMU
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  
  networking.firewall.trustedInterfaces = [ "virbr0" ];



  # Configure console keymap
  console.keyMap = "no";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."koppanix" = {
    isNormalUser = true;
    description = "koppanix";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = true;

  environment.pathsToLink = [ "/share/color-schemes" ];

  # programs.waybar.enable = true;  
  
  programs.hyprland = {
  enable = true;
  xwayland.enable = true;
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
 

 hardware.graphics = {
 	enable = true;
	enable32Bit = true;
 };
 
 programs.steam = {
   enable = true;
   dedicatedServer.openFirewall = false;
   gamescopeSession.enable = true;
 };

 programs.gamemode.enable = true;

 security.rtkit.enable = true;
  services.pipewire = {
    enable = true; # if not already enabled
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment the following
    #jack.enable = true;
  };


 services.gvfs.enable = true;


 # XDG portal...
 xdg.portal.enable = true;
 xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    git
    fastfetch
    alacritty
    # foot
    kitty
    # waybar
    grim
    slurp
    steam
    awww
    wlogout
    dnsmasq  #Pkgs for KVM/QEMU network to work
    waypaper
    kdePackages.kate
    kdePackages.dolphin
    kdePackages.polkit-kde-agent-1
  ];

  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];  


  system.stateVersion = "26.05";

}
