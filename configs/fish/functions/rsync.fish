function rsync
	env rsync -avz --progress --partial --human-readable $argv
end
