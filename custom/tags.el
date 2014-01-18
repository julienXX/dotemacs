(require 'magit)

(defun set-local-tags-file-name ()
  (interactive)
  "If the current file is a git project (but not the home
   directory), make .git/tags the default tag file location."
  (let* ((top-dir (magit-get-top-dir))
         (home-dir (expand-file-name "~/"))
         (tag-file (format "%s.git/tags" top-dir)))
    (when (and top-dir
               (not (string-equal top-dir home-dir)))
      (setq-local tags-file-name tag-file)
      (message "Local tags file set to: %s" tags-file-name))))

(defun regenerate-project-tags ()
  "If `tags-file-name' is set, regenerate the tags file."
  (interactive)
  (when tags-file-name
    (call-process "ctags" nil nil nil
                  "-Re"
                  "--exclude=.git"
                  "--exclude='.#*'"
                  (format "-f %s" tags-file-name)
                  (magit-get-top-dir))
    (message "Tags file regenerated at: %s" tags-file-name)))

;; Whenever a new file is found, set the tags-file-name.
(add-hook 'find-file-hook 'set-local-tags-file-name)

;; Whenever a file is saved, (potentially) regenerate the tags.
(add-hook 'after-save-hook 'regenerate-project-tags)

;; If the tags file is rewritten, don't prompt me, just pick up the changes.
(setq tags-revert-without-query t)
