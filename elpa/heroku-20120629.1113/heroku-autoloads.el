;;; heroku-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (heroku-run heroku-sql) "heroku" "heroku.el" (20658
;;;;;;  29283))
;;; Generated autoloads from heroku.el

(autoload 'heroku-sql "heroku" "\
Run heroku pg:psql as an inferior process in an SQL buffer.

Enter app name when prompted for `database'.

\(fn &optional BUFFER)" t nil)

(autoload 'heroku-run "heroku" "\
Run a remote command on a given app using `shell'.

\(fn &optional PROMPT-APP)" t nil)

;;;***

;;;### (autoloads nil nil ("heroku-pkg.el") (20658 29283 801079))

;;;***

(provide 'heroku-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; heroku-autoloads.el ends here
