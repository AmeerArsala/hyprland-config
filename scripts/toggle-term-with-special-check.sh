#!/bin/bash
# Close special workspace if open, then toggle dropdown terminal

# Check if special workspace is active
if hyprctl activewindow -j | jq -e '.workspace.name == "special"' > /dev/null 2>&1; then
    # Special workspace is active, close it
    hyprctl dispatch togglespecialworkspace
fi

# Toggle the dropdown terminal
pypr toggle term
