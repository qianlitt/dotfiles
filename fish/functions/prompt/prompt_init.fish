#!/usr/bin/fish

# Back up the original fish prompt
set fish_prompt_dir (string join '/' -- $__fish_config_dir "functions")
set fish_prompt_file "fish_prompt.fish" "fish_right_prompt.fish"

set fish_prompt_path
for file in $fish_prompt_file
    set -a fish_prompt_path (string join '/' -- $fish_prompt_dir $file)
end

set count 0
set copy_flag 0
for path in $fish_prompt_path
    if test -f $path
        set copy_flag 1
        if test $count -eq 0
            printf "%sBackup original fish prompt.%s\n" (set_color green) (set_color normal)
        end
        cp -v $path $path.bak
    end
    set count (math $count + 1)
end

# Draw dividing line
if test $copy_flag -eq 1
    echo (set_color green)"------"(set_color normal)
end

# Setup fish prompt
set my_prompt_dir (string join '/' -- $fish_prompt_dir "prompt")
set my_prompt_path
for file in $fish_prompt_file
    set -a my_prompt_path (string join '/' -- $my_prompt_dir $file)
end

printf "%sSetup prompt.%s\n" (set_color green) (set_color normal)
for path in $my_prompt_path
    cp -v $path $fish_prompt_dir
end
