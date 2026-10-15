-- PLUGINS
-- https://wiki.hypr.land/Plugins/Using-Plugins/
--
-- Plugin config values only exist once the plugin is loaded, so guard them.
-- (split-monitor-workspaces is loaded from hyprland.start in base/execs.lua.)
--
-- hyprexpo / hyprbars are not installed (hyprpm has no plugins), so their old
-- `plugin { ... }` blocks from plugins.conf / colors.conf are kept below as
-- comments in case you install them again.

local function plugin_loaded(name)
    for _, p in ipairs(hl.get_loaded_plugins()) do
        if p.name == name then return true end
    end
    return false
end

local function apply_plugin_config()
    if not plugin_loaded("split-monitor-workspaces") then
        return
    end
    hl.config({
        plugin = {
            ["split-monitor-workspaces"] = {
                enable_persistent_workspaces = 1,
            },
        },
    })
end

apply_plugin_config()
-- The plugin is loaded at startup (async), so apply again once it's up.
hl.on("hyprland.start", function()
    hl.timer(apply_plugin_config, { timeout = 3000, type = "oneshot" })
end)

--[[
plugin {
    hyprexpo {
        columns = 3
        gap_size = 5
        bg_col = rgb(000000)
        workspace_method = first 1
        enable_gesture = false
        gesture_distance = 300
        gesture_positive = false
    }
    hyprbars {
        bar_text_font = Rubik, Geist, AR One Sans, Reddit Sans, Inter, Roboto, Ubuntu, Noto Sans, sans-serif
        bar_height = 30
        bar_padding = 10
        bar_button_padding = 5
        bar_precedence_over_border = true
        bar_part_of_window = true
        bar_color = rgba(1D1011FF)
        col.text = rgba(F7DCDEFF)
        hyprbars-button = rgb(F7DCDE), 13, 󰖭, hyprctl dispatch killactive
        hyprbars-button = rgb(F7DCDE), 13, 󰖯, hyprctl dispatch fullscreen 1
        hyprbars-button = rgb(F7DCDE), 13, 󰖰, hyprctl dispatch movetoworkspacesilent special
    }
}
]]
