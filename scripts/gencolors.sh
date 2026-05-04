#!/bin/bash

color() {
	xrdb -query | grep -E "$1" | sed -r "s/^[^:]+:\s+//" | head -n 1
}

# generate color files for all programs that I care

xrdb -load "$HOME/.colors"
mapfile -t colors <"$HOME/.colors"
index=0

# =========
# ALACRITTY
# =========
colors_names=(black red green yellow blue magenta cyan white)
alacritty=$(
	cat <<-EOM
		[colors]
		[colors.primary]
		background = "$(color color0)"
		foreground = "$(color color15)"
		[colors.normal]\n
	EOM
)

for p in "${colors[@]}"; do
	[[ "$index" -eq 8 ]] && alacritty+="[colors.bright]\n"
	ala_name=${colors_names[(($index % 8))]}
	c="color${index}"
	alacritty+="$ala_name = \"$(color $c)\"\n"
	((index++))
done

echo -e "$alacritty" >"$HOME/dotfiles/.config/alacritty/colors.toml"

# ====
# NVIM
# ====

nvim="local colors = {\n"
i=0

for p in "${colors[@]}"; do
	name=${colors_names[(($i % 8))]}
	c="color${i}"
	if [ "$i" -gt 7 ]; then
		name+="_bright"
	fi
	nvim+="\t$name = \"$(color $c)\",\n"
	((i++))
done

nvim+="}\n"
nvim+="return colors"

echo -e "$nvim" >"$HOME/dotfiles/.config/nvim/lua/colors.lua"

# ====
# ROFI
# ====

rofi="* {\n"
i=0

for p in "${colors[@]}"; do
	name=${colors_names[(($i % 8))]}
	c="color${i}"
	if [ "$i" -gt 7 ]; then
		name+="bright"
	fi
	rofi+="\t$name: $(color $c);\n"
	((i++))
done

rofi+="}"

echo -e "$rofi" >"$HOME/dotfiles/.config/rofi/colors.rasi"

# ===
# EWW
# ===

i=0
eww=""
for p in "${colors[@]}"; do
	name=${colors_names[(($i % 8))]}
	c="color${i}"
	if [ "$i" -gt 7 ]; then
		name+="bright"
	fi
	eww+="\$$name: $(color $c);\n"
	((i++))
done

echo -e "$eww" >"$HOME/dotfiles/.config/eww/colors.scss"
stow -d "$HOME/dotfiles" -t "$HOME" .
