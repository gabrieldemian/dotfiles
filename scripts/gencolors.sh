#!/bin/bash

set -e

echo "generating color files..."

color_names=(black red green yellow blue magenta cyan white)

# generate color files for all programs that I care

xrdb -load "$HOME/dotfiles/.colors"

declare -A color_hex

while IFS= read -r line; do
	if [[ $line =~ (^|\*)color([0-9]+):[[:space:]]*(#[A-Fa-f0-9]+) ]]; then
		index=${BASH_REMATCH[2]}
		hex=${BASH_REMATCH[3]}
		color_hex[$index]=$hex
	fi
done <"$HOME/dotfiles/.colors"

# =========
# ALACRITTY
# =========

alacritty="[colors]"$'\n'
alacritty+="[colors.primary]"$'\n'
alacritty+="background = \"${color_hex[0]}\""$'\n'
alacritty+="foreground = \"${color_hex[15]}\""$'\n'
alacritty+="[colors.normal]"$'\n'

for ((i = 0; i < 16; i++)); do
	((i == 8)) && alacritty+="[colors.bright]"$'\n'
	name=${color_names[$i % 8]}
	alacritty+="$name = \"${color_hex[$i]}\""$'\n'
done

echo -e "$alacritty"
printf '%s' "$alacritty" >|"$HOME/dotfiles/.config/alacritty/colors.toml"

# =======
# GHOSTTY
# =======

ghostty+="background = ${color_hex[0]}"$'\n'
ghostty+="foreground = ${color_hex[15]}"$'\n'
ghostty+="cursor-color = ${color_hex[15]}"$'\n'
ghostty+="cursor-text = ${color_hex[15]}"$'\n'
ghostty+="selection-foreground = ${color_hex[0]}"$'\n'
ghostty+="selection-background = ${color_hex[15]}"$'\n'

for ((i = 0; i < 16; i++)); do
	((i > 7)) && name+="_bright"
	ghostty+="palette = $i=${color_hex[$i]}"$'\n'
done

printf '%s' "$ghostty" >|"$HOME/dotfiles/.config/ghostty/themes/main"

# ====
# NVIM
# ====

nvim="local colors = {"$'\n'

for ((i = 0; i < 16; i++)); do
	name=${color_names[$i % 8]}
	((i > 7)) && name+="_bright"
	nvim+=$'\t'"$name = \"${color_hex[$i]}\","$'\n'
done

nvim+="}"$'\n'
nvim+="return colors"

printf '%s' "$nvim" >|"$HOME/dotfiles/.config/nvim/lua/colors.lua"

# ====
# ROFI
# ====

rofi="* {"$'\n'

for ((i = 0; i < 16; i++)); do
	name=${color_names[$i % 8]}
	((i > 7)) && name+="bright"
	rofi+=$'\t'"$name: ${color_hex[$i]};"$'\n'
done

rofi+="}"

printf '%s' "$rofi" >|"$HOME/dotfiles/.config/rofi/colors.rasi"

# ===
# EWW
# ===

eww=""
for ((i = 0; i < 16; i++)); do
	name=${color_names[$i % 8]}
	((i > 7)) && name+="bright"
	eww+="\$$name: ${color_hex[$i]};"$'\n'
done

printf '%s' "$eww" >|"$HOME/dotfiles/.config/eww/colors.scss"

echo "done"
