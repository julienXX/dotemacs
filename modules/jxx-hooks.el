;;; jxx-hooks.el --- Various hooks

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

;; Line numbers
(add-hook 'eshell-mode-hook
          '(lambda () (display-line-numbers-mode -1)))

(add-hook 'compilation-mode-hook
          '(lambda () (display-line-numbers-mode -1)))

(add-hook 'dired-mode-hook
          '(lambda () (display-line-numbers-mode -1)))

(add-hook 'shell-mode-hook
          '(lambda () (display-line-numbers-mode -1)))

(add-hook 'magit-mode-hook
          '(lambda () (display-line-numbers-mode -1)))

;; SLIME hooks
(add-hook 'sldb-mode-hook
          #'(lambda ()
              (autopair-mode -1)))

;; Delete trailing whitespaces
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Rainbow mode hooks
(add-hook 'css-mode-hook 'rainbow-mode)
(add-hook 'scss-mode-hook 'rainbow-mode)
(add-hook 'sass-mode-hook 'rainbow-mode)

;; C-d to exit shell
(defun comint-delchar-or-eof-or-kill-buffer (arg)
  (interactive "p")
  (if (null (get-buffer-process (current-buffer)))
      (kill-buffer)
    (comint-delchar-or-maybe-eof arg)))

(add-hook 'shell-mode-hook
          (lambda ()
            (define-key shell-mode-map
              (kbd "C-d") 'comint-delchar-or-eof-or-kill-buffer)))

(add-hook 'markdown-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c o p") 'jxx-markdown-preview)))

;; FlyCheck
(add-hook 'after-init-hook #'global-flycheck-mode)


(provide 'jxx-hooks)
;;; jxx-hooks.el ends here
