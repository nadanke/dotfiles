function ls --wraps=lsd --wraps='lsd -l' --description 'alias ls lsd -l'
  lsd -l --hyperlink=auto $argv
end
