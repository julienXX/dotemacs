;;; -*- lexical-binding: t -*-
;;; init.el --- Emacs main config

;; Copyright (C) 2015 Julien Blanchard

;; Author: Julien Blanchard <julien@sideburns.eu>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:


;; Setting path
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path `("/usr/local/bin")))

(setq make-backup-files nil)
(setq auto-save-default nil)

;; Free up the option key for special characters
(setq ns-alternate-modifier 'none)
(setq ns-command-modifier 'meta)
(setq ns-function-modifier 'super)

;; Save temp file in /tmp
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; stop opening a new frame (window) for each file
(setq ns-pop-up-frames nil)

;; Only one window on startup
(add-hook 'emacs-startup-hook
          (lambda () (delete-other-windows)) t)
(x-focus-frame nil)

;; Auto refresh buffers
(global-auto-revert-mode 1)

;; Tune GC
(setq gc-cons-threshold 20000000)

;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

;; load customizations
(add-to-list 'load-path "~/.emacs.d/modules")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

(load "jxx-libs")
(load "jxx-editing")
(load "jxx-complete")
(load "jxx-appearance")
(load "jxx-packages")
(load "jxx-functions")
(load "jxx-modes")
(load "jxx-hooks")
(load "jxx-ruby")
(load "jxx-clojure")
(load "jxx-haskell")
(load "jxx-rust")
(load "jxx-orgmode")
(load "jxx-mappings")
(load "jxx-helm")
(load "jxx-mode-line")

(eval-after-load 'magit '(require 'jxx-magit))

;; Shell variables on OSX
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Setting rbenv path
(setenv "PATH" (concat (getenv "HOME") "/.rbenv/shims:" (getenv "HOME") "/.rbenv/bin:" (getenv "PATH")))
(setq exec-path (cons (concat (getenv "HOME") "/.rbenv/shims") (cons (concat (getenv "HOME") "/.rbenv/bin") exec-path)))

(setq magit-last-seen-setup-instructions "1.4.0")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#292929" "#ff3333" "#006400" "#eab700" "#aaccff" "#FF1F69" "#104e8b" "#999999"])
 '(background-color "#202020")
 '(background-mode dark)
 '(column-number-mode t)
 '(cursor-color "#cccccc")
 '(custom-enabled-themes (quote (soft-morning)))
 '(custom-safe-themes
   (quote
    ("013e87003e1e965d8ad78ee5b8927e743f940c7679959149bbee9a15bd286689" "33c5a452a4095f7e4f6746b66f322ef6da0e770b76c0ed98a438e76c497040bb" "c7359bd375132044fe993562dfa736ae79efc620f68bab36bd686430c980df1c" "0ebe0307942b6e159ab794f90a074935a18c3c688b526a2035d14db1214cf69c" "ce79400f46bd76bebeba655465f9eadf60c477bd671cbcd091fe871d58002a88" "1989847d22966b1403bab8c674354b4a2adf6e03e0ffebe097a6bd8a32be1e19" "e26780280b5248eb9b2d02a237d9941956fc94972443b0f7aeec12b5c15db9f3" "bf648fd77561aae6722f3d53965a9eb29b08658ed045207fe32ffed90433eb52" "9bcb8ee9ea34ec21272bb6a2044016902ad18646bd09fdd65abae1264d258d89" "90b5269aefee2c5f4029a6a039fb53803725af6f5c96036dee5dc029ff4dff60" "50edb7914e8d369bc03820d2dcde7e74b7efe2af5a39511d3a130508e2f6ac8f" "c3fb7a13857e799bba450bb81b9101ef4960281c4d5908e05ecac9204c526c8a" "86f4407f65d848ccdbbbf7384de75ba320d26ccecd719d50239f2c36bec18628" "53e29ea3d0251198924328fd943d6ead860e9f47af8d22f0b764d11168455a8e" "29a4267a4ae1e8b06934fec2ee49472daebd45e1ee6a10d8ff747853f9a3e622" "7d4d00a2c2a4bba551fcab9bfd9186abe5bfa986080947c2b99ef0b4081cb2a6" "dc46381844ec8fcf9607a319aa6b442244d8c7a734a2625dac6a1f63e34bc4a6" "a774c5551bc56d7a9c362dca4d73a374582caedb110c201a09b410c0ebbb5e70" "a30d5f217d1a697f6d355817ac344d906bb0aae3e888d7abaa7595d5a4b7e2e3" "65ae93029a583d69a3781b26044601e85e2d32be8f525988e196ba2cb644ce6a" "543976df2de12eb2ac235c79c7bc1dac6c58f4a34ae6f72237d6e70d8384f37a" "5c8553ea57088a282ac6a8985fcb9acd7c8c685e2dbb567bbf42e382019ed9f9" "493823ded7c79e51ad01465285f79b65d9f679c8a87e34d1b4e1efb40e3adc1e" "07d70079b0ccdc3e56d85c21966087846a63c069a2111351e2b7f4b24208a1bf" "65e32706af483a385993553a69ddd086ee37859b6c46bc1a75680d7bf8361384" "7f58e51c396c94f616948079dc26a59ce3bd0c44dfb7e4138b123a614171e88f" "d44e401bd236d8029fe8da9e33ee9bce041c068eda603d8b5436da358435c6c5" "7f1263c969f04a8e58f9441f4ba4d7fb1302243355cb9faecb55aec878a06ee9" "e2a67a7143a2e7b9f72b1091112afb041ab25ae20931c9a1288db23bca24449b" "1b306c29e18369697644382112df726feec4a1db4913afa383e7c7d568e902d3" "e774825e7ee0aaa14191c23609e47483a31ab31c320a5fe893a700426d0ac2be" "fc22d1d3f42d6ed1eef00316a5a6f26ddcb2611f2b128947016fe0041ecfba21" "cf08ae4c26cacce2eebff39d129ea0a21c9d7bf70ea9b945588c1c66392578d1" "1157a4055504672be1df1232bed784ba575c60ab44d8e6c7b3800ae76b42f8bd" "9fd20670758db15cc4d0b4442a74543888d2e445646b25f2755c65dcd6f1504b" "752b605b3db4d76d7d8538bbc6fe8828f6d92a720c0ea334b4e01cea44d4b7a9" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "65e05a8630f98308e8e804d3bbc0232b02fe2e8d24c1db358479a85f3356198d" "ca3bf8a7c831776c77d09ded89f2f0993dbdd9cb0765d8db061d1ebff806f41c" "5bff694d9bd3791807c205d8adf96817ee1e572654f6ddc5e1e58b0488369f9d" "c9d00d43bd5ad4eb7fa4c0e865b666216dfac4584eede68fbd20d7582013a703" "5ce9c2d2ea2d789a7e8be2a095b8bc7db2e3b985f38c556439c358298827261c" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "3d6b08cd1b1def3cc0bc6a3909f67475e5612dba9fa98f8b842433d827af5d30" "7feeed063855b06836e0262f77f5c6d3f415159a98a9676d549bfeb6c49637c4" "7bc53c2f13ad0de4f1df240fde8fe3d5f11989944c69f9e02f2bd3da9ebbdcd9" "4ddc42a539280ec21ae202b6c12a4d7ce7d7af8a19e8c344b60b09f1ca1496d5" "b6f7795c2fbf75baf3419c60ef7625154c046fc2b10e3fdd188e5757e08ac0ec" "ea0c5df0f067d2e3c0f048c1f8795af7b873f5014837feb0a7c8317f34417b04" "2e60db7f24913de7cea9d719dc25fcf6b45682bef4693e35aec88aed3da1443e" "06f5145c01ec774a0abb49eeffa3980743ce2f997112b537effeb188b7c51caf" "38c4fb6c8b2625f6307f3dde763d5c61d774d854ecee9c5eb9c5433350bc0bef" "967c58175840fcea30b56f2a5a326b232d4939393bed59339d21e46cf4798ecf" "75d4ccc5e912b93f722e57cca3ca1a15e079032cd69fd9bc67268b4c85639663" "88d556f828e4ec17ac074077ef9dcaa36a59dccbaa6f2de553d6528b4df79cbd" "e5a32add82d288d27323f9cbb9f78e3da3949bdc6283073cb98ae1dc712b6b71" "5f7044d9fc9c9c9d56508ac8217483c8358a191599448859640ce80be92acbd6" "77bd459212c0176bdf63c1904c4ba20fce015f730f0343776a1a14432de80990" "c1fb68aa00235766461c7e31ecfc759aa2dd905899ae6d95097061faeb72f9ee" "e9a1226ffed627ec58294d77c62aa9561ec5f42309a1f7a2423c6227e34e3581" "4be2645396d79e94d37867be5a7f41b66e05fa81c5b266d705a7edd7fb785302" "501caa208affa1145ccbb4b74b6cd66c3091e41c5bb66c677feda9def5eab19c" default)))
 '(fci-rule-character-color "#192028")
 '(fci-rule-color "#073642")
 '(foreground-color "#cccccc")
 '(fringe-mode nil)
 '(hl-paren-background-colors (quote ("#2492db" "#95a5a6" nil)))
 '(hl-paren-colors (quote ("#ecf0f1" "#ecf0f1" "#c0392b")))
 '(indicate-buffer-boundaries (quote right))
 '(indicate-empty-lines t)
 '(linum-format "%3i")
 '(powerline-color1 "#3d3d68")
 '(popwin:special-display-config
   (quote
    (("*rspec-compilation*" :noselect t)
     ("*Miniedit Help*" :noselect t)
     (help-mode)
     (completion-list-mode :noselect t)
     (compilation-mode :noselect t)
     (grep-mode :noselect t)
     (occur-mode :noselect t)
     ("*Pp Macroexpand Output*" :noselect t)
     ("*Shell Command Output*")
     ("*vc-diff*")
     ("*vc-change-log*")
     (" *undo-tree*" :width 60 :position right)
     ("^\\*anything.*\\*$" :regexp t)
     ("*slime-apropos*")
     ("*slime-macroexpansion*")
     ("*slime-description*")
     ("*slime-compilation*" :noselect t)
     ("*slime-xref*")
     (sldb-mode :stick t)
     (slime-repl-mode)
     (slime-connection-list-mode))))
 '(powerline-color2 "#292945")
 '(safe-local-variable-values
   (quote
    ((encoding . utf-8)
     (ruby-compilation-executable . "ruby")
     (ruby-compilation-executable . "ruby1.8")
     (ruby-compilation-executable . "ruby1.9")
     (ruby-compilation-executable . "rbx")
     (ruby-compilation-executable . "jruby"))))
 '(show-paren-mode t)
 '(sml/active-background-color "#34495e")
 '(sml/active-foreground-color "#ecf0f1")
 '(sml/inactive-background-color "#dfe4ea")
 '(sml/inactive-foreground-color "#34495e")
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#cc6666")
     (40 . "#de935f")
     (60 . "#f0c674")
     (80 . "#b5bd68")
     (100 . "#8abeb7")
     (120 . "#81a2be")
     (140 . "#b294bb")
     (160 . "#cc6666")
     (180 . "#de935f")
     (200 . "#f0c674")
     (220 . "#b5bd68")
     (240 . "#8abeb7")
     (260 . "#81a2be")
     (280 . "#b294bb")
     (300 . "#cc6666")
     (320 . "#de935f")
     (340 . "#f0c674")
     (360 . "#b5bd68"))))
 '(vc-annotate-very-old-color nil))

(provide 'init)
;;; init.el ends here
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-candidate-number ((t nil)))
 '(helm-header ((t nil)))
 '(helm-selection ((t (:background "#dd6767" :foreground "#eeeeee"))))
 '(helm-source-header ((t (:background "#A9C5C3" :foreground "black" :weight bold :height 1.3 :family "Sans Serif"))))
 '(show-paren-match ((t (:background "yellow")))))


(provide 'init)
;;; init.el ends here
