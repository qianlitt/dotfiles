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

# extract
function ex -a file
    if test -f "$file"
        switch "$file"
            case "*.tar.bz2"
                tar xvjf $file
            case "*.tar.gz"
                tar xvzf $file
            case "*.bz2"
                bunzip2 $file
            case "*.rar"
                unrar x $file
            case "*.gz"
                gunzip $file
            case "*.tar"
                tar xvf $file
            case "*.tbz2"
                tar xvjf $file
            case "*.tgz"
                tar xvzf $file
            case "*.zip"
                unzip $file
            case "*.Z"
                uncompress $file
            case "*.7z"
                7z x $file
            case "*"
                set_color red; echo "'$file' cannot be extracted via ex()"
        end
    else
        set_color red; echo "'$file' is not a valid file"
    end
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