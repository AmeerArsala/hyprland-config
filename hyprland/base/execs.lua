-- AUTOSTART
-- See https://wiki.hypr.land/Configuring/Autostart/
--
-- `exec-once` -> hl.on("hyprland.start", ...)
-- `exec` (runs on every reload) -> also hooked to "config.reloaded"

local home        = os.getenv("HOME")
local scriptsDir  = home .. "/.config/hypr/scripts"
local UserScripts = home .. "/.config/hypr/UserScripts"
local qsConfig    = "ii"

local wallDIR   = home .. "/Pictures/wallpapers/bank"
local SwwwRandom = UserScripts .. "/WallpaperAutoChange.sh"

hl.on("hyprland.start", function()
    -- Startup XDG forcefully (helps for screen sharing)
    hl.exec_cmd("~/.config/hypr/scripts/xdg.sh")

    -- Startup (for XDPH)
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("sleep 1 && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP") -- Some fix idk
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- Wallpaper Startup
    -- swww was renamed to awww (the swww-daemon binary no longer exists here)
    hl.exec_cmd("command -v awww-daemon >/dev/null && awww-daemon --format xrgb || swww-daemon --format xrgb")
    hl.exec_cmd("hyprpaper") -- fast native wallpaper startup
    -- hl.exec_cmd(SwwwRandom .. " " .. wallDIR) -- random wallpaper switcher every 30 minutes

    -- Geolocation Compatibility + Screen Color Temperature
    hl.exec_cmd("/usr/lib/geoclue-2.0/demos/agent & gammastep")
    hl.exec_cmd("~/.config/hypr/hyprland/scripts/start_geoclue_agent.sh") -- ensure it's running

    -- Input method
    hl.exec_cmd("fcitx5")

    -- Authentication
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 || /usr/libexec/polkit-gnome-authentication-agent-1 || /usr/lib/polkit-gnome-authentication-agent-1")

    -- Lock Screen
    hl.exec_cmd("hypridle") -- start hypridle to start hyprlock

    -- Reload Hyprland Package Manager
    hl.exec_cmd("hyprpm reload")

    -- Load GTK settings (from: ml4w)
    hl.exec_cmd("~/.config/hypr/scripts/gtk.sh")

    -- Bar
    -- hl.exec_cmd("waybar &")
    hl.exec_cmd("nm-applet --indicator &")
    hl.exec_cmd("qs -c " .. qsConfig .. " &") -- quickshell instead of ags
    -- hl.exec_cmd("ags &")

    -- Notification daemon
    -- hl.exec_cmd("swaync &")
    -- hl.exec_cmd("dunst &")

    -- Audio
    hl.exec_cmd("easyeffects --gapplication-service")

    -- Clipboard Manager & History
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    -- Start pyprland daemon
    hl.exec_cmd("pypr &")

    -- Udiskie
    hl.exec_cmd("udiskie --no-automount --smart-tray") -- front-end that allows to manage removable media

    -- Start autostart cleanup
    hl.exec_cmd("~/.config/hypr/scripts/cleanup.sh")

    -- Plugins
    -- DISABLED: split-monitor-workspaces.so was built against an older Hyprland. Loading it on
    -- 0.56.x dies with "symbol lookup error ... undefined symbol _ZN14CConfigManager6reloadEv",
    -- which kills the whole compositor ~1s after start (start-hyprland then restarts it in
    -- --safe-mode). Rebuild it against the installed Hyprland headers before re-enabling:
    -- hl.exec_cmd("hyprctl plugin load ~/.config/hypr/.lib/split-monitor-workspaces/split-monitor-workspaces.so")

    -- Default workspace (was: hyprctl dispatch workspace 11)
    hl.dispatch(hl.dsp.focus({ workspace = "11" }))

    -- Rainbow borders (was a plain `exec`, i.e. also re-run on reload)
    hl.exec_cmd(UserScripts .. "/RainbowBorders.sh")
end)

-- `exec = ...` semantics: re-run on every config reload
hl.on("config.reloaded", function()
    hl.exec_cmd(UserScripts .. "/RainbowBorders.sh")
end)
