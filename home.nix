{ config, pkgs, ... }:
{
  home.username = "koppanix";
  home.homeDirectory = "/home/koppanix";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    home-manager
  ];

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=11";
        dpi-aware = "yes";
      };

      colors-dark = {
        background = "1e1e2e";
        foreground = "cdd6f4";
      };

      scrollback = {
        lines = 10000;
      };
    };
  };

  programs.home-manager.enable = true;
}
