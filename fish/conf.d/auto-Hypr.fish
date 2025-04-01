# Auto start Hyprland on tty1
set autoStartHyprland 1 # if autoStartHyprland == 1, then Hyprland is auto start
if test -z "$DISPLAY"; and test (tty) = /dev/tty1; and test $autoStartHyprland -eq 1
    mkdir -p ~/.cache
    exec Hyprland >~/.cache/hyprland.log 2>&1
end
