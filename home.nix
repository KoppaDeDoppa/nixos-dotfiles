{ config, pkgs, ... }:
{
  home.username = "koppanix";
  home.homeDirectory = "/home/koppanix";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    home-manager
    kdePackages.plasma-integration
    kdePackages.breeze
    kdePackages.breeze-icons
    kdePackages.kconfig
    neovim
  ];

  qt = {
  enable = true;
  platformTheme.name = "kde";
  style.name = "breeze";
  };
  
  
  programs.fuzzel = {
  enable = true;
  settings = {
    main = {
      font = "JetBrainsMono Nerd Font:size=11";
      terminal = "${pkgs.foot}/bin/foot";
      layer = "overlay";
      lines = 12;
    };
    colors = {
      background = "1e1e2ee5";
      text = "cdd6f4ff";
      match = "89b4faff";
      selection = "313244ff";
      selection-text = "cdd6f4ff";
      selection-match = "89b4faff";
      border = "b4befeff";
    };
    border = {
      width = 2;
      radius = 0;
    };
   };
  };


  
  home.pointerCursor = {
  enable = true;
  gtk.enable = true;
  package = pkgs.kdePackages.breeze;
  name = "breeze_cursors";
  size = 24;
   
  hyprcursor.enable = true;
  };

 
  xdg.configFile.nvim.source = ./config/nvim/nvim.init;



  # Hyprland configs
  xdg.configFile = {
  "hypr/hyprland.lua".source  = ./config/hypr/hyprland.lua;
  "hypr/monitors.lua".source  = ./config/hypr/monitors.lua;
  "hypr/autostart.lua".source = ./config/hypr/autostart.lua;
  "hypr/appearance.lua".source = ./config/hypr/appearance.lua;
  "hypr/input.lua".source     = ./config/hypr/input.lua;
  "hypr/keybinds.lua".source  = ./config/hypr/keybinds.lua;
  "hypr/rules.lua".source     = ./config/hypr/rules.lua;
  };
  




  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=12";
        dpi-aware = "yes";
      };

      colors-dark = {
        background = "1a1b26";
        foreground = "c0caf5";
      };

      scrollback = {
        lines = 10000;
      };
    };
  };

  programs.waybar = {
  enable = true;

  settings = {
    mainBar = {
      layer = "top";
      position = "top";
      height = 25;

      "modules-left" = [ "hyprland/workspaces" ];
      "modules-center" = [ "clock" ];
      "modules-right" = [
        "backlight"
        "pulseaudio"
        "cpu"
        "temperature"
        "memory"
        "battery"
        "custom/power"
      ];

      "hyprland/workspaces" = {
        format = "{name}";
        "sort-by-number" = true;
        "persistent-workspaces" = {
          "*" = [ 1 2 3 4 5 ];
        };
      };

      clock = {
        timezone = "Europe/Oslo";
        format = "󰃭 {:%d/%m/%Y  %H:%M}";
        "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        interval = 1;
      };

      pulseaudio = {
        format = " {volume}% ";
        "format-muted" = " muted ";
        "on-click" = "pavucontrol";
      };

      cpu = {
        format = " {usage}% ";
        interval = 10;
      };

      temperature = {
        "hwmon-path" = "/sys/class/hwmon/hwmon6/temp1_input";
        "critical-threshold" = 80;
        format = " {temperatureC}°C ";
        "format-critical" = " {temperatureC}°C ";
      };

      memory = {
        format = " {used:0.1f}G ";
        interval = 30;
      };

      battery = {
        bat = "BAT0";
        states = {
          good = 80;
          warning = 30;
          critical = 15;
        };
        format = " {capacity}% ";
        "format-charging" = " {capacity}% ";
        "format-plugged" = " {capacity}% ";
      };

      "custom/power" = {
        format = " ⏻ ";
        tooltip = false;
        "on-click" = "wlogout &";
      };

      "custom/uptime" = {
        format = "{}";
        interval = 60;
        exec = "uptime -p";
      };

      backlight = {
        format = "{icon} {percent}%";
        "format-icons" = [ "" "" "" ];
      };

      network = {
        "format-wifi" = "󰤢 {bandwidthDownBits}";
        "format-ethernet" = "󰈀 {bandwidthDownBits}";
        "format-disconnected" = "󰤠 disconnected";
        interval = 5;
        tooltip = false;
      };

      tray = {
        "icon-size" = 14;
        spacing = 6;
      };
    };
  };

  style = ''
    * {
        font-family: JetBrainsMono Nerd Font;
        font-size: 12px;
        min-height: 0;
        padding: 0;
        margin: 0;
    }

    #waybar {
        background: #0d1117;
        color: #c6d0f5;
    }

    #workspaces {
        margin-left: 8px;
    }

    #workspaces button {
        color: #3d4e6b;
        background: transparent;
        padding: 0 5px;
        border-radius: 0;
    }

    #workspaces button.active {
        color: #4fc3f7;
        background: transparent;
    }

    #workspaces button:hover {
        background: transparent;
        color: #7b8fa6;
        border: none;
        box-shadow: none;
    }

    #clock {
        color: #7b8fa6;
        padding: 0 10px;
    }

    #pulseaudio,
    #cpu,
    #temperature,
    #backlight,
    #memory,
    #battery,
    #custom-power {
        padding: 0 10px;
        border-left: 1px solid #2d3748;
    }

    #pulseaudio {
        color: #ea999c;
        border-left: none;
    }

    #cpu {
        color: #4ec9a0;
    }

    #temperature {
        color: #fab387;
    }

    #temperature.critical {
        color: #ff0000;
    }

    #memory {
        color: #4ec9a0;
    }

    #battery {
        color: #e5c07b;
    }

    #battery.charging,
    #battery.plugged {
        color: #4ec9a0;
    }

    #battery.warning:not(.charging) {
        color: #fab387;
    }

    #battery.critical:not(.charging) {
        color: #e78284;
    }

    #tray {
        padding: 0 6px;
    }

    #custom-power {
        color: #e78284;
        padding: 0 10px 0 8px;
        margin-right: 4px;
    }
  '';
};


  programs.home-manager.enable = true;
}
