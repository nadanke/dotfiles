function mkill
    procs --no-header --only PID $argv | xargs kill -9
end
