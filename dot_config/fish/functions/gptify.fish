function gptify
    for file in (fd -t f)
        echo "<file><name>$file</name><content>"
        /usr/bin/cat $file
        echo "</content></file>"
    end
end
