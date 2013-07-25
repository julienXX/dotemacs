;; CL
;; (require 'cl)
;; (define-obsolete-variable-alias 'custom-print-functions 'cl-custom-print-functions "24.1")

;; add ido
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)

;; smex
(require 'smex)
(smex-initialize)

;; smex bindings
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This the original M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; textmate mode
(require 'textmate)
(textmate-mode)

;; smartparens
(require 'smartparens)
(smartparens-global-mode t)

(require 'paredit)
(defadvice paredit-mode (around disable-autopairs-around (arg))
  "Disable autopairs mode if paredit-mode is turned on"
  ad-do-it
  (if (null ad-return-value)
      (autopair-mode 1)
    (autopair-mode 0)
    ))

(ad-activate 'paredit-mode)

;; yasnippet
(require 'yasnippet)
(require 'angular-snippets)
(setq yas-snippets-dir
      '("~/.emacs.d/snippets"))
(yas-global-mode 1)

;; automatic end insertion
(require 'ruby-end)

;; auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)

;; Ack and a half
(add-to-list 'load-path "/elpa/ack-and-a-half")
(autoload 'ack-and-a-half-same "ack-and-a-half" nil t)
(autoload 'ack-and-a-half "ack-and-a-half" nil t)
(autoload 'ack-and-a-half-find-file-samee "ack-and-a-half" nil t)
(autoload 'ack-and-a-half-find-file "ack-and-a-half" nil t)

;; Create shorter aliases
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

;; Expand region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; Wrap region
(require 'wrap-region)
(wrap-region-global-mode)

;; CTags
(require 'ctags-update)
(autoload 'turn-on-ctags-auto-update-mode "ctags-update" "turn on `ctags-auto-update-mode'." t)
(add-hook 'prog-mode-hook  'turn-on-ctags-auto-update-mode)

;; YAML
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; Gists
(require 'eieio)
(require 'gist)
(setq gist-use-curl t)
(setq gist-view-gist t)

;; Partially.el
(require 'partially)
(setq partially:rails-root-fn 'rinari-root)

;; ace-jump-mode
(require 'ace-jump-mode)
  (define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; Ruby-electric
(require 'ruby-electric)
(setq ruby-electric-expand-delimiters-list nil)

;; Workaround for ruby-electric messing with yasnippet
(defun yas-advise-indent-function (function-symbol)
  (eval `(defadvice ,function-symbol (around yas-try-expand-first activate)
           ,(format
             "Try to expand a snippet before point, then call `%s' as usual"
             function-symbol)
           (let ((yas-fallback-behavior nil))
             (unless (and (interactive-p)
                          (yas-expand))
               ad-do-it)))))
(yas-advise-indent-function 'ruby-indent-line)

;; RSpec mode
(require 'rspec-mode)
(setq rspec-use-rake-flag nil)
(define-key rspec-mode-verifiable-keymap (kbd "s") 'rspec-verify-single)

;; ruby-tools
(require 'ruby-tools)

;; SLIME
(setq inferior-lisp-program "/usr/local/bin/clisp")
(require 'slime)
(slime-setup)

;; multi-term
(require 'multi-term)
(set-terminal-coding-system 'utf-8-unix)
(setq multi-term-dedicated-select-after-open-p t)
(setq multi-term-program "/usr/local/bin/zsh")
(setq multi-term-buffer-name "Terminal")

(defun it-multi-term-dedicated-toggle ()
  "jump back to previous location after toggling ded term off"
  (interactive)
  (if (multi-term-dedicated-exist-p)
      (progn
	(multi-term-dedicated-toggle)
	(switch-to-buffer-other-window old-buf))
    (progn
      (setq old-buf (current-buffer))
      (multi-term-dedicated-toggle))
    )
  )

;; SCSS
(setq scss-compile-at-save nil)

;; Rinari
(require 'rinari)

;; Golden ration
(require 'golden-ratio)
(golden-ratio-mode)

;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

;; Make dired less verbose
(require 'dired-details)
(setq-default dired-details-hidden-string "--- ")
(dired-details-install)
(setq insert-directory-program "gls" dired-use-ls-dired t)

;; configure markdown-mode
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)

;; git-gutter
(require 'git-gutter)
(global-git-gutter-mode t)
(setq git-gutter:modified-sign "<> ")
(setq git-gutter:added-sign "++ ")
(setq git-gutter:deleted-sign "-- ")

;; multiple-cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; projectile
(projectile-global-mode)
(setq projectile-globally-ignored-files '("TAGS" ".#*"))
