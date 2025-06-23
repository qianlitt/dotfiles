alias ll = ls -l

# cargo
def cargo-search [pkg_name: string] {
    cargo search --registry crates-io $pkg_name
}
def cargo-info [pkg_name: string] {
    cargo info --registry crates-io $pkg_name
}

# scoop
def scoop-updateall [] {
    let now_path = (pwd)
    let scoop_apps_path = "~/scoop/apps/"

    cd $scoop_apps_path
    scoop update *
    cd $now_path
}