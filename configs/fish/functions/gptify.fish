function gptify
    for file in (fd -t f)
        echo $file
        /usr/bin/cat $file
    end
end
