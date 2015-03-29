;;; -*- lexical-binding: t -*-
;;; jxx-packages.el --- Generic Packages config

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

;;; Code:

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

;; CTags
(require 'ctags-update)
(autoload 'turn-on-ctags-auto-update-mode "ctags-update" "turn on `ctags-auto-update-mode'." t)
(add-hook 'prog-mode-hook  'turn-on-ctags-auto-update-mode)

;; Gists
(require 'eieio)
(require 'gist)
(setq gist-use-curl t)
(setq gist-view-gist t)

;; ace-jump-mode
(require 'ace-jump-mode)
  (define-key global-map (kbd "C-c j") 'ace-jump-mode)

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

;; Golden ration
(require 'golden-ratio)
(defun pl/helm-alive-p ()
  (if (boundp 'helm-alive-p)
      (symbol-value 'helm-alive-p)))

(add-to-list 'golden-ratio-inhibit-functions 'pl/helm-alive-p)
(golden-ratio-mode)

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
(projectile-global-mode)
(setq projectile-enable-caching t)

;; Anzu mode
(global-anzu-mode +1)

;;; unkillable scratch buffer
(unkillable-scratch 1)

(provide 'jxx-packages)
;;; jxx-packages.el ends here
