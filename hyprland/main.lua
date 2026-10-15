-- MAIN
-- Merged from main.conf (the dwindle/master/misc blocks that were duplicated
-- in the old file are collapsed into their final effective values).
-- https://wiki.hypr.land/Configuring/Variables/

hl.config({
    -- INPUT DEVICES
    input = {
        kb_layout = "us",
        repeat_rate = 30,
        repeat_delay = 425,
        follow_mouse = 1,
        mouse_refocus = true,
        float_switch_override_focus = 1,
        touchpad = {
            disable_while_typing = true,
            scroll_factor = 1.0,
            tap_to_click = true,
            natural_scroll = true,
            clickfinger_behavior = true,
        },
        special_fallthrough = true,
    },

    binds = {
        scroll_event_delay = 0,
        -- hide_special_on_workspace_change = true,
    },

    gestures = {
        -- `workspace_swipe`, `_fingers` were replaced by hl.gesture() below
        workspace_swipe_distance = 700,
        workspace_swipe_cancel_ratio = 0.2,
        workspace_swipe_min_speed_to_force = 5,
        workspace_swipe_direction_lock = true,
        workspace_swipe_direction_lock_threshold = 10,
        workspace_swipe_create_new = true,
    },

    -- GENERAL SETTINGS
    general = {
        -- Gaps and border
        gaps_in = 4,
        gaps_out = 5,
        gaps_workspaces = 50,
        border_size = 1,

        -- Fallback colors (RainbowBorders.sh overrides the active one at startup)
        col = {
            active_border = "rgba(0DB7D4FF)",
            inactive_border = "rgba(31313600)",
        },

        resize_on_border = true,
        no_focus_fallback = true,
        layout = "dwindle",

        allow_tearing = true, -- This just allows the `immediate` window rule to work
    },

    -- DWINDLE LAYOUT (`pseudotile` no longer exists)
    dwindle = {
        force_split = 0,
        preserve_split = true,
        smart_split = false,
        smart_resizing = true,
        special_scale_factor = 0.8,
        split_width_multiplier = 1.0,
        use_active_for_splits = true,
        default_split_ratio = 1.0,
    },

    -- MASTER LAYOUT (`inherit_fullscreen` no longer exists)
    master = {
        allow_small_split = false,
        special_scale_factor = 0.8,
        mfact = 0.55,
        new_on_top = false,
        orientation = "left",
    },

    -- MISC SETTINGS
    -- `vfr` moved to debug.vfr (default true); `new_window_takes_over_fullscreen = 2`
    -- is now misc.on_focus_under_fullscreen (default 2).
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        vrr = 1,
        mouse_move_enables_dpms = false,
        key_press_enables_dpms = false,
        layers_hog_keyboard_focus = true,
        focus_on_activate = false,
        mouse_move_focuses_monitor = true,

        animate_manual_resizes = false,
        animate_mouse_windowdragging = false,
        enable_swallow = false,
        swallow_regex = "(foot|ghostty|kitty|allacritty|Alacritty)",

        force_default_wallpaper = 0,
        allow_session_lock_restore = true,

        initial_workspace_tracking = false,
    },
})

-- 4-finger horizontal swipe switches workspaces (was gestures:workspace_swipe)
-- https://wiki.hypr.land/Configuring/Gestures/
hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
