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
(require 'smartparens-config)
(require 'smartparens-ruby)
(smartparens-global-mode)
(show-smartparens-global-mode t)
(sp-with-modes '(rhtml-mode)
  (sp-local-pair "<" ">")
  (sp-local-pair "<%" "%>"))

;; yasnippet
(require 'yasnippet)
(require 'angular-snippets)
(setq yas-snippets-dir
      '("~/.emacs.d/snippets"))
(yas-global-mode 1)

;; auto-complete
(require 'auto-complete-config)
(ac-config-default)
(setq ac-ignore-case nil)
(add-to-list 'ac-modes 'enh-ruby-mode)
(add-to-list 'ac-modes 'web-mode)

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

;; ace-jump-mode
(require 'ace-jump-mode)
  (define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

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
;;(require 'multi-term)
;;(set-terminal-coding-system 'utf-8-unix)
;;(setq multi-term-dedicated-select-after-open-p t)
;;(setq multi-term-program "/usr/local/bin/zsh")
;;(setq multi-term-buffer-name "Terminal")

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

;; projectile
(require 'grizzl)
(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-completion-system 'grizzl)
;; Press Command-p for fuzzy find in project
(global-set-key (kbd "M-p") 'projectile-find-file)
;; Press Command-b for fuzzy switch buffer
(global-set-key (kbd "M-b") 'projectile-switch-to-buffer)

;; Anzu mode
(global-anzu-mode +1)

;; Enhanced ruby-mode (always load last)
(add-to-list 'load-path "(path-to)/Enhanced-Ruby-Mode") ; must be added after any path containing old ruby-mode
(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
