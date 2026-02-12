#!/usr/bin/env bash

# 适用于 Arch Linux 并已安装 paru 的 PC

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# Color
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly CYAN='\033[0;36m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m'

# Packages
# 只用维护以下这个数组和对应文件即可
declare -A pkgs=(
    ["C/C++"]="${SCRIPT_DIR}/c_cpp.txt"
    ["Game"]="${SCRIPT_DIR}/game.txt"
    ["Python"]="${SCRIPT_DIR}/python.txt"
    ["Tauri"]="${SCRIPT_DIR}/tauri.txt"
)

install_from_file() {
    local file="$1"
    if [[ ! -f "$file" ]]; then
        printf "%bWarning%b: File %b%s%b is not found. Skipping." \
            "$YELLOW" "$NC" "$GREEN" "$file" "$NC"
        return 1
    fi

    # 读取文件，忽略空行和注释
    awk '!/^[[:space:]]*#/ && NF {print $1}' "$file" | paru -S --needed --noconfirm -
}

install_rust() {
    printf "%b::%b Install %bRust%b develop environment...\n" \
        "$BLUE" "$NC" "$GREEN" "$NC"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

install_all_pkgs() {
    # 遍历 pkgs 关联数组
    for key in "${!pkgs[@]}"; do
        printf "%b::%b Install %b%s%b develop environment...\n" \
            "$BLUE" "$NC" "$GREEN" "$key" "$NC"
        install_from_file "${pkgs[$key]}"
    done

    install_rust
}

install_interact() {
    local keys=("${!pkgs[@]}")
    local i=1

    # 打印选项
    printf "%bAvailable Environments:%b\n" \
        "$CYAN" "$NC"
    for key in "${keys[@]}"; do
        printf " ${i}) %-10s" "$key"
        ((i++))
    done
    printf " %s) rust\n" \
        "$i"
    local rust_index=$i

    printf "%b::%b Enter numbers separated by space (e.g., 1 2 3): " \
        "$BLUE" "$NC"
    read -ra choices

    for choice in "${choices[@]}"; do
        # 检查是否为 rust
        if [[ "$choice" -eq "$rust_index" ]]; then
            printf "%b::%b Install %bRust%b...\n" \
                "$BLUE" "$NC" "$GREEN" "$NC"
            install_rust

        # 检查是否在普通包范围内 (1 到 i-1)
        elif [[ "$choice" -ge 1 ]] && [[ "$choice" -lt "$rust_index" ]]; then
            # 因为数组下标从 0 开始，所以要减 1
            local idx=$((choice - 1))
            local selected_key="${keys[$idx]}"

            printf "%b::%b Install %b%b%b develop environment...\n" \
                "$BLUE" "$NC" "$GREEN" "$selected_key" "$NC"
            install_from_file "${pkgs[$selected_key]}"

        else
            printf "%bInvalid selection: %s%b\n" \
                "$RED" "$choice" $NC""
        fi
    done
}

main() {
    # 检查命令是否存在
    if ! command -v paru &>/dev/null; then
        printf "%bError: paru is not installed. Please install paru first.%b\n" \
            "$RED" "$NC"
        exit 1
    fi

    printf "%b::%b Do you want to install all packages?\n" \
        "$BLUE" "$NC"
    read -rp "[A]ll [I]nteract [N]o: " install_mode

    case "$install_mode" in
    A | a)
        install_all_pkgs
        ;;
    I | i)
        install_interact
        ;;
    *)
        echo "There is nothing to do. Exiting."
        exit 0
        ;;
    esac
}

main
