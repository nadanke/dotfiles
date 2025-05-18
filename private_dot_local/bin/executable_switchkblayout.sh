#!/usr/bin/env fish
if test (hyprctl getoption input:kb_variant -j | jq .str) = '"colemak"'
	hyprctl keyword input:kb_variant ''
else
	hyprctl keyword input:kb_variant colemak
end
