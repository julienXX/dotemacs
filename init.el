;;; init.el --- Emacs main config

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

;;; Commentary:

;;; Code:

(package-initialize)

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

(require 'cask "/usr/local/share/emacs/site-lisp/cask/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

(unless package-archive-contents (package-refresh-contents))

(let ((pkg 'use-package))
  (unless (package-installed-p pkg)
    (package-install pkg)))

(defun load-directory (dir)
  "`load' all elisp libraries in directory DIR which are not already loaded."
  (interactive "D")
  (let ((libraries-loaded (mapcar #'file-name-sans-extension
                                  (delq nil (mapcar #'car load-history)))))
    (dolist (file (directory-files dir t ".+\\.elc?$"))
      (let ((library (file-name-sans-extension file)))
        (unless (member library libraries-loaded)
          (load library nil t)
          (push library libraries-loaded))))))

(load-directory "~/.emacs.d/modules/")
(eval-after-load 'magit '(require 'jxx-magit))

;; Shell variables on OSX
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Setting rbenv path
(setenv "PATH" (concat (getenv "HOME") "/.rbenv/shims:" (getenv "HOME") "/.rbenv/bin:" (getenv "PATH")))
(setq exec-path (cons (concat (getenv "HOME") "/.rbenv/shims") (cons (concat (getenv "HOME") "/.rbenv/bin") exec-path)))

;; (setq magit-last-seen-setup-instructions "1.4.0")

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)


(provide 'init)
;;; init.el ends here
