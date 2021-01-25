;;; jxx-packages.el --- Generic Packages config

;; Copyright (C) 2017 Julien Blanchard

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

(require 'use-package)

(use-package flx-ido
  :ensure t
  :config
  (require 'flx-ido)
  (ido-mode 1)
  (ido-everywhere 1)
  (flx-ido-mode 1)
  ;; disable ido faces to see flx highlights.
  (setq ido-use-faces nil))

(use-package smex
  :ensure t
  :config
  (smex-initialize)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command))

(use-package smartparens
  :ensure t
  :config
  (require 'smartparens-config)
  (require 'smartparens-ruby)
  (smartparens-global-mode t)
  (show-smartparens-global-mode t)
  (sp-local-pair 'minibuffer-inactive-mode "'" nil :actions nil)

    ;;; markdown-mode
  (sp-with-modes '(markdown-mode gfm-mode rst-mode)
    (sp-local-pair "*" "*" :bind "C-*")
    (sp-local-tag "2" "**" "**")
    (sp-local-tag "s" "```scheme" "```")
    (sp-local-tag "<"  "<_>" "</_>" :transform 'sp-match-sgml-tags))

    ;;; tex-mode latex-mode
  (sp-with-modes '(tex-mode plain-tex-mode latex-mode)
    (sp-local-tag "i" "\"<" "\">"))

    ;;; html-mode
  (sp-with-modes '(html-mode sgml-mode web-mode)
    (sp-local-pair "<" ">"))

    ;;; lisp modes
  (sp-with-modes sp--lisp-modes
    ;; disable ', it's the quote character!
    (sp-local-pair "'" nil :actions nil)
    ;; also only use the pseudo-quote inside strings where it serve as
    ;; hyperlink.
    (sp-local-pair "`" "'" :when '(sp-in-string-p sp-in-comment-p))
    (sp-local-pair "`" nil
                   :skip-match (lambda (ms mb me)
                                 (cond
                                  ((equal ms "'")
                                   (or (sp--org-skip-markup ms mb me)
                                       (not (sp-point-in-string-or-comment))))
                                  (t (not (sp-point-in-string-or-comment)))))))

  (sp-with-modes '(rhtml-mode)
    (sp-local-pair "<" ">")
    (sp-local-pair "<%" "%>")))

(use-package yasnippet
  :ensure t
  :config
  (setq yas-snippets-dir
        '("~/.emacs.d/snippets"))
  (yas-global-mode 1))

;; auto-complete
;; (require 'auto-complete-config)
;; (ac-config-default)
;; (setq ac-ignore-case nil)
;; (add-to-list 'ac-modes 'enh-ruby-mode)
;; (add-to-list 'ac-modes 'web-mode)

(use-package gist
  :ensure t
  :config
  (require 'eieio)
  (setq gist-use-curl t)
  (setq gist-view-gist t))

(use-package ace-jump-mode
  :ensure t
  :config
  (define-key global-map (kbd "C-c j") 'ace-jump-mode))

(use-package multi-term
  :ensure t
  :config
  (set-terminal-coding-system 'utf-8-unix)
  (setq multi-term-dedicated-select-after-open-p t)
  (setq multi-term-program "/bin/zsh")
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
    ))

(use-package golden-ratio
  :ensure t
  :config
  (golden-ratio-mode))

(use-package dired-details
  :ensure t
  :config
  (setq-default dired-details-hidden-string "--- ")
  (dired-details-install)
  (setq insert-directory-program "/bin/ls" dired-use-ls-dired t))

(use-package markdown-mode
  :ensure t
  :config
  (autoload 'markdown-mode "markdown-mode.el"
    "Major mode for editing Markdown files" t))

(use-package git-gutter
  :ensure t
  :config
  (global-git-gutter-mode t)
  (setq git-gutter:modified-sign "<> ")
  (setq git-gutter:added-sign "++ ")
  (setq git-gutter:deleted-sign "-- "))

(use-package projectile
  :ensure t
  :config
  (projectile-mode)
  (setq projectile-enable-caching t)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(use-package anzu
  :ensure t
  :config
  (global-anzu-mode +1))

(use-package unkillable-scratch
  :ensure t
  :config
  (unkillable-scratch 1))

(use-package popwin
  :ensure t
  :defer t
  :config
  (popwin-mode 1))

(use-package twittering-mode
  :ensure t
  :defer t
  :config
  (setq twittering-use-master-password t)
  (setq twittering-icon-mode t))

(provide 'jxx-packages)
;;; jxx-packages.el ends here
