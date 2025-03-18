#!/usr/bin/fish
# Save fish's default prompt config

set script_dir (path dirname (status filename))

# Path which this script save fish's prompt list
set prompt_list_file "fish_default_prompt_list.txt"
set prompt_list_path (string join '/' -- $script_dir $prompt_list_file)

# Path which fish save prompt
set prompt_dir (string join '/' -- $__fish_config_dir "functions")
set prompt_left_file "fish_prompt.fish"
set prompt_left_path (string join '/' -- $prompt_dir $prompt_left_file)
set prompt_right_file "fish_right_prompt.fish"
set prompt_right_path (string join '/' -- $prompt_dir $prompt_right_file)

function is_path_exist
    if test -f $argv[1]
        printf "%sYes, %s is a file.%s\n" \
            (set_color green) $argv[1] (set_color normal)
        return 1
    else if test -d $argv[1]
        printf "%sYes, %s is a directory.%s\n" \
            (set_color green) $argv[1] (set_color normal)
        return 2
    else
        printf "%sNo, %s is not exist.%s\n" \
            (set_color $fish_color_error) $argv[1] (set_color normal)
        return -1
    end
end

# List all default prompts for fish
function save_prompt_list
    begin
        set -f output (is_path_exist $argv[1])
        set -f retvar $status
    end

    if test $retvar -eq 1
        printf "%sFile %s\"%s\"%s is exist.%s\n" \
            (set_color green) (set_color grey) $argv[1] (set_color green) (set_color normal)
    else
        printf "%sFile %s\"%s\"%s not exist.%s Try to create.\n" \
            (set_color $fish_color_error) (set_color grey) $argv[1] (set_color $fish_color_error) (set_color normal)
        touch $argv[1]
    end

    fish_config prompt list >$argv[1]
end

# Save fish prompts
function save_prompt
    set -f prompt_subdir
    for prompt in (awk '{print $1}' $argv[1])
        # Create prompt sub-diretory
        set prompt_subdir (string join '/' -- $script_dir $prompt)
        if not test -d $prompt_subdir
            printf "%smkdir:%s %s\n" \
                (set_color green) (set_color normal) $prompt_subdir
            mkdir -p $prompt_subdir
        end

        # fish save prompt
        yes y | fish_config prompt save $prompt

        # Copy fish prompt to sub-diretory
        is_path_exist $argv[2]
        set -f retvar $status
        if test $retvar -eq 1
            cp $argv[2] $prompt_subdir
        else
            printf "%sError: %s\"%s\"%s isn't exist.%s\n" \
                (set_color $fish_color_error) (set_color grey) argv[2] (set_color $fish_color_error) (set_color normal)
        end

        is_path_exist $argv[3]
        set -f retvar $status
        if test $retvar -eq 1
            cp $argv[3] $prompt_subdir
        else
            printf "%sError: %s\"%s\"%s isn't exist.%s\n" \
                (set_color $fish_color_error) (set_color grey) argv[3] (set_color $fish_color_error) (set_color normal)
        end
    end
end

function main
    save_prompt_list $prompt_list_path
    save_prompt $prompt_list_path $prompt_left_path $prompt_right_path
end

main
