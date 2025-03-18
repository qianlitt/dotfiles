#!/usr/bin/fish
# Save fish's default prompt config

set script_dir (path dirname (status filename))

# Path which this script save fish's prompt list
set prompt_list_file "fish_default_prompt_list.txt"
set prompt_list_path (string join '/' -- $script_dir $prompt_list_file)

# Path which fish save prompt
set prompt_dir (string join '/' -- $__fish_config_dir "functions")

set prompt_path
set pattern "fish_(right_)?prompt\.fish\$"
for file in $prompt_dir/*
    if string match -rq $pattern $file
        set -a prompt_path $file
    end
end

function is_file \
    --description "if argv[1] is a file, then return 1, otherwise return 0."
    if test -f $argv[1]
        return 1
    end
    return 0
end

function is_dir \
    --description "if argv[1] is a directory, then return 1, otherwise return 0."

    if test -d $argv[1]
        return 1
    end
    return 0
end

function check_prompt_list_file \
    --description "if argv[1] isn't exist, then create."

    is_file $argv[1]
    if test $status -eq 1
        printf "%sFile %s\"%s\"%s is exist.%s\n" \
            (set_color green) (set_color grey) $argv[1] (set_color green) (set_color normal)
    else
        printf "%sFile %s\"%s\"%s not exist.%s Try to create.\n" \
            (set_color $fish_color_error) (set_color grey) $argv[1] (set_color $fish_color_error) (set_color normal)
        touch $argv[1]
    end
end

function save_prompt_list \
    --description "check argv[1](file), and write prompt list in it."

    check_prompt_list_file $argv[1]
    fish_config prompt list >$argv[1]
end

function check_subdir \
    --description "if sub-diretory exist prompt files, return 1; otherwise return 0"

    set target_file
    for path in $argv[2]
        set -a target_file (string split -r -m1 / $path)[2]
    end

    is_file (string join '/' -- $argv[1] $target_file)
    if test $status -eq 1
        return 1
    end
    return 0
end

# Save fish prompts
function save_prompt
    set -f prompt_subdir
    for prompt in (awk '{print $1}' $argv[1])
        # Create prompt sub-diretory
        set prompt_subdir (string join '/' -- $script_dir $prompt)
        is_dir $prompt_subdir
        if test $status -eq 0 # if $prompt_subdir isn't exist
            printf "%smkdir:%s %s\n" \
                (set_color green) (set_color normal) $prompt_subdir
            mkdir -p $prompt_subdir
        end

        # Check sub-diretory's file
        set copy_flag 0
        for file in $prompt_path
            check_subdir $prompt_subdir $file
            if test $status -eq 0 # if file isn't exist
                set copy_flag 1
            end
        end

        # fish save prompt
        if test $copy_flag -eq 1
            printf "%s%s%s:\n" \
                (set_color green) $prompt (set_color normal)
            yes y | fish_config prompt save $prompt
            # Copy fish prompt to sub-diretory
            for file in $prompt_path
                cp -v $file $prompt_subdir
            end
        end
    end
end

function main
    save_prompt_list $prompt_list_path
    save_prompt $prompt_list_path
    printf "%sCompleted!%s" \
        (set_color green) (set_color normal)
end

main
