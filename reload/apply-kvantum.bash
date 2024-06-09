#!/bin/bash

# Create kvantum theme folder
mkdir -p "$HOME/.config/Kvantum/Colorinator"

cp "$HOME/.colors/generated/kvantum/template.svg" "$HOME/.config/Kvantum/Colorinator/Colorinator.svg"
cp "$HOME/.colors/generated/kvantum/template.kvconfig" "$HOME/.config/Kvantum/Colorinator/Colorinator.kvconfig"

if [[ -x kvantummanager ]]; then
	kvantummanager --set colorinator
else
	echo "Kvantum Manager not installed!"
fi
