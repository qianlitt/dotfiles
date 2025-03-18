#!/usr/bin/fish
# This script can print the result of `string match` by regex.

# Require string.txt and pattern.txt

set script_dir (path dirname (status filename))

set str_path (string join '/' -- $script_dir "string.txt")
set pattern_path (string join '/' -- $script_dir "pattern.txt")

# Read string
set str
for s in (awk '{print $1}' $str_path)
    set -a str $s
end

# Read pattern
set pattern (awk 'NR == 1' $pattern_path)

# Test pattern and output
for s in $str
    if string match -qr $pattern $s
        printf "%sSuccessful%s  : %s\n" \
            (set_color green) (set_color normal) $s
    else
        printf "%sUnsuccessful%s: %s\n" \
            (set_color red) (set_color normal) $s
    end
end
