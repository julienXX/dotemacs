;;; lui-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (disable-lui-autopaste enable-lui-autopaste) "lui-autopaste"
;;;;;;  "lui-autopaste.el" (21103 36978 0 0))
;;; Generated autoloads from lui-autopaste.el

(autoload 'enable-lui-autopaste "lui-autopaste" "\
Enable the lui autopaste feature.

If you enter more than `lui-autopaste-lines' at once, Lui will
ask if you would prefer to use a paste service instead. If you
agree, Lui will paste your input to `lui-autopaste-function' and
replace it with the resulting URL.

\(fn)" t nil)

(autoload 'disable-lui-autopaste "lui-autopaste" "\
Disable the lui autopaste feature.

\(fn)" t nil)

;;;***

;;;### (autoloads (enable-lui-irc-colors) "lui-irc-colors" "lui-irc-colors.el"
;;;;;;  (21103 36978 0 0))
;;; Generated autoloads from lui-irc-colors.el

(autoload 'enable-lui-irc-colors "lui-irc-colors" "\
Enable IRC color interpretation for Lui.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("lui-format.el" "lui-logging.el" "lui-pkg.el"
;;;;;;  "lui.el") (21103 36978 167685 0))

;;;***

(provide 'lui-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; lui-autoloads.el ends here
