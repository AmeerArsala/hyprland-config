-- KEYBINDINGS
-- https://wiki.hypr.land/Configuring/Binds/
-- Dispatchers: https://wiki.hypr.land/Configuring/Dispatchers/
--
-- Old flag letters -> option table:
--   l = locked, e = repeating, r = release, n = non_consuming, m = mouse,
--   t = transparent, i = ignore_mods, d = description
--
-- All binds live in the "global" submap, like the old
--   exec = hyprctl dispatch submap global
--   submap = global   # "required for catchall to work"
-- The submap is entered on start and after every reload (see bottom).

local mainMod    = "SUPER"
local home       = os.getenv("HOME")
local launchRofi = home .. "/.config/rofi/scripts"
local runSlurp   = home .. "/.config/slurp/run.sh"
local qsConfig   = "ii"

-- size/move percentages of the monitor, for exec_cmd window rules
local function pct(w, h)
    return { "monitor_w*" .. w, "monitor_h*" .. h }
end

local function exec(cmd, rules) return hl.dsp.exec_cmd(cmd, rules) end

hl.define_submap("global", function()

    ----------------------------------------------------------------
    -- Shell (quickshell)
    -- These absolutely need to be on top, or they won't work consistently
    ----------------------------------------------------------------
    hl.bind("SUPER + Super_L",
        exec(launchRofi .. [[/launcher_t1 "style-6" || pkill fuzzel || fuzzel]])) -- Launcher (fallback)
    hl.bind("catchall", hl.dsp.global("quickshell:overviewToggleReleaseInterrupt"),
        { ignore_mods = true, transparent = true, non_consuming = true })
    hl.bind("CTRL + Super_L", hl.dsp.global("quickshell:overviewToggleReleaseInterrupt"))
    hl.bind(mainMod .. " + mouse:272", hl.dsp.global("quickshell:overviewToggleReleaseInterrupt"))
    hl.bind(mainMod .. " + mouse:273", hl.dsp.global("quickshell:overviewToggleReleaseInterrupt"))
    hl.bind(mainMod .. " + mouse:274", hl.dsp.global("quickshell:overviewToggleReleaseInterrupt"))
    hl.bind(mainMod .. " + mouse:275", hl.dsp.global("quickshell:overviewToggleReleaseInterrupt"))
    hl.bind(mainMod .. " + mouse:276", hl.dsp.global("quickshell:overviewToggleReleaseInterrupt"))
    hl.bind(mainMod .. " + mouse:277", hl.dsp.global("quickshell:overviewToggleReleaseInterrupt"))
    hl.bind(mainMod .. " + mouse_up", hl.dsp.global("quickshell:overviewToggleReleaseInterrupt"))
    hl.bind(mainMod .. " + mouse_down", hl.dsp.global("quickshell:overviewToggleReleaseInterrupt"))

    hl.bind("Super_L", hl.dsp.global("quickshell:workspaceNumber"), { ignore_mods = true, transparent = true })
    hl.bind(mainMod .. " + V", hl.dsp.global("quickshell:overviewClipboardToggle"),
        { description = "Clipboard history >> clipboard" })
    -- hl.bind(mainMod .. " + Period", hl.dsp.global("quickshell:overviewEmojiToggle"), { description = "Emoji >> clipboard" })
    hl.bind(mainMod .. " + SPACE", hl.dsp.global("quickshell:overviewToggle"),
        { description = "Toggle overview" })
    hl.bind(mainMod .. " + A", hl.dsp.global("quickshell:sidebarLeftToggle"),
        { description = "Toggle left sidebar" })
    hl.bind("SUPER + ALT + A", hl.dsp.global("quickshell:sidebarLeftToggleDetach"))
    hl.bind(mainMod .. " + SEMICOLON", hl.dsp.global("quickshell:sidebarRightToggle"),
        { description = "Toggle right sidebar" })
    hl.bind(mainMod .. " + Apostrophe", hl.dsp.global("quickshell:cheatsheetToggle"),
        { description = "Toggle cheatsheet" })
    hl.bind(mainMod .. " + K", hl.dsp.global("quickshell:oskToggle"),
        { description = "Toggle on-screen keyboard" })
    hl.bind(mainMod .. " + M", hl.dsp.global("quickshell:mediaControlsToggle"),
        { description = "Toggle media controls" })
    hl.bind("CTRL + SHIFT + ALT + Delete", hl.dsp.global("quickshell:sessionToggle"),
        { description = "Toggle session menu" })
    hl.bind(mainMod .. " + J", hl.dsp.global("quickshell:barToggle"),
        { description = "Toggle bar" })
    hl.bind("CTRL + SHIFT + ALT + Delete",
        exec("qs -c " .. qsConfig .. " ipc call TEST_ALIVE || pkill wlogout || wlogout -p layer-shell")) -- Session menu (fallback)
    hl.bind("SHIFT + SUPER + ALT + Slash",
        exec("qs -p ~/.config/quickshell/" .. qsConfig .. "/welcome.qml")) -- Launch welcome app

    hl.bind("XF86MonBrightnessUp",
        exec("qs -c " .. qsConfig .. " ipc call brightness increment || brightnessctl s 5%+"),
        { locked = true, repeating = true })
    hl.bind("XF86MonBrightnessDown",
        exec("qs -c " .. qsConfig .. " ipc call brightness decrement || brightnessctl s 5%-"),
        { locked = true, repeating = true })

    hl.bind("XF86AudioRaiseVolume", exec("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+"),
        { locked = true, repeating = true })
    hl.bind("XF86AudioLowerVolume", exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"),
        { locked = true, repeating = true })

    hl.bind("XF86AudioMute", exec("wpctl set-mute @DEFAULT_SINK@ toggle"), { locked = true }) -- mute volume
    hl.bind("SUPER + SHIFT + M", exec("wpctl set-mute @DEFAULT_SINK@ toggle"),
        { locked = true, description = "Toggle mute" }) -- mute volume
    hl.bind("ALT + XF86AudioMute", exec("wpctl set-mute @DEFAULT_SOURCE@ toggle"), { locked = true }) -- mute mic
    hl.bind("XF86AudioMicMute", exec("wpctl set-mute @DEFAULT_SOURCE@ toggle"), { locked = true }) -- mute mic
    hl.bind("CTRL + SUPER + T",
        exec("~/.config/quickshell/" .. qsConfig .. "/scripts/colors/switchwall.sh"),
        { description = "Change wallpaper" })
    hl.bind("CTRL + SUPER + R",
        exec("killall ags agsv1 gjs ydotool qs quickshell; qs -c " .. qsConfig .. " &")) -- Restart widgets

    ----------------------------------------------------------------
    -- Media
    ----------------------------------------------------------------
    hl.bind("XF86AudioNext",
        exec([[playerctl next || playerctl position `bc <<< "100 * $(playerctl metadata mpris:length) / 1000000 / 100"`]]),
        { locked = true })
    hl.bind("XF86AudioPrev", exec("playerctl previous"), { locked = true })
    hl.bind("XF86AudioPlay", exec("playerctl play-pause"), { locked = true })
    hl.bind("XF86AudioPause", exec("playerctl play-pause"), { locked = true })

    ----------------------------------------------------------------
    -- Launchers
    ----------------------------------------------------------------
    -- search windows
    hl.bind("SUPER + O", exec(launchRofi .. [[/launcher_t1 "style-6" "window"]], { float = true }))

    -- emoji search (fallback)
    hl.bind(mainMod .. " + Period", exec("~/.local/bin/fuzzel-emoji")) -- Pick emoji >> clipboard

    -- clipboard history (fallback)
    hl.bind(mainMod .. " + V",
        exec("qs -c " .. qsConfig .. " ipc call TEST_ALIVE || pkill fuzzel || cliphist list | fuzzel  --match-mode fzf --dmenu | cliphist decode | wl-copy"))

    -- Power Menu
    hl.bind("CTRL + ALT + delete", exec(launchRofi .. [[/powermenu_t1 "style-5"]], { float = true }))

    -- Task Manager (system monitor)
    hl.bind("CTRL + SHIFT + escape", exec("missioncenter", { float = true, size = pct(0.5, 0.5), center = true }))

    -- AI
    hl.bind("SUPER + SHIFT + ALT + mouse:273",
        exec("~/.config/hypr/scripts/ai/primary-buffer-query.sh"),
        { description = "Generate AI summary for selected text" })

    -- pyprland
    hl.bind("ALT + SHIFT + T", exec("pypr toggle term")) -- Dropdown terminal
    hl.bind(mainMod .. " + Z", exec("pypr zoom")) -- Toggle Zoom

    -- OCR: screen snip to text >> clipboard
    hl.bind("F8",
        exec([[grim -g "$(]] .. runSlurp .. [[ $SLURP_ARGS)" "tmp.png" && tesseract -l eng "tmp.png" - | wl-copy && rm "tmp.png"]]),
        { locked = true })

    -- Screenshot: screen snip >> edit
    hl.bind("F9", exec([[grim -g "$(]] .. runSlurp .. [[)" - | swappy -f -]]), { locked = true })

    -- fullscreen screenshot
    hl.bind(mainMod .. " + F9",
        exec("grim - | wl-copy && notify-send 'Screenshot Captured' 'Copied to Clipboard'"),
        { locked = true }) -- Screenshot >> clipboard
    -- NOTE: was `$mainMod+S, F9` ("S" is not a modifier, so it was effectively a second SUPER+F9). SHIFT is the evident intent.
    hl.bind("SUPER + SHIFT + F9",
        exec([[mkdir -p ~/Pictures/Screenshots && ~/.config/ags/scripts/grimblast.sh copysave screen ~/Pictures/Screenshots/Screenshot_"$(date '+%Y-%m-%d_%H.%M.%S')".png && notify-send 'Screenshot Captured' "saved to ~/Pictures/Screenshots/Screenshot_$(date '+%Y-%m-%d_%H.%M.%S').png"]]),
        { locked = true }) -- Screenshot >> clipboard & file

    -- Recording
    hl.bind("F10", exec("~/.config/ags/scripts/record-script.sh"), { locked = true }) -- Record region (no sound)
    hl.bind("SHIFT + F10", exec("~/.config/ags/scripts/record-script.sh --sound"), { locked = true }) -- Record region (with sound)

    -- fullscreen recording
    hl.bind(mainMod .. " + F10", exec("~/.config/ags/scripts/record-script.sh --fullscreen"), { locked = true }) -- no sound
    hl.bind(mainMod .. " + SHIFT + F10", exec("~/.config/ags/scripts/record-script.sh --fullscreen-sound")) -- with sound

    -- Color Picker
    hl.bind(mainMod .. " + C", exec("hyprpicker - | wl-copy"))

    -- Extras
    hl.bind(mainMod .. " + F1", exec("nwg-shell-help"))
    hl.bind(mainMod .. " + SHIFT + R", exec("hyprctl reload"))

    ----------------------------------------------------------------
    -- Layouts
    ----------------------------------------------------------------
    hl.bind(mainMod .. " + Tab", hl.dsp.layout("togglesplit"))      -- (dwindle)
    hl.bind(mainMod .. " + P",   hl.dsp.window.pseudo())            -- (dwindle)
    hl.bind(mainMod .. " + A",   hl.dsp.layout("cycleprev"))        -- (master)
    hl.bind(mainMod .. " + S",   hl.dsp.layout("swapwithmaster"))   -- (master)
    hl.bind(mainMod .. " + D",   hl.dsp.layout("cyclenext"))        -- (master)

    ----------------------------------------------------------------
    -- Window actions
    ----------------------------------------------------------------
    hl.bind(mainMod .. " + I",       hl.dsp.window.pin())
    hl.bind("ALT + F4",              hl.dsp.window.close())
    hl.bind(mainMod .. " + Page_Up", hl.dsp.window.fullscreen({ mode = "maximized" }))
    hl.bind(mainMod .. " + F",       hl.dsp.window.fullscreen({ mode = "fullscreen" }))
    hl.bind(mainMod .. " + RETURN",  hl.dsp.window.float({ action = "toggle" }))

    -- Move focus
    hl.bind("ALT + left",  hl.dsp.focus({ direction = "left" }))
    hl.bind("ALT + right", hl.dsp.focus({ direction = "right" }))
    hl.bind("ALT + up",    hl.dsp.focus({ direction = "up" }))
    hl.bind("ALT + down",  hl.dsp.focus({ direction = "down" }))

    ----------------------------------------------------------------
    -- Switch workspaces
    -- ALT+SHIFT+N focuses workspace N (HDMI-A-1) and then N+10 (DP-1),
    -- so both monitors switch together (both binds run, in order).
    ----------------------------------------------------------------
    for i = 1, 10 do
        local key = i % 10 -- 10 maps to key 0
        hl.bind("ALT + SHIFT + " .. key, hl.dsp.focus({ workspace = tostring(i) }))
        hl.bind("ALT + SHIFT + " .. key, hl.dsp.focus({ workspace = tostring(i + 10) }))
    end

    hl.bind("ALT + SHIFT + right", hl.dsp.focus({ workspace = "r+1" }))
    hl.bind("ALT + SHIFT + left",  hl.dsp.focus({ workspace = "r-1" }))

    hl.bind("ALT + SHIFT + equal", hl.dsp.focus({ monitor = "-1" }))
    hl.bind("ALT + SHIFT + minus", hl.dsp.focus({ monitor = "+1" }))

    -- aliases for the above
    hl.bind("ALT + equal", hl.dsp.focus({ monitor = "-1" }))
    hl.bind("ALT + minus", hl.dsp.focus({ monitor = "+1" }))

    -- SCROLL THROUGH EXISTING WORKSPACES with mod + scroll
    hl.bind("ALT + SHIFT + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
    hl.bind("ALT + SHIFT + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

    ----------------------------------------------------------------
    -- Move windows
    ----------------------------------------------------------------
    hl.bind(mainMod .. " + left",  hl.dsp.window.move({ direction = "left" }))
    hl.bind(mainMod .. " + right", hl.dsp.window.move({ direction = "right" }))
    hl.bind(mainMod .. " + up",    hl.dsp.window.move({ direction = "up" }))
    hl.bind(mainMod .. " + down",  hl.dsp.window.move({ direction = "down" }))

    hl.bind(mainMod .. " + SHIFT + equal", hl.dsp.window.move({ monitor = "-1" }))
    hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.window.move({ monitor = "+1" }))

    hl.bind(mainMod .. " + ALT + SHIFT + equal", hl.dsp.window.move({ monitor = "-1", follow = false }))
    hl.bind(mainMod .. " + ALT + SHIFT + minus", hl.dsp.window.move({ monitor = "+1", follow = false }))

    -- MOVE/RESIZE WINDOWS with mainMod + LMB/RMB and dragging
    hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true }) -- left click
    hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- right click

    -- resizeactive with percentages (of the window's current size). hl.dsp.window.resize only
    -- takes numbers, so compute the pixel delta when the key is pressed.
    local function resize_pct(px, py)
        return function()
            local w = hl.get_active_window()
            if not w then return end
            hl.dispatch(hl.dsp.window.resize({
                x = math.floor(w.size.x * px / 100),
                y = math.floor(w.size.y * py / 100),
                relative = true,
            }))
        end
    end
    hl.bind(mainMod .. " + H", resize_pct(-20, 0))
    hl.bind(mainMod .. " + L", resize_pct(20, 0))
    hl.bind(mainMod .. " + K", resize_pct(0, -20))
    hl.bind(mainMod .. " + J", resize_pct(0, 20))

    -- Move active window to a workspace (11-20 live on DP-1)
    for i = 1, 10 do
        local key = i % 10
        hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = tostring(i + 10) }))
    end

    hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ workspace = "-1" }))
    hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ workspace = "+1" }))

    -- Same as above, but doesn't switch to the workspace.
    -- (use right alt for this in order to train your brain correctly)
    for i = 1, 10 do
        local key = i % 10
        hl.bind(mainMod .. " + ALT + SHIFT + " .. key,
            hl.dsp.window.move({ workspace = tostring(i + 10), follow = false }))
    end

    hl.bind(mainMod .. " + ALT + SHIFT + left",  hl.dsp.window.move({ workspace = "-1", follow = false }))
    hl.bind(mainMod .. " + ALT + SHIFT + right", hl.dsp.window.move({ workspace = "+1", follow = false }))

    -- Special workspace
    hl.bind("ALT + SHIFT + TAB", hl.dsp.workspace.toggle_special(""))
    hl.bind("ALT + TAB",         hl.dsp.workspace.toggle_special("")) -- alias for the above
    hl.bind(mainMod .. " + SHIFT + TAB",       hl.dsp.window.move({ workspace = "special" }))
    hl.bind(mainMod .. " + ALT + SHIFT + TAB", hl.dsp.window.move({ workspace = "special", follow = false })) -- right alt

    -- Move workspaces
    hl.bind("CTRL + ALT + SHIFT + equal", hl.dsp.workspace.move({ monitor = "-1" }))
    hl.bind("CTRL + ALT + SHIFT + minus", hl.dsp.workspace.move({ monitor = "+1" }))

    ----------------------------------------------------------------
    -- Apps
    ----------------------------------------------------------------
    hl.bind(mainMod .. " + B", exec("MOZ_ENABLE_WAYLAND=1 zen-browser"))

    hl.bind(mainMod .. " + SHIFT + E", exec("nautilus --new-window", { float = true, center = true }))
    hl.bind(mainMod .. " + E",         exec("nautilus --new-window"))

    hl.bind(mainMod .. " + SHIFT + slash", exec("kitty", { float = true, size = pct(0.625, 0.625), center = true }))
    hl.bind(mainMod .. " + slash",         exec("ghostty", { tile = true }))

    hl.bind(mainMod .. " + comma", exec("blend-settings", { float = true }))
end)

-- Enter the "global" submap on start and after every reload
-- (was: `exec = hyprctl dispatch submap global`).
local function enter_global()
    hl.dispatch(hl.dsp.submap("global"))
end
hl.on("hyprland.start", enter_global)
hl.on("config.reloaded", enter_global)
