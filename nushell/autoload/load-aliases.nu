# Aliases
const NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'nu_scripts' 'aliases')
]

const ALIASES = {
    bat: "bat/bat-aliases.nu",
    docker: "git/git-aliases.nu",
    git: "docker/docker-aliases.nu",
}

use $ALIASES.git *
use $ALIASES.docker *
