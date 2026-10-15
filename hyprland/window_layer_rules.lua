-- WINDOW & LAYER RULES
-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- NOTE: to figure out classes do `hyprctl clients`
--
-- Rules are evaluated top to bottom; the LAST matching rule wins (same as before).
-- `size`/`move` percentages became expressions: 80% -> "monitor_w*0.8".

local function wr(match, fx)
    fx.match = match
    hl.window_rule(fx)
end

local function pct(w, h) -- percentages of the monitor, for size/move
    return { "monitor_w*" .. w, "monitor_h*" .. h }
end

wr({ focus = true }, { border_size = 2 })

------------------------------------------------------------------
-- Browsers / terminals
------------------------------------------------------------------
for _, c in ipairs({ "firefox", "LibreWolf", "zen" }) do
    wr({ class = "^(" .. c .. ")$" }, { opacity = "0.90 0.90", size = pct(0.8, 0.8) })
end

wr({ class = "^(kitty)$" }, { opacity = "0.95 0.95" })
wr({ class = "^(com.mitchellh.ghostty)$" }, { opacity = "0.95 0.95" })
for _, c in ipairs({ "kitty", "com.mitchellh.ghostty" }) do
    for _, t in ipairs({ "top", "btop", "htop" }) do
        wr({ class = "^(" .. c .. ")$", title = "^(" .. t .. ")$" }, { float = true })
    end
end

wr({ class = "^(nautilus)$" }, { float = true })

------------------------------------------------------------------
-- prasanthrangan: opacity
------------------------------------------------------------------
local opacity = {
    { "Brave-browser", "0.90 0.90" },
    { "code-oss", "0.80 0.80" },
    { "Code", "0.80 0.80" },
    { "code-url-handler", "0.80 0.80" },
    { "code-insiders-url-handler", "0.80 0.80" },
    { "org.kde.dolphin", "0.95 0.95" },
    { "org.gnome.Nautilus", "0.95 0.95" },
    { "org.kde.ark", "0.80 0.80" },
    { "nwg-look", "1.0 1.0" },
    { "qt5ct", "0.80 0.80" },
    { "qt6ct", "0.80 0.80" },
    { "kvantummanager", "0.80 0.80" },
    { "org.pulseaudio.pavucontrol", "0.95 0.95" },
    { "blueman-manager", "0.80 0.70" },
    { "nm-applet", "0.80 0.70" },
    { "nm-connection-editor", "0.80 0.70" },
    { "org.kde.polkit-kde-authentication-agent-1", "0.80 0.70" },
    { "polkit-gnome-authentication-agent-1", "0.80 0.70" },
    { "org.freedesktop.impl.portal.desktop.gtk", "0.80 0.70" },
    { "org.freedesktop.impl.portal.desktop.hyprland", "0.80 0.70" },
    { "[Ss]team", "0.70 0.70" },
    { "steamwebhelper", "0.70 0.70" },
    { "[Ss]potify", "0.70 0.70" },
    { "com.github.rafostar.Clapper", "0.90 0.90" },       -- Clapper-Gtk
    { "com.github.tchx84.Flatseal", "0.80 0.80" },        -- Flatseal-Gtk
    { "hu.kramo.Cartridges", "0.80 0.80" },               -- Cartridges-Gtk
    { "com.obsproject.Studio", "0.80 0.80" },             -- Obs-Qt
    { "gnome-boxes", "0.80 0.80" },                       -- Boxes-Gtk
    { "vesktop", "0.90 0.90" },                           -- Vesktop
    { "discord", "0.90 0.90" },                           -- Discord-Electron
    { "WebCord", "0.90 0.90" },                           -- WebCord-Electron
    { "ArmCord", "0.90 0.90" },                           -- ArmCord-Electron
    { "app.drey.Warp", "0.80 0.80" },                     -- Warp-Gtk
    { "net.davidotek.pupgui2", "0.80 0.80" },             -- ProtonUp-Qt
    { "yad", "0.80 0.80" },                               -- Protontricks-Gtk
    { "Signal", "0.80 0.80" },                            -- Signal-Gtk
    { "io.github.alainm23.planify", "0.80 0.80" },        -- planify-Gtk
    { "io.gitlab.theevilskeleton.Upscaler", "0.80 0.80" },-- Upscaler-Gtk
    { "com.github.unrud.VideoDownloader", "0.80 0.80" },  -- VideoDownloader-Gtk
    { "io.gitlab.adhami3310.Impression", "0.80 0.80" },   -- Impression-Gtk
    { "io.missioncenter.MissionCenter", "0.99 0.99" },    -- MissionCenter-Gtk
    { "io.github.flattool.Warehouse", "0.80 0.80" },      -- Warehouse-Gtk
    { "rofi", "0.80 0.80" },
}
for _, o in ipairs(opacity) do
    wr({ class = "^(" .. o[1] .. ")$" }, { opacity = o[2] })
