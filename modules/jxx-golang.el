;;; jxx-golang.el --- Golang setup

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

(require 'use-package)

(use-package go-mode
  :ensure t
  :config
  (require 'go-guru)
  (require 'flymake-go)
  (require 'go-autocomplete)
  (add-hook 'before-save-hook 'gofmt-before-save)
  (setq gofmt-command "goimports")
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))

  ;; guru settings
  (go-guru-hl-identifier-mode)

  ;; Key bindings specific to go-mode
  (add-hook 'go-mode-hook
            (lambda ()
              (local-set-key (kbd "M-.") 'godef-jump)
              (local-set-key (kbd "M-*") 'pop-tag-mark)
              (local-set-key (kbd "M-p") 'compile)
              (local-set-key (kbd "M-P") 'recompile)
              (local-set-key (kbd "M-]") 'next-error)
              (local-set-key (kbd "M-[") 'previous-error))))

(provide 'jxx-golang)
;;; jxx-golang.el ends here
