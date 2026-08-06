{ config, pkgs, ... }:
{
  home.username = "koppanix";
  home.homeDirectory = "/home/koppanix";
  home.stateVersion = "26.05";

  # home.packages = with pkgs; [ ];
}