end
wr({ initial_title = "^(Spotify Free)$" }, { opacity = "0.70 0.70" })
wr({ initial_title = "^(Spotify Premium)$" }, { opacity = "0.70 0.70" })

------------------------------------------------------------------
-- prasanthrangan: floating
------------------------------------------------------------------
wr({ class = "^(org.kde.dolphin)$", title = "^(Progress Dialog — Dolphin)$" }, { float = true })
wr({ class = "^(org.kde.dolphin)$", title = "^(Copying — Dolphin)$" }, { float = true })
wr({ title = "^(About Mozilla Firefox)$" }, { float = true })
wr({ class = "^(firefox)$", title = "^(Picture-in-Picture)$" }, { float = true })
wr({ class = "^(firefox)$", title = "^(Library)$" }, { float = true })
wr({ class = "^(zen-browser)$", title = "^(Picture-in-Picture)$" }, { float = true })
wr({ class = "^(zen-browser)$", title = "^(Library)$" }, { float = true })

local float_classes = {
    "vlc", "kvantummanager", "qt5ct", "qt6ct", "nwg-look", "org.kde.ark",
    "org.pulseaudio.pavucontrol", "blueman-manager", "nm-applet",
    "nm-connection-editor", "org.kde.polkit-kde-authentication-agent-1",
    "Signal",                                -- Signal-Gtk
    "com.github.rafostar.Clapper",           -- Clapper-Gtk
    "app.drey.Warp",                         -- Warp-Gtk
    "net.davidotek.pupgui2",                 -- ProtonUp-Qt
    "yad",                                   -- Protontricks-Gtk
    "eog",                                   -- Imageviewer-Gtk
    "io.github.alainm23.planify",            -- planify-Gtk
    "io.gitlab.theevilskeleton.Upscaler",    -- Upscaler-Gtk
    "com.github.unrud.VideoDownloader",      -- VideoDownloader-Gtk
    "io.gitlab.adhami3310.Impression",       -- Impression-Gtk
    "io.missioncenter.MissionCenter",        -- MissionCenter-Gtk
}
for _, c in ipairs(float_classes) do
    wr({ class = "^(" .. c .. ")$" }, { float = true })
end

------------------------------------------------------------------
-- end-4
------------------------------------------------------------------
-- Disable blur for xwayland context menus
wr({ class = "^()$", title = "^()$" }, { no_blur = true })

-- Floating
wr({ class = [[^(blueberry\.py)$]] }, { float = true })
wr({ class = "^(guifetch)$" }, { float = true }) -- FlafyDev/guifetch
for _, c in ipairs({ "pavucontrol", "org.pulseaudio.pavucontrol", "nm-connection-editor" }) do
    wr({ class = "^(" .. c .. ")$" }, { float = true, size = pct(0.45, 0.45), center = true })
end
wr({ class = ".*plasmawindowed.*" }, { float = true })
wr({ class = "kcm_.*" }, { float = true })
wr({ class = ".*bluedevilwizard" }, { float = true })
wr({ title = ".*Welcome" }, { float = true })
wr({ title = "^(illogical-impulse Settings)$" }, { float = true })
wr({ class = "org.freedesktop.impl.portal.desktop.kde" }, { float = true })
wr({ class = "^(Zotero)$" }, { float = true, size = pct(0.45, 0.45) })

-- Move
-- kde-material-you-colors spawns a window when changing dark/light theme. This is to make sure it doesn't interfere at all.
wr({ class = "^(plasma-changeicons)$" }, { float = true, no_initial_focus = true, move = { 999999, 999999 } })
-- stupid dolphin copy
wr({ title = "^(Copying — Dolphin)$" }, { move = { 40, 80 } })

-- Tiling
wr({ class = [[^dev\.warp\.Warp$]] }, { tile = true })

-- Picture-in-Picture
wr({ title = [[^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$]] }, {
    float = true,
    keep_aspect_ratio = true,
    move = pct(0.73, 0.72),
    size = pct(0.25, 0.25),
    pin = true,
})

