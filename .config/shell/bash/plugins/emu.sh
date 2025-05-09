emu() {
	[[ -f "/usr/bin/PPSSPPQt" ]] &&
		ln -s "$STORAGE/personal/emu/saves/ppsspp/SAVEDATA" "$CONFIG/ppsspp/PSP" &&
		"$STORAGE/personal/emu/states/ppsspp/PPSSPP_STATE" "$CONFIG/ppsspp/PSP" &&
		"$STORAGE/personal/emu/settings/ppsspp/*" "$CONFIG/ppsspp/PSP/SYSTEM"
	[[ -f "/usr/bin/mgba-qt" ]] &&
		ln -s "$STORAGE/personal/emu/settings/mgba/*.ini" "$CONFIG/mgba/"
	[[ -f "/usr/bin/citra-qt" ]] &&
		ln -s "$STORAGE/personal/emu/saves/citra/*" "$HOME/.local/share/citra-emu/sdmc" &&
		ln -s "$STORAGE/personal/emu/textures/3ds/" "$HOME/.local/share/citra-emu/load/textures"
}
