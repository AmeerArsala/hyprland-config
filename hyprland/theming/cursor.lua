-- CURSOR
-- XCursor theme for Hyprland and everything it launches (set before clients start).
-- Bibata-Modern-Classic used to be the theme, but it's no longer installed, so
-- Hyprland fell back to a default cursor. To go back: install bibata-cursor-theme,
-- set THEME = "Bibata-Modern-Classic" here AND in ~/.config/gtk-3.0/settings.ini
-- (scripts/gtk.sh copies that file into gsettings at every login).
local THEME = "Catppuccin-Mocha-Dark-Cursors"
local SIZE  = "24"

hl.env("XCURSOR_THEME", THEME)
hl.env("XCURSOR_SIZE", SIZE)