-- Dialog windows - float+center these windows.
for _, t in ipairs({
    "^(Open File)(.*)$", "^(Select a File)(.*)$", "^(Choose wallpaper)(.*)$",
    "^(Open Folder)(.*)$", "^(Save As)(.*)$", "^(Library)(.*)$",
    "^(File Upload)(.*)$", "^(.*)(wants to save)$", "^(.*)(wants to open)$",
}) do
    wr({ title = t }, { center = true, float = true })
end

-- --- Tearing ---
wr({ title = [[.*\.exe]] }, { immediate = true })
wr({ title = ".*minecraft.*" }, { immediate = true })
wr({ class = "^(steam_app).*" }, { immediate = true })

-- No shadow for tiled windows
wr({ float = false }, { no_shadow = true })


------------------------------------------------------------------
-- LAYER RULES
-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/#layer-rules
-- blurpopups -> blur_popups, ignorezero -> ignore_alpha = 0,
-- noanim -> no_anim, xray 1 -> xray = true
------------------------------------------------------------------
local function lr(namespace, fx)
    fx.match = { namespace = namespace }
    hl.layer_rule(fx)
end

-- prasanthrangan
lr("rofi", { blur = true })
lr("rofi", { ignore_alpha = 0 })
lr("rofi", { no_anim = true })
lr("~/.local/bin/fuzzel-emoji", { no_anim = true })
lr("fuzzel-emoji", { no_anim = true })
lr("fuzzel", { no_anim = true })
lr("sed", { no_anim = true })

lr("notifications", { blur = true })
lr("notifications", { ignore_alpha = 0 })
lr("swaync-notification-window", { blur = true })
lr("swaync-notification-window", { ignore_alpha = 0 })
lr("swaync-control-center", { blur = true })
lr("swaync-control-center", { ignore_alpha = 0 })
lr("logout_dialog", { blur = true })

-- end-4
lr(".*", { xray = true })
lr("walker", { no_anim = true })
lr("selection", { no_anim = true })
lr("overview", { no_anim = true })
lr("anyrun", { no_anim = true })
lr("indicator.*", { no_anim = true })
lr("osk", { no_anim = true })
lr("hyprpicker", { no_anim = true })
lr("shell:*", { blur = true })
lr("shell:*", { ignore_alpha = 0.6 })

lr("noanim", { no_anim = true })
lr("gtk-layer-shell", { blur = true })
lr("gtk-layer-shell", { ignore_alpha = 0 })
lr("launcher", { blur = true })
lr("launcher", { ignore_alpha = 0.5 })
lr("notifications", { blur = true })
lr("notifications", { ignore_alpha = 0.69 })

-- ags
lr("sideleft.*", { animation = "slide left" })
lr("sideright.*", { animation = "slide right" })
lr("session", { blur = true })

for _, ns in ipairs({
    "bar", "corner.*", "dock", "indicator.*", "overview", "cheatsheet",
    "sideright", "sideleft", "indicator*", "osk",
}) do
    lr(ns, { blur = true })
    lr(ns, { ignore_alpha = 0.6 })
end

-- Quickshell
lr("quickshell:.*", { blur_popups = true })
lr("quickshell:.*", { blur = true })
lr("quickshell:.*", { ignore_alpha = 0.79 })
lr("quickshell:bar", { animation = "slide top" })
lr("quickshell:screenCorners", { animation = "fade" })
lr("quickshell:sidebarRight", { animation = "slide right" })
lr("quickshell:sidebarLeft", { animation = "slide left" })
lr("quickshell:osk", { animation = "slide bottom" })
lr("quickshell:dock", { animation = "slide bottom" })
lr("quickshell:session", { blur = true })
lr("quickshell:session", { no_anim = true })
lr("quickshell:session", { ignore_alpha = 0 })
lr("quickshell:notificationPopup", { animation = "fade" })
lr("quickshell:backgroundWidgets", { blur = true })
lr("quickshell:backgroundWidgets", { ignore_alpha = 0.05 })
lr("quickshell:screenshot", { no_anim = true })
lr("quickshell:screenCorners", { animation = "popin 120%" })
lr("quickshell:lockWindowPusher", { no_anim = true })

-- Launchers need to be FAST
lr("quickshell:overview", { no_anim = true })
lr("gtk4-layer-shell", { no_anim = true })

-- outfoxxed's stuff
lr("shell:bar", { blur = true })
lr("shell:bar", { ignore_alpha = 0 })
lr("shell:notifications", { blur = true })
lr("shell:notifications", { ignore_alpha = 0.1 })
