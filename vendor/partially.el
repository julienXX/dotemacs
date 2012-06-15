;;; partially.el - rails partial tools

;; Copyright (C) 2011 Matt Briggs
;;
;; Author: Matt Briggs <matt@mattbriggs.net>
;; URL: http://github.com/mbriggs/rails-test-toggler
;; Version: 0.1
;; Keywords: rails

;; This file is not part of GNU Emacs.

;;; Commentary:

;; I like small, focused libraries. This one provides some functionality
;; around rails partials. Supports erb and haml

;; partially/visit-partial     - jump to the partial rendered on the current line
;; NOT DONE!! partially/extract-partial   - extract a partial, dump it in a file, and render it in the current file
;; NOT DONE!! partially/inline-partial    - fetch the partial rendered on the current line, and replace the render statement with it

;;; Installation:

;; This relies on a "find-root" function. It defaults to railway-find-root (my standalone rails minor mode),
;; but can easily be customized to anything

;; (setq partially:rails-root-fn 'rinari-root) ; use rinari function
;; (setq partially:rails-root-fn 'eproject-root) ; use eproject function
;; (setq partially:rails-root-fn 'projectile-get-project-root) ; use projectile function
;; (setq partially:rails-root-fn 'textmate-project-root) ; use textmate.el function


;; commands
(defun partially/visit-partial ()
  (interactive)
  (partially/search-paths (partially/partial-on-line)))

;; code
(defvar partially:rails-root-fn 'railway-root)
(defun partially/root ()
  (funcall partially:rails-root-fn))

(defun partially/partial-on-line ()
  (let ((str (partially/partial-string-on-line)))
    (when str
      (if (string-match "/\\([a-z\._]+\\)$" str)
          (partially/partialize-file-name-in-path (match-string 1 str) str)
        (concat "_" str)))))

(defun partially/partialize-file-name-in-path (file path)
  (replace-regexp-in-string file (concat "_" file) path))

(defun partially/partial-string-on-line ()
  (let ((line (buffer-substring (point-at-bol) (point-at-eol))))
    (if (string-match "partial\\(: +\\| +=> +\\)['\"]/?\\([a-z_0-9/]+\\)['\"]" line)
        (match-string 2 line)
      (message "could not find a partial declaration"))))

(defun partially/search-paths (path)
  (let ((current-dir (file-name-directory buffer-file-name))
        (root (partially/root)))
    (or (partially/find-file-if-present (concat current-dir path ".html.erb"))
        (partially/find-file-if-present (concat current-dir path ".rhtml"))
        (partially/find-file-if-present (concat current-dir path ".html.haml"))
        (partially/find-file-if-present (concat root "app/views/" path ".html.erb"))
        (partially/find-file-if-present (concat root "app/views/" path ".rhtml"))
        (partially/find-file-if-present (concat root "app/views/" path ".html.haml"))
        (message (concat "Could not find " path)))))

(defun partially/find-file-if-present (file)
  (if (file-exists-p file)
      (find-file file)))

(provide 'partially)
