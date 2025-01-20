(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default standard-indent 2)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

(set-face-attribute'default nil
                            :family "JetBrainsMonoNLNerdFont"
                            :height 120)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

(use-package catppuccin-theme
  :straight t
  :config
  (load-theme 'catppuccin :no-confirm))

(add-hook 'haskell-mode-hook 'eglot-ensure)

(use-package evil
  :straight t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))
(use-package evil-collection
  :straight t
  :after evil
  :config
  (evil-collection-init))
(use-package evil-surround
  :straight t
  :after evil
  :config
  (global-evil-surround-mode 1))
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)

(use-package which-key
  :straight t
  :config
  (which-key-mode))

(use-package vertico
  :straight t
  :init
  (vertico-mode 1)
  :custom
  (vertico-count 10)
  (vertico-resize t))

(use-package consult
  :straight t
  :bind (("C-s" . consult-line)
         ("C-x b" . consult-buffer)))

(use-package orderless
  :straight t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package avy
  :straight t
  :init
  (setq avy-keys '(?a ?r ?s ?t ?n ?e ?i ?o))
  :bind (("C-\\" . avy-goto-char-2)
         ("C-|" . avy-goto-word-1)))

(use-package dirvish
  :straight t
  :init
  (dirvish-override-dired-mode))

(use-package sly
  :straight t
  :config
  (setq inferior-lisp-program "sbcl")
  :hook (lisp-mode . sly-editing-mode))

(use-package haskell-mode
  :straight t
  :mode "\\.hs\\'"
  :config
  (setq haskell-indent-spaces 2
        haskell-tags-on-save t))

(use-package treesit
  :mode (("\\.js\\'" . typescript-ts-mode)
         ("\\.ts\\'" . typescript-ts-mode))
  :preface
  (defun os/setup-install-grammars ()
    "Install Tree-sitter grammar if they are absent"
    (interactive)
    (dolist (grammar
             '((javascript . ("https://github.com/tree-sitter/tree-sitter-javascript" "master" "src"))
               (markdown "https://github.com/ikatyang/tree-sitter-markdown")
               (elisp "https://github.com/Wilfred/tree-sitter-elisp")
               (haskell "https://github.com/tree-sitter/tree-sitter-haskell")
               (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src"))))
      (add-to-list 'treesit-language-source-alist grammar)
      (unless (treesit-language-available-p (car grammar))
        (treesit-install-language-grammar (car grammar)))))
  :config
  (os/setup-install-grammars))

(use-package company
             :straight t
             :config
             (add-hook 'after-init-hook 'global-company-mode))

(use-package racket-mode
  :straight t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
