#!/usr/bin/fish
# Clean file and directory which `save_fish_default_prompt.fish` generated.

set script_dir (path dirname (status filename))
set list_file "fish_default_prompt_list.txt"
set list_path (string join '/' -- $script_dir $list_file)

# Check list_path
if not test -f $list_path
    printf "%sError: list file isn't exist!%s" \
        (set_color $fish_color_error) (set_color normal)
    return 1
end

printf "--- %sdelete start%s ---\n" \
    (set_color $fish_color_error) (set_color normal)

for target in (awk '{print $1}' $list_path)
    rm -rv $target
end

printf "--- %sdelete   end%s ---\n" \
    (set_color $fish_color_error) (set_color normal)

rm -rv $list_path
