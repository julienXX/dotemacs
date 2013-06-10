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

;; Set Frame title with file path
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

;; Add external projects to load path
(dolist (project (directory-files "~/.emacs.d/vendor" t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

(load "packages")
(load "functions")
(load "modes")
(load "hooks")
(load "mappings")

(eval-after-load 'magit '(require 'setup-magit))
(eval-after-load 'erc '(load "erc-settings"))
(eval-after-load 'jabber '(load "jabber-settings"))
(eval-after-load 'circe '(load "circe-settings"))

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
 '(background-color "#202020")
 '(background-mode dark)
 '(column-number-mode t)
 '(cursor-color "#cccccc")
 '(custom-enabled-themes (quote (subatomic)))
 '(custom-safe-themes (quote ("1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "3d6b08cd1b1def3cc0bc6a3909f67475e5612dba9fa98f8b842433d827af5d30" "7feeed063855b06836e0262f77f5c6d3f415159a98a9676d549bfeb6c49637c4" "7bc53c2f13ad0de4f1df240fde8fe3d5f11989944c69f9e02f2bd3da9ebbdcd9" "4ddc42a539280ec21ae202b6c12a4d7ce7d7af8a19e8c344b60b09f1ca1496d5" "b6f7795c2fbf75baf3419c60ef7625154c046fc2b10e3fdd188e5757e08ac0ec" "ea0c5df0f067d2e3c0f048c1f8795af7b873f5014837feb0a7c8317f34417b04" "2e60db7f24913de7cea9d719dc25fcf6b45682bef4693e35aec88aed3da1443e" "06f5145c01ec774a0abb49eeffa3980743ce2f997112b537effeb188b7c51caf" "38c4fb6c8b2625f6307f3dde763d5c61d774d854ecee9c5eb9c5433350bc0bef" "967c58175840fcea30b56f2a5a326b232d4939393bed59339d21e46cf4798ecf" "75d4ccc5e912b93f722e57cca3ca1a15e079032cd69fd9bc67268b4c85639663" "88d556f828e4ec17ac074077ef9dcaa36a59dccbaa6f2de553d6528b4df79cbd" "e5a32add82d288d27323f9cbb9f78e3da3949bdc6283073cb98ae1dc712b6b71" "5f7044d9fc9c9c9d56508ac8217483c8358a191599448859640ce80be92acbd6" "77bd459212c0176bdf63c1904c4ba20fce015f730f0343776a1a14432de80990" "c1fb68aa00235766461c7e31ecfc759aa2dd905899ae6d95097061faeb72f9ee" "e9a1226ffed627ec58294d77c62aa9561ec5f42309a1f7a2423c6227e34e3581" "4be2645396d79e94d37867be5a7f41b66e05fa81c5b266d705a7edd7fb785302" "501caa208affa1145ccbb4b74b6cd66c3091e41c5bb66c677feda9def5eab19c" default)))
 '(erc-away-nickname "(away)")
 '(erc-modules (quote (autojoin completion ring smiley stamp hl-nicks image fill list services netsplit button match track readonly networks noncommands irccontrols move-to-prompt stamp menu)))
 '(erc-nick nil)
 '(erc-prompt-for-password nil)
 '(fci-rule-character-color "#192028")
 '(fci-rule-color "#073642")
 '(foreground-color "#cccccc")
 '(fringe-mode nil nil (fringe))
 '(indicate-buffer-boundaries (quote right))
 '(indicate-empty-lines t)
 '(jabber-auto-reconnect t)
 '(jabber-avatar-verbose nil)
 '(jabber-chat-buffer-format "*-jabber-%n-*")
 '(jabber-history-enabled t)
 '(jabber-mode-line-mode t)
 '(jabber-roster-buffer "*-jabber-*")
 '(jabber-roster-line-format " %c %-25n %u %-8s (%r)")
 '(jabber-show-offline-contacts nil)
 '(jabber-use-global-history t)
 '(jabber-vcard-avatars-retrieve nil)
 '(powerline-default-separator (quote zigzag))
 '(safe-local-variable-values (quote ((encoding . utf-8) (ruby-compilation-executable . "ruby") (ruby-compilation-executable . "ruby1.8") (ruby-compilation-executable . "ruby1.9") (ruby-compilation-executable . "rbx") (ruby-compilation-executable . "jruby"))))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(erc-timestamp-face ((t (:foreground "gainsboro" :weight bold))) t)
 '(jabber-activity-face ((t (:foreground "firebrick" :weight bold))) t)
 '(jabber-activity-personal-face ((t (:foreground "blue" :weight bold))) t))

(provide 'init)
;;; init.el ends here
