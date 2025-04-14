function ssha --wraps='eval (ssh-agent -c) && ssh-add ~/.ssh/id_rsa && ssh -A' --description 'alias ssha=eval (ssh-agent -c) && ssh-add ~/.ssh/id_rsa && ssh -A'
  eval (ssh-agent -c) && ssh-add ~/.ssh/id_rsa && command ssh -A $argv
end
