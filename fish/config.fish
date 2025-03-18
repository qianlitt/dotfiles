if status is-interactive
    # Commands to run in interactive sessions can go here
end

set env_type (prompt_check_env)
switch $env_type
    case ssh
        prompt_set_color
    case kitty
        starship init fish | source
        prompt_set_color
    case foot
        starship init fish | source
        prompt_set_color
end
