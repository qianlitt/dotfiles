#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# Color
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

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
    printf "${YELLOW}Warning: File '$file' not found. Skipping.${NC}\n"
    return 1
  fi

  # 读取文件，忽略空行和注释
  awk '!/^[[:space:]]*#/ && NF {print $1}' "$file" | paru -S --needed --noconfirm -
}

install_rust() {
  printf "${BLUE}::${NC} Install ${GREEN}Rust${NC} develop environment...\n"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

install_all_pkgs() {
  # 遍历 pkgs 关联数组
  for key in "${!pkgs[@]}"; do
    printf "${BLUE}::${NC} Install ${GREEN}${key}${NC} develop environment...\n"
    install_from_file ${pkgs[$key]}
  done

  install_rust
}

install_interact() {
  local keys=("${!pkgs[@]}")
  local i=1

  # 打印选项
  printf "${CYAN}Available Environments:${NC}\n"
  for key in "${keys[@]}"; do
    printf " ${i}) %-10s" "$key"
    ((i++))
  done
  printf " ${i}) rust\n"
  local rust_index=$i

  printf "${BLUE}::${NC} Enter numbers separated by space (e.g., 1 2 3): "
  read -a choices

  for choice in ${choices[@]}; do
    # 检查是否为 rust
    if [[ "$choice" -eq "$rust_index" ]]; then
      printf "${BLUE}::${NC} Install ${GREEN}Rust${NC}...\n"
      install_rust

    # 检查是否在普通包范围内 (1 到 i-1)
    elif [[ "$choice" -ge 1 ]] && [[ "$choice" -lt "$rust_index" ]]; then
      # 因为数组下标从 0 开始，所以要减 1
      local idx=$((choice - 1))
      local selected_key="${keys[$idx]}"

      printf "${BLUE}::${NC} Install ${GREEN}${selected_key}${NC} develop environment...\n"
      install_from_file "${pkgs[$selected_key]}"

    else
      printf "${RED}Invalid selection: $choice${NC}\n"
    fi
  done
}

main() {
  # 检查命令是否存在
  if ! command -v paru &>/dev/null; then
    printf "${RED}Error: paru is not installed. Please install paru first.${NC}\n"
    exit 1
  fi

  printf "${BLUE}::${NC} Do you want to install all packages?\n"
  read -p "[A]ll [I]nteract [N]o: " install_mode

  case "$install_mode" in
  A | a)
    install_all_pkgs
    ;;
  I | i)
    install_interact
    ;;
  *)
    echo "Exiting."
    exit 0
    ;;
  esac
}

main
