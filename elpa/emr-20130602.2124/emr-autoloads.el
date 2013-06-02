;;; emr-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (emr-show-refactor-menu emr-declare-action emr-initialize)
;;;;;;  "emr" "emr.el" (20907 20163 0 0))
;;; Generated autoloads from emr.el

(autoload 'emr-initialize "emr" "\
Activate language support for EMR.

\(fn)" nil nil)

(autoload 'emr-declare-action "emr" "\
Define a refactoring command.

* FUNCTION is the refactoring command to perform.

* MODE is the major mode in which this command will be
  available. Includes derived modes.

* TITLE is the name of the command that will be displayed in the popup menu.

* PREDICATE is a condition that must be satisfied to display this item.
If PREDICATE is not supplied, the item will always be visible for this mode.

* DESCRIPTION is shown to the left of the title in the popup menu.

\(fn FUNCTION &key MODES TITLE (predicate t) DESCRIPTION)" nil (quote macro))

(autoload 'emr-show-refactor-menu "emr" "\
Show the refactor menu at point.

\(fn)" t nil)

;;;***

;;;### (autoloads (emr-c-introduce-variable emr-c-introduce-variable-from-literal
;;;;;;  emr-c-extract-function-from-expression emr-c-extract-function)
;;;;;;  "emr-c" "emr-c.el" (20907 20163 0 0))
;;; Generated autoloads from emr-c.el

(autoload 'emr-c-extract-function "emr-c" "\
Extract the current region as a new function.
* NAME is the name of the function to create.
* RETURN is the return type.
* ARGLIST is the argument list.

\(fn NAME RETURN ARGLIST)" t nil)

(autoload 'emr-c-extract-function-from-expression "emr-c" "\
Extract a function from right side of the assignment at point.
If there is no assignment, extract the whole line.

\(fn)" t nil)

(autoload 'emr-c-introduce-variable-from-literal "emr-c" "\
Introduce a new variable from the literal at point.

\(fn)" t nil)

(autoload 'emr-c-introduce-variable "emr-c" "\
Create a variable with NAME and replace the region with a reference to it.
Prompt for a TYPE if it cannot be inferred.

\(fn NAME TYPE)" t nil)

;;;***

;;;### (autoloads (emr-el-inline-function emr-el-inline-let-variable
;;;;;;  emr-el-extract-to-let emr-el-delete-let-binding-form emr-el-comment-form
;;;;;;  emr-el-extract-autoload emr-el-extract-constant emr-el-extract-variable
;;;;;;  emr-el-implement-function emr-el-extract-function emr-el-eval-and-replace
;;;;;;  emr-el-inline-variable) "emr-elisp" "emr-elisp.el" (20907
;;;;;;  20163 0 0))
;;; Generated autoloads from emr-elisp.el

(autoload 'emr-el-inline-variable "emr-elisp" "\
Inline the variable defined at point.
Uses of the variable are replaced with the initvalue in the variable definition.

\(fn)" t nil)

(autoload 'emr-el-eval-and-replace "emr-elisp" "\
Replace the current region or the form at point with its value.

\(fn)" t nil)

(autoload 'emr-el-extract-function "emr-elisp" "\
Extract a function, using the current region or form point as the body.
NAME is the name of the new function.
ARGLIST is its argument list.

\(fn NAME ARGLIST)" t nil)

(autoload 'emr-el-implement-function "emr-elisp" "\
Create a function definition for the symbol at point.
The function will be called NAME and have the given ARGLIST.

\(fn NAME ARGLIST)" t nil)

(autoload 'emr-el-extract-variable "emr-elisp" "\
Extract the current region or form at point to a special variable.
The variable will be called NAME.

\(fn NAME)" t nil)

(autoload 'emr-el-extract-constant "emr-elisp" "\
Extract the current region or form at point to a constant special variable.
The variable will be called NAME.

\(fn NAME)" t nil)

(autoload 'emr-el-extract-autoload "emr-elisp" "\
Create an autoload for FUNCTION.
FILE is the file that declares FUNCTION.
See `autoload' for details.

\(fn FUNCTION FILE)" t nil)

(autoload 'emr-el-comment-form "emr-elisp" "\
Comment out the current region or from at point.

\(fn)" t nil)

(autoload 'emr-el-delete-let-binding-form "emr-elisp" "\
Delete the let binding around point.

\(fn)" t nil)

(autoload 'emr-el-extract-to-let "emr-elisp" "\
Extract the region or expression at point to a let-binding named SYMBOL.

* extracts the list at or around point

* if there is no enclosing let-form, inserts one at the top of
  the current context (e.g. the enclosing `defun' or `lambda' form).

\(fn SYMBOL)" t nil)

(autoload 'emr-el-inline-let-variable "emr-elisp" "\
Inline the let-bound variable at point.

\(fn)" t nil)

(autoload 'emr-el-inline-function "emr-elisp" "\
Replace usages of a function with its body forms.
Replaces all usages in the current buffer.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("emr-pkg.el") (20907 20163 125846 0))

;;;***

(provide 'emr-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; emr-autoloads.el ends here
