# Auto start Hyprland on tty1
if test -z "$DISPLAY"; and test (tty) = /dev/tty1
    mkdir -p ~/.cache
    exec Hyprland >~/.cache/hyprland.log 2>&1
end
