alias ll = ls -l

# cargo
def cargo-search [pkg_name: string] {
    cargo search --registry crates-io $pkg_name
}
def cargo-info [pkg_name: string] {
    cargo info --registry crates-io $pkg_name
}