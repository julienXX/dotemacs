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
(setq linum-format " %3d ")

;; stop opening a new frame (window) for each file
(setq ns-pop-up-frames nil)

;; Only one window on startup
(add-hook 'emacs-startup-hook
          (lambda () (delete-other-windows)) t)

;; Auto refresh buffers
(global-auto-revert-mode 1)

;; Tune GC
(setq gc-cons-threshold 20000000)

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

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

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

(load-theme 'mesa)

(load "mode-line")

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
 '(ansi-color-faces-vector [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector ["#292929" "#ff3333" "#006400" "#eab700" "#aaccff" "#FF1F69" "#104e8b" "#999999"])
 '(background-color "#202020")
 '(background-mode dark)
 '(column-number-mode t)
 '(cursor-color "#cccccc")
 '(custom-safe-themes (quote ("493823ded7c79e51ad01465285f79b65d9f679c8a87e34d1b4e1efb40e3adc1e" "07d70079b0ccdc3e56d85c21966087846a63c069a2111351e2b7f4b24208a1bf" "65e32706af483a385993553a69ddd086ee37859b6c46bc1a75680d7bf8361384" "7f58e51c396c94f616948079dc26a59ce3bd0c44dfb7e4138b123a614171e88f" "d44e401bd236d8029fe8da9e33ee9bce041c068eda603d8b5436da358435c6c5" "7f1263c969f04a8e58f9441f4ba4d7fb1302243355cb9faecb55aec878a06ee9" "e2a67a7143a2e7b9f72b1091112afb041ab25ae20931c9a1288db23bca24449b" "1b306c29e18369697644382112df726feec4a1db4913afa383e7c7d568e902d3" "e774825e7ee0aaa14191c23609e47483a31ab31c320a5fe893a700426d0ac2be" "fc22d1d3f42d6ed1eef00316a5a6f26ddcb2611f2b128947016fe0041ecfba21" "cf08ae4c26cacce2eebff39d129ea0a21c9d7bf70ea9b945588c1c66392578d1" "1157a4055504672be1df1232bed784ba575c60ab44d8e6c7b3800ae76b42f8bd" "9fd20670758db15cc4d0b4442a74543888d2e445646b25f2755c65dcd6f1504b" "752b605b3db4d76d7d8538bbc6fe8828f6d92a720c0ea334b4e01cea44d4b7a9" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "65e05a8630f98308e8e804d3bbc0232b02fe2e8d24c1db358479a85f3356198d" "ca3bf8a7c831776c77d09ded89f2f0993dbdd9cb0765d8db061d1ebff806f41c" "5bff694d9bd3791807c205d8adf96817ee1e572654f6ddc5e1e58b0488369f9d" "c9d00d43bd5ad4eb7fa4c0e865b666216dfac4584eede68fbd20d7582013a703" "5ce9c2d2ea2d789a7e8be2a095b8bc7db2e3b985f38c556439c358298827261c" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "3d6b08cd1b1def3cc0bc6a3909f67475e5612dba9fa98f8b842433d827af5d30" "7feeed063855b06836e0262f77f5c6d3f415159a98a9676d549bfeb6c49637c4" "7bc53c2f13ad0de4f1df240fde8fe3d5f11989944c69f9e02f2bd3da9ebbdcd9" "4ddc42a539280ec21ae202b6c12a4d7ce7d7af8a19e8c344b60b09f1ca1496d5" "b6f7795c2fbf75baf3419c60ef7625154c046fc2b10e3fdd188e5757e08ac0ec" "ea0c5df0f067d2e3c0f048c1f8795af7b873f5014837feb0a7c8317f34417b04" "2e60db7f24913de7cea9d719dc25fcf6b45682bef4693e35aec88aed3da1443e" "06f5145c01ec774a0abb49eeffa3980743ce2f997112b537effeb188b7c51caf" "38c4fb6c8b2625f6307f3dde763d5c61d774d854ecee9c5eb9c5433350bc0bef" "967c58175840fcea30b56f2a5a326b232d4939393bed59339d21e46cf4798ecf" "75d4ccc5e912b93f722e57cca3ca1a15e079032cd69fd9bc67268b4c85639663" "88d556f828e4ec17ac074077ef9dcaa36a59dccbaa6f2de553d6528b4df79cbd" "e5a32add82d288d27323f9cbb9f78e3da3949bdc6283073cb98ae1dc712b6b71" "5f7044d9fc9c9c9d56508ac8217483c8358a191599448859640ce80be92acbd6" "77bd459212c0176bdf63c1904c4ba20fce015f730f0343776a1a14432de80990" "c1fb68aa00235766461c7e31ecfc759aa2dd905899ae6d95097061faeb72f9ee" "e9a1226ffed627ec58294d77c62aa9561ec5f42309a1f7a2423c6227e34e3581" "4be2645396d79e94d37867be5a7f41b66e05fa81c5b266d705a7edd7fb785302" "501caa208affa1145ccbb4b74b6cd66c3091e41c5bb66c677feda9def5eab19c" default)))
 '(fci-rule-character-color "#192028")
 '(fci-rule-color "#073642")
 '(foreground-color "#cccccc")
 '(fringe-mode (quote (4 . 4)) nil (fringe))
 '(indicate-buffer-boundaries (quote right))
 '(indicate-empty-lines t)
 '(safe-local-variable-values (quote ((encoding . utf-8) (ruby-compilation-executable . "ruby") (ruby-compilation-executable . "ruby1.8") (ruby-compilation-executable . "ruby1.9") (ruby-compilation-executable . "rbx") (ruby-compilation-executable . "jruby"))))
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map (quote ((20 . "#cc6666") (40 . "#de935f") (60 . "#f0c674") (80 . "#b5bd68") (100 . "#8abeb7") (120 . "#81a2be") (140 . "#b294bb") (160 . "#cc6666") (180 . "#de935f") (200 . "#f0c674") (220 . "#b5bd68") (240 . "#8abeb7") (260 . "#81a2be") (280 . "#b294bb") (300 . "#cc6666") (320 . "#de935f") (340 . "#f0c674") (360 . "#b5bd68"))))
 '(vc-annotate-very-old-color nil))

(provide 'init)
;;; init.el ends here
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
