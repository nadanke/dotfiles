function mv
  rsync -aAXv --progress --partial --remove-source-files $argv; and rm -rf $argv[1]
end
