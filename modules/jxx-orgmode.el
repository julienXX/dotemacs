;;; jxx-orgmode.el --- OrgMode config

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
(use-package org
  :ensure t
  :defer t
  :config
  (setq org-reverse-note-order t)

  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline "~/todo.org" "Tasks")
           "* TODO %?" :prepend t)
          ("l" "Todo with link" entry (file+headline "~/todo.org" "Tasks")
           "* TODO %?\n  %i\n  %a" :prepend t)
          ("j" "Journal" entry (file+datetree "~/journal.org")
               "* %?\nEntered on %U\n  %i\n  %a")))

  ;; org-reveal
  (setq org-reveal-root "https://cdn.jsdelivr.net/reveal.js/2.5.0/")

  ;; org-repo-todo
  (global-set-key (kbd "C-c t") 'counsel-org-capture)
  (global-set-key (kbd "C-c C-'") 'ort/goto-todos))

(provide 'jxx-orgmode)
;;; jxx-orgmode.el ends here
