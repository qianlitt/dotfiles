# Abbreviations

# ls
if command -q eza
    abbr -a -- ll "eza -al"
    abbr -a -- la "eza -A"
    abbr -a -- lf "eza -alf"
    abbr -a -- ldir "eza -alD"
    abbr -a -- lt "eza -T"
else
    abbr -a -- la "ll -A"
end

abbr -a -- ip "ip -c"
abbr -a -- df "df -h"

abbr -a -- nv nvim
abbr -a -- nvc "nvim --clean"
abbr -a -- py python
abbr -a -- yz yazi

# cargo
abbr -a cgs "cargo search --registry crates-io"
abbr -a cgi "cargo info --registry crates-io"

# git
abbr -a -- glss "git log --show-signature"
abbr -a -- glsp "git log --pretty=\"%h %G? %aN %s\""