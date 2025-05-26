function gptify
    for file in (fd -t f -E "*.lock" -E "package-lock.json" -E "pnpm-lock.yaml" -E "*.png" -E "*.jpg" -E "*.jpeg" -E "*.svg" -E "*.webp" -E "*.ico" -E "*.gif" -E "*.ttf" -E "*.woff" -E "*.woff2" -E "*.otf" -E "*.pdf" -E "*.mp4" -E "*.mp3" -E "*.zip" -E "*.tar" -E "*.gz" -E "*.bz2")
        # skip binary files
        if file --mime $file | grep -q binary
            continue
        end
        echo "<file><name>$file</name><content>"
        /usr/bin/cat $file
        echo "</content></file>"
    end
end
