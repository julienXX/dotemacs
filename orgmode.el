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
