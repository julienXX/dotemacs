;; Line numbers
(add-hook 'eshell-mode-hook
  '(lambda () (linum-mode 0)))

(add-hook 'compilation-mode-hook
  '(lambda () (linum-mode 0)))

(add-hook 'dired-mode-hook
  '(lambda () (linum-mode 0)))

(add-hook 'shell-mode-hook
  '(lambda () (linum-mode 0)))

(add-hook 'magit-mode-hook
  '(lambda () (linum-mode 0)))

;; SLIME hooks
(add-hook 'sldb-mode-hook
          #'(lambda ()
              (autopair-mode -1)))

;; Ruby hooks
(add-hook 'ruby-mode-hook
  (lambda ()
    (autopair-mode 1)
    (ruby-electric-mode t)
    (ruby-tools-mode t)))

;; HAML hooks
(add-hook 'haml-mode-hook
  (lambda ()
    (ruby-tools-mode t)
    (setq indent-tabs-mode nil)
    (define-key haml-mode-map "\C-m" 'newline-and-indent)))


;; Delete trailing whitespaces
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Rainbow mode hooks
(add-hook 'css-mode-hook 'rainbow-mode)
(add-hook 'scss-mode-hook 'rainbow-mode)
(add-hook 'sass-mode-hook 'rainbow-mode)
