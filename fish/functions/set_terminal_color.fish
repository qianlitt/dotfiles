function set_terminal_color -d "Change terminal's color"
    if test -f ~/.cache/ags/user/generated/terminal/sequences.txt
        cat ~/.cache/ags/user/generated/terminal/sequences.txt
    end
end
