;; emacs configuration
;; Setting path
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path `("/usr/local/bin")))

(setq make-backup-files nil)
(setq auto-save-default nil)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq inhibit-startup-message t)

(fset 'yes-or-no-p 'y-or-n-p)

(delete-selection-mode t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode t)
(show-paren-mode t)
(column-number-mode t)
(set-fringe-style -1)
(tooltip-mode -1)
(setq ring-bell-function (lambda () (message "*beep*")))

;; initial frame size
(add-to-list 'default-frame-alist '(left . 0))
(add-to-list 'default-frame-alist '(top . 0))
(add-to-list 'default-frame-alist '(height . 50))
(add-to-list 'default-frame-alist '(width . 145))

;; Free up the option key for special characters
(setq ns-alternate-modifier 'none)
(setq ns-command-modifier 'meta)
(setq ns-function-modifier 'super)

;; Save temp file in /tmp
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; aesthetics
(set-default-font
  "-*-Source Code Pro-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")
(load-theme 'dichromacy)
(setq linum-format " %3d ")

;; stop opening a new frame (window) for each file
(setq ns-pop-up-frames nil)

;; Only one window on startup
(add-hook 'emacs-startup-hook
          (lambda () (delete-other-windows)) t)

;; Auto refresh buffers
(global-auto-revert-mode 1)

;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

;; package stuff
(require 'package)
(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                          ("gnu" . "http://elpa.gnu.org/packages/")
                          ("MELPA" . "http://melpa.milkbox.net/packages/")
                          ("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize)

;; load customizations
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elpa"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/vendor"))

; Add external projects to load path
(dolist (project (directory-files "~/.emacs.d/vendor" t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

(load "packages")
(load "functions")
(load "modes")
(load "hooks")
(load "mappings")

(eval-after-load 'magit '(require 'setup-magit))

;; Shell variables on OSX
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Setting rbenv path
(setenv "PATH" (concat (getenv "HOME") "/.rbenv/shims:" (getenv "HOME") "/.rbenv/bin:" (getenv "PATH")))
(setq exec-path (cons (concat (getenv "HOME") "/.rbenv/shims") (cons (concat (getenv "HOME") "/.rbenv/bin") exec-path)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#14191f" "#d15120" "#81af34" "#deae3e" "#7e9fc9" "#a878b5" "#7e9fc9" "#d0d1d2"])
 '(ansi-term-color-vector [unspecified "#14191f" "#d15120" "#81af34" "#deae3e" "#7e9fc9" "#a878b5" "#7e9fc9" "#d0d1d2"] t)
 '(column-number-mode t)
 '(custom-safe-themes (quote ("e9a1226ffed627ec58294d77c62aa9561ec5f42309a1f7a2423c6227e34e3581" "4be2645396d79e94d37867be5a7f41b66e05fa81c5b266d705a7edd7fb785302" "501caa208affa1145ccbb4b74b6cd66c3091e41c5bb66c677feda9def5eab19c" default)))
 '(fci-rule-character-color "#192028")
 '(fci-rule-color "#073642")
 '(fringe-mode nil nil (fringe))
 '(indicate-buffer-boundaries (quote right))
 '(indicate-empty-lines t)
 '(safe-local-variable-values (quote ((encoding . utf-8) (ruby-compilation-executable . "ruby") (ruby-compilation-executable . "ruby1.8") (ruby-compilation-executable . "ruby1.9") (ruby-compilation-executable . "rbx") (ruby-compilation-executable . "jruby"))))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
