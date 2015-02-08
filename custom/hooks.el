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
(add-hook 'enh-ruby-mode-hook
  (lambda ()
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

;; C-d to exit shell
(defun comint-delchar-or-eof-or-kill-buffer (arg)
  (interactive "p")
  (if (null (get-buffer-process (current-buffer)))
      (kill-buffer)
    (comint-delchar-or-maybe-eof arg)))

(add-hook 'shell-mode-hook
          (lambda ()
            (define-key shell-mode-map
              (kbd "C-d") 'comint-delchar-or-eof-or-kill-buffer)))

(add-hook 'markdown-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c o p") 'jxx-markdown-preview)))

;; FlyCheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Elixir
(add-hook 'elixir-mode-hook
          (defun auto-activate-ruby-end-mode-for-elixir-mode ()
            (set (make-variable-buffer-local 'ruby-end-expand-keywords-before-re)
                 "\\(?:^\\|\\s-+\\)\\(?:do\\)")
            (set (make-variable-buffer-local 'ruby-end-check-statement-modifiers) nil)
            (ruby-end-mode +1)))

;; Clojure
(add-hook 'clojure-mode-hook 'paredit-mode)

;; Company mode
(add-hook 'after-init-hook 'global-company-mode)
