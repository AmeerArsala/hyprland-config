-- See https://wiki.hypr.land/Configuring/Environment-variables/

hl.env("XCURSOR_SIZE", "24")

---- end-4 ----

-- Input method
-- See https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland
hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")
-- hl.env("GTK_IM_MODULE", "wayland")   -- Crashes electron apps in xwayland
-- hl.env("GTK_IM_MODULE", "fcitx")     -- Gtk apps no longer require this to work with fcitx5
hl.env("SDL_IM_MODULE", "fcitx")
hl.env("GLFW_IM_MODULE", "ibus")
hl.env("INPUT_METHOD", "fcitx")

-- firefox
hl.env("MOZ_ENABLE_WAYLAND", "1")

-- for flickering electron apps (may help w/ electron > 28 apps)
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- Themes
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct") -- was qt5ct, then overridden by qt6ct (JaKooLit); qt6ct won
hl.env("QT_STYLE_OVERRIDE", "kvantum")

-- JaKooLit
hl.env("QT_SCALE_FACTOR", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
-- hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

-- Virtual environment
hl.env("ILLOGICAL_IMPULSE_VIRTUAL_ENV", "~/.local/state/quickshell/.venv")

-- hl.env("WLR_NO_HARDWARE_CURSORS", "1")
-- hl.env("WLR_DRM_NO_ATOMIC", "1")

---- JaKooLit ----

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")

hl.env("CLUTTER_BACKEND", "wayland")
hl.env("GDK_BACKEND", "wayland,x11")

-- xwayland apps scale fix (useful if you are use monitor scaling)
-- toolkit-specific scale
hl.env("GDK_SCALE", "1")

-- For hyprland plugins
hl.env("HYPRLAND_HEADERS", os.getenv("HOME") .. "/.config/hypr")
