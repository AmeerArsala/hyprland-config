-- THEME (end-4)
-- Merged from theming/theme.conf + theming/colors.conf.
-- cursor.conf and font.conf contained only commented-out lines.
-- https://wiki.hypr.land/Configuring/Variables/

hl.config({
    decoration = {
        rounding = 18,

        blur = {
            enabled            = true,
            xray               = true,
            new_optimizations  = true,
            -- NOTE: theme.conf set size = 14 / special = false, but a second `blur`
            -- block later in the same file overrode them (special workspace blur).
            -- This keeps the effective values that were actually in use.
            special            = true,
            size               = 1,
            passes             = 4,
            brightness         = 1,
            noise              = 0.01,
            contrast           = 1,
            popups             = true,
            popups_ignorealpha = 0.6,
        },

        shadow = {
            enabled      = true,
            -- `ignore_window` no longer exists
            range        = 30,
            offset       = { 0, 2 },
            render_power = 4,
            color        = "rgba(0000002A)",
        },

        -- screen_shader = "~/.config/hypr/shaders/nothing.frag",

        -- Dim
        dim_inactive = true,
        dim_strength = 0.025,
        dim_special  = 0,
    },

    general = {
        -- from colors.conf (overridden later by main.lua, same as before)
        col = {
            active_border   = "rgba(F7DCDE39)",
            inactive_border = "rgba(A58A8D30)",
        },
    },

    misc = {
        background_color = "rgba(1D1011FF)",
    },
})

-- Pinned windows get a pink border
hl.window_rule({
    match = { pin = true },
    border_color = { colors = { "rgba(FFB2BCAA)", "rgba(FFB2BC77)" } },
})
