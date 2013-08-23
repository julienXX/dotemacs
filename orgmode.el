(setq org-directory "~/orgfiles/")
(setq org-default-notes-file "~/.notes")
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)
(define-key global-map "\C-cr" 'org-remember)

(setq org-remember-templates
      '(("Todo" ?t "* TODO %? %^g\n %i\n " "F:/GTD/newgtd.org" "Office")
        ("Journal" ?j "\n* %^{topic} %T \n%i%?\n" "L:journal.org")
        ("Book" ?b "\n* %^{Book Title} %t :READING: \n%[l:/booktemp.txt]\n"
         "L:journal.org")
        ("Private" ?p "\n* %^{topic} %T \n%i%?\n" "F:/gtd/privnotes.org")
        ("Contact" ?c "\n* %^{Name} :CONTACT:\n%[l:/contemp.txt]\n"
         "F:/gtd/privnotes.org")
        ))
