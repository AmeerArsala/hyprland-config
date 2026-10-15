#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# for rainbow borders animation
#
# Lua-mode Hyprland has no `hyprctl keyword`; use `hyprctl eval` + hl.config instead.

function random_hex() {
  echo "0xff$(openssl rand -hex 3)"
}

# Build a Lua table literal of 10 random colors: { "0xff...", "0xff...", ... }
function random_colors() {
  local out="" i
  for i in 1 2 3 4 5 6 7 8 9 10; do
    out+="\"$(random_hex)\","
  done
  echo "{${out%,}}"
}

# rainbow colors only for active window
hyprctl eval "hl.config({ general = { col = { active_border = { colors = $(random_colors), angle = 270 } } } })"

# rainbow colors for inactive window (uncomment to take effect)
#hyprctl eval "hl.config({ general = { col = { inactive_border = { colors = $(random_colors), angle = 270 } } } })"
