#!/usr/bin/env sh
gawk -i inplace 'NR==2 { if (/^#/) { sub(/^#/, "") } else { sub(/^/, "#") } } 1' ~/.config/hypr/input.conf
