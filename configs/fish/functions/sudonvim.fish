function sudonvim --wraps='sudo -E env XDG_CONFIG_DIRS=$XDG_CONFIG_DIRS:$HOME/.config/ nvim' --description 'alias sudonvim sudo -E env XDG_CONFIG_DIRS=$XDG_CONFIG_DIRS:$HOME/.config/ nvim'
  sudo -E env XDG_CONFIG_DIRS=$XDG_CONFIG_DIRS:$HOME/.config/ nvim $argv
        
end
