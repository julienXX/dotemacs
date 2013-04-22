;;; emr-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (emr-show-refactor-menu emr-declare-action) "emr"
;;;;;;  "emr.el" (20853 44617 0 0))
;;; Generated autoloads from emr.el

(autoload 'emr-declare-action "emr" "\
Define a refactoring command.
FUNCTION is the refactoring command to perform.
MODE is the major mode in which this
TITLE is the name of the command that will be displayed in the popup menu.
PREDICATE is a condition that must be satisfied to display this item.
If PREDICATE is not supplied, the item will always be visible for this mode.
DESCRIPTION is shown to the left of the titile in the popup menu.

\(fn FUNCTION MODE TITLE &key (predicate t) DESCRIPTION)" nil (quote macro))

(autoload 'emr-show-refactor-menu "emr" "\
Show the extraction menu at point.

\(fn)" t nil)

;;;***

;;;### (autoloads (emr-delete-let-binding-form emr-inline-let-variable
;;;;;;  emr-extract-to-let emr-implement-function emr-comment-form
;;;;;;  emr-extract-autoload emr-extract-constant emr-extract-variable
;;;;;;  emr-extract-function emr-eval-and-replace emr-inline-variable)
;;;;;;  "emr-elisp" "emr-elisp.el" (20853 44616 0 0))
;;; Generated autoloads from emr-elisp.el

(autoload 'emr-inline-variable "emr-elisp" "\
Inline the variable defined at point.
Uses of the variable are replaced with the initvalue in the variable definition.

\(fn)" t nil)

(autoload 'emr-eval-and-replace "emr-elisp" "\
Replace the current region or the form at point with its value.

\(fn)" t nil)

(autoload 'emr-extract-function "emr-elisp" "\
Extract a function, using the current region or form point as the body.
NAME is the name of the new function.
ARGLIST is its argument list.

\(fn NAME ARGLIST)" t nil)

(autoload 'emr-extract-variable "emr-elisp" "\
Extract the current region or form at point to a special variable.
The variable will be called NAME.

\(fn NAME)" t nil)

(autoload 'emr-extract-constant "emr-elisp" "\
Extract the current region or form at point to a constant special variable.
The variable will be called NAME.

\(fn NAME)" t nil)

(autoload 'emr-extract-autoload "emr-elisp" "\
Create an autoload for FUNCTION.
FILE is the file that declares FUNCTION.
See `autoload' for details.

\(fn FUNCTION FILE)" t nil)

(autoload 'emr-comment-form "emr-elisp" "\
Comment out the current region or from at point.

\(fn)" t nil)

(autoload 'emr-implement-function "emr-elisp" "\
Create a function definition for the symbol at point.
The function will be called NAME and have the given ARGLIST.

\(fn NAME ARGLIST)" t nil)

(autoload 'emr-extract-to-let "emr-elisp" "\
Extract the current region or form at point into a let-bound variable.
A let form will be created if one does not exist.
The expression will be bound to SYMBOL.

\(fn SYMBOL)" t nil)

(autoload 'emr-inline-let-variable "emr-elisp" "\
Inlines the let-bound variable at point.

\(fn SYMBOL)" t nil)

(autoload 'emr-delete-let-binding-form "emr-elisp" "\
Delete the let binding around point.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("emr-pkg.el") (20853 44617 72229 0))

;;;***

(provide 'emr-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; emr-autoloads.el ends here
