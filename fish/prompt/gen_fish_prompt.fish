#!/usr/bin/fish
# Generate fish's default prompt config

function main
    set current_dir (dirname (status --current-filename))
    echo "Current directory: $current_dir"
    set fish_prompt_dir (string join '/' -- $__fish_config_dir "functions")

    set prompt_list_file "fish_default_prompt_list.txt"
    set prompt_list_path (string join '/' -- $current_dir $prompt_list_file)
    echo "Prompt list file path: $prompt_list_path"
    gen_prompt_list $prompt_list_path

    for prompt in (awk '{print $1}' $prompt_list_path)
        set -l dest_dir (string join '/' -- $current_dir $prompt)
        mkdir -p $dest_dir
        gen_prompt $prompt

        # Save prompt files
        set -l left_prompt (string join '/' -- $fish_prompt_dir "fish_prompt.fish")
        set -l right_prompt (string join '/' -- $fish_prompt_dir "fish_right_prompt.fish")
        mv $left_prompt $dest_dir
        mv $right_prompt $dest_dir
    end
end

function gen_prompt_list \
    -d "Write prompt list into argv[1](file)."

    if not is_file $argv[1]
        printf "%s is exist and it not a file. Do you want to delete it? [Y/n].\n" $argv[1]
        switch (read -l | string upper)
            case Y
                printf "Delete file %s.\n" $argv[1]
                fish_config prompt list >$argv[1]
            case '*'
                printf "Exit without delete dir: %s.\n" $argv[1]
                exit
        end
    else
        fish_config prompt list >$argv[1]
    end
end

function gen_prompt
    yes y | fish_config prompt save $argv[1]
end

function is_file \
    -d "if argv[1] is a file, then return 1, otherwise return 0."

    if test -f $argv[1]
        return 1
    else
        return 0
    end
end

function is_dir \
    -d "if argv[1] is a directory, then return 1, otherwise return 0."

    if test -d $argv[1]
        return 1
    end
    return 0
end

main