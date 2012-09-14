;;; ctags-update-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (ctags-auto-update-mode ctags-update) "ctags-update"
;;;;;;  "ctags-update.el" (20563 9086))
;;; Generated autoloads from ctags-update.el

(autoload 'ctags-update "ctags-update" "\
update TAGS in parent directory using `exuberant-ctags' you
can call this function directly , or enable
`ctags-auto-update-mode' or with prefix `C-u' then you can
generate a new TAGS file in directory

\(fn &optional ARGS)" t nil)

(defvar ctags-auto-update-mode t "\
Non-nil if Ctags-Auto-Update mode is enabled.
See the command `ctags-auto-update-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `ctags-auto-update-mode'.")

(custom-autoload 'ctags-auto-update-mode "ctags-update" nil)

(autoload 'ctags-auto-update-mode "ctags-update" "\
auto update TAGS using `exuberant-ctags' in parent directory.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil nil ("ctags-update-pkg.el") (20563 9086 987639))

;;;***

(provide 'ctags-update-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; ctags-update-autoloads.el ends here
