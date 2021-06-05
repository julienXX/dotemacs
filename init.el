(defvar as/init-dir "~/.emacs.d")

;; this is where to put elisp libraries from the Internet (including
;; my own)
(add-to-list 'load-path (expand-file-name "lib" as/init-dir))

;; load all the *-conf.el files, in order
(dolist (file (directory-files (concat as/init-dir "/config")
			       t "-conf\\.el\\'"))
  (load-file file))

(setq inhibit-startup-screen t)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
