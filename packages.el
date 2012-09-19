;; CL
(require 'cl)
(define-obsolete-variable-alias 'custom-print-functions 'cl-custom-print-functions "24.1")

;; add ido
(require 'ido)
(ido-mode)

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

;; autopair
(require 'autopair)

(defvar autopair-modes '(r-mode ruby-mode))
(defun turn-on-autopair-mode () (autopair-mode 1))
(dolist (mode autopair-modes) (add-hook (intern (concat (symbol-name mode) "-hook")) 'turn-on-autopair-mode))

(require 'paredit)
(defadvice paredit-mode (around disable-autopairs-around (arg))
  "Disable autopairs mode if paredit-mode is turned on"
  ad-do-it
  (if (null ad-return-value)
      (autopair-mode 1)
    (autopair-mode 0)
    ))

(ad-activate 'paredit-mode)

;; project-mode
(autoload 'project-mode "project-mode" "Project Mode" t)

;; yasnippet
(require 'yasnippet)
(require 'yasnippet-bundle)
(setq yas/root-directory "~/.emacs.d/snippets")
(yas/load-directory yas/root-directory)
(yas/global-mode 1)

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
;; (autoload 'turn-on-ctags-auto-update-mode "ctags-update" "turn on `ctags-auto-update-mode'." t)

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

;; RESTclient
(require 'restclient)

;; ESS
(require 'ess-site)

;; Ruby-electric
(require 'ruby-electric)

;; Workaround for ruby-electric messing with yasnippet
(defun yas/advise-indent-function (function-symbol)
  (eval `(defadvice ,function-symbol (around yas/try-expand-first activate)
           ,(format
             "Try to expand a snippet before point, then call `%s' as usual"
             function-symbol)
           (let ((yas/fallback-behavior nil))
             (unless (and (interactive-p)
                          (yas/expand))
               ad-do-it)))))
(yas/advise-indent-function 'ruby-indent-line)

;; RSpec mode
(require 'rspec-mode)
(setq rspec-use-rake-flag nil)
(define-key rspec-mode-verifible-keymap (kbd "s") 'rspec-verify-single)

;; ruby-tools
(require 'ruby-tools)

;; SLIME
(setq inferior-lisp-program "/usr/local/bin/clisp")
(require 'slime)
(slime-setup)
