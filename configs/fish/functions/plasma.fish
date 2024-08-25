function plasma --wraps='/usr/lib/plasma-dbus-run-session-if-needed /usr/bin/startplasma-wayland' --description 'alias plasma /usr/lib/plasma-dbus-run-session-if-needed /usr/bin/startplasma-wayland'
  /usr/lib/plasma-dbus-run-session-if-needed /usr/bin/startplasma-wayland $argv
        
end
