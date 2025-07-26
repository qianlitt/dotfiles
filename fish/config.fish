if status is-interactive
    # Commands to run in interactive sessions can go here

    # prompt settings
    set env_type (check_env)
    switch $env_type
        case vscode
            starship init fish | source
        case ssh
            # Start Zellij
            set ZELLIJ_AUTO_ATTACH true
            set ZELLIJ_AUTO_EXIT true
            eval (zellij setup --generate-auto-start fish | string collect)
        case zellij
            print_greeting
            starship init fish | source
        case kitty
            starship init fish | source
            set_terminal_color
        case foot
            starship init fish | source
            set_terminal_color
        case tty
            print_greeting
    end
end
