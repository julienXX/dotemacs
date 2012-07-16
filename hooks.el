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
(add-hook 'sldb-mode-hook
          #'(lambda ()
              (autopair-mode -1)))

;; Ruby hooks
(add-hook 'ruby-mode-hook
  (lambda ()
    (autopair-mode 1)
    (ruby-electric-mode t)
    (ruby-tools-mode t)))

;; Delete trailing whitespaces
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Rainbow mode hooks
(add-hook 'css-mode-hook 'rainbow-mode)
(add-hook 'scss-mode-hook 'rainbow-mode)
(add-hook 'sass-mode-hook 'rainbow-mode)
