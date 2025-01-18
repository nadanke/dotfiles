zoxide init fish | source
fzf --fish | source
export MANPAGER="nvim +Man!"


set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/nadanke/.ghcup/bin $PATH # ghcup-env
# pnpm
set -gx PNPM_HOME "/home/nadanke/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
