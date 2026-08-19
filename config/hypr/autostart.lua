-- autostart.lua
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
    hl.exec_cmd("foot")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("waybar")
    hl.exec_cmd("awww")
    hl.exec_cmd("waypaper --restore")
    hl.exec_cmd("mako")
end)
