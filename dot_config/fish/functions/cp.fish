function cp
	rsync -aAXv --progress --partial --human-readable $argv
end
