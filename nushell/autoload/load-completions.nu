# Custom completions
const NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'nu_scripts' 'custom-completions')
]

const COMPLETIONS = {
    ack: "ack/ack-completions.nu",
    bat: "bat/bat-completions.nu",
    cargo: "cargo/cargo-completions.nu",
    cargo_loco: "cargo-loco/cargo-loco-completions.nu",
    cargo_make: "cargo-make/cargo-make-completions.nu",
    curl: "curl/curl-completions.nu",
    docker: "docker/docker-completions.nu",
    git: "git/git-completions.nu",
    less: "less/less-completions.nu",
    make: "make/make-completions.nu",
    man: "man/man-completions.nu",
    npm: "npm/npm-completions.nu",
    pnpm: "pnpm/pnpm-completions.nu",
    poetry: "poetry/poetry-completions.nu",
    rg: "rg/rg-completions.nu",
    rustup: "rustup/rustup-completions.nu",
    scoop: "scoop/scoop-completions.nu",
    ssh: "ssh/ssh-completions.nu",
    tar: "tar/tar-completions.nu",
    tcpdump: "tcpdump/tcpdump-completions.nu",
    tealdeer: "tealdeer/tealdeer-completions.nu",
    uv: "uv/uv-completions.nu",
    vscode: "vscode/vscode-completions.nu",
    windows: "windows/windows-completions.nu",
    yarn: "yarn/yarn-completions.nu",
    zellij: "zellij/zellij-completions.nu"
}

use $COMPLETIONS.ack *
use $COMPLETIONS.bat *
use $COMPLETIONS.cargo *
use $COMPLETIONS.curl *
use $COMPLETIONS.docker *
use $COMPLETIONS.git *
use $COMPLETIONS.less *
use $COMPLETIONS.make *
use $COMPLETIONS.man *
use $COMPLETIONS.npm *
use $COMPLETIONS.pnpm *
use $COMPLETIONS.rg *
use $COMPLETIONS.rustup *
use $COMPLETIONS.ssh *
use $COMPLETIONS.tar *
use $COMPLETIONS.tcpdump *
use $COMPLETIONS.uv *