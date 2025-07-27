# Auto start Hyprland on tty1
if test -z "$DISPLAY"; and test (tty) = /dev/tty1; and test $auto_hypr = true
    mkdir -p ~/.cache
    exec Hyprland >~/.cache/hyprland.log 2>&1
end

function set_auto_hypr -d "Set a variable to control auto start of Hyprland"
    if test "$argv[1]" != true; and test "$argv[1]" != false
        echo "Usage: set_auto_hypr <true|false>"
        return 1
    end

    set -U auto_hypr $argv[1]
end

function get_auto_hypr -d "Get auto start Hyprland status"
    printf "Auto start Hyprland: %s\n" (set -qU auto_hypr; and echo $auto_hypr; or echo "not set")
end