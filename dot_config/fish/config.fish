zoxide init fish | source
fzf --fish | source
export MANPAGER="nvim +Man!"

# ghcup-env
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/nadanke/.ghcup/bin $PATH

# pnpm
set -gx PNPM_HOME "/home/nadanke/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/nadanke/.opam/opam-init/init.fish' && source '/home/nadanke/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration
