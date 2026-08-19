-- monitors.lua
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

-- Laptop screen (left)
hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@60",
    position = "-1920x0",
    scale    = 1.0,
})

-- AOC monitor (main, in front)
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@60",
    position = "0x0",
    scale    = 1.0,
})