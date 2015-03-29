;;; -*- lexical-binding: t -*-
;;; jxx-orgmode.el --- OrgMode config

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

(setq org-directory "~/Dropbox/OrgFiles/")
(setq org-default-notes-file "~/Dropbox/OrgFiles/.notes")
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)
(define-key global-map "\C-cr" 'org-remember)

;; (setq org-capture-templates
;;       '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
;;              "* TODO %?\n  %i\n  %a")
;;         ("j" "Journal" entry (file+datetree "~/org/journal.org")
;;              "* %?\nEntered on %U\n  %i\n  %a")))

(setq org-remember-templates
      '(("Todo" ?t "* TODO %? %^g\n %i\n " "~/Dropbox/OrgFiles/tasks.org" "Office")
        ("Journal" ?j "\n* %^{topic} %T \n%i%?\n" "~/Dropbox/OrgFiles/journal.org")
        ("Log start" ?s "\n* %^{topic} %T :STARTED:" "~/Dropbox/OrgFiles/log.org")
        ("Log end" ?e "\n* %^{topic} %T :FINISHED:" "~/Dropbox/OrgFiles/log.org")
        ))

;; org-reveal
(setq org-reveal-root "https://cdn.jsdelivr.net/reveal.js/2.5.0/")

;; org-repo-todo
(global-set-key (kbd "C-c C-;") 'ort/capture-todo)
(global-set-key (kbd "C-c C-'") 'ort/goto-todos)

(provide 'jxx-orgmode)
;;; jxx-orgmode.el ends here
