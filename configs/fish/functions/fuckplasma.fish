function fuckplasma
    procs --no-header --only PID kwin_wayland_wrapper | xargs kill -9
end
