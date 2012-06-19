;; Line numbers
(add-hook 'eshell-mode-hook 
  '(lambda () (linum-mode 0)))

(add-hook 'compilation-mode-hook 
  '(lambda () (linum-mode 0)))

(add-hook 'dired-mode-hook 
  '(lambda () (linum-mode 0)))

(add-hook 'shell-mode-hook 
  '(lambda () (linum-mode 0)))

;; SLIME hooks
(add-hook 'slime-repl-mode-hook
  (lambda ()
    (setq autopair-dont-activate t)))

;; Ruby hooks
(add-hook 'ruby-mode-hook
  (lambda ()
     (ruby-electric-mode t)))
