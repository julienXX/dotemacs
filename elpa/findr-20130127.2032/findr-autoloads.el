;;; findr-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (pluralize-string singularize-string) "inflections"
;;;;;;  "inflections.el" (20743 57338 0 0))
;;; Generated autoloads from inflections.el

(autoload 'singularize-string "inflections" "\


\(fn STR)" nil nil)

(autoload 'pluralize-string "inflections" "\


\(fn STR)" nil nil)

;;;***

;;;### (autoloads (defjump) "jump" "jump.el" (20743 57338 0 0))
;;; Generated autoloads from jump.el

(autoload 'defjump "jump" "\
Define NAME as a function with behavior determined by SPECS.
SPECS should be a list of cons cells of the form

   (jump-from-spec . jump-to-spec)

NAME will then try subsequent jump-from-specs until one succeeds,
at which point any resulting match information, along with the
related jump-to-spec will be used to jump to the intended buffer.
See `jump-to' and `jump-from' for information on spec
construction.

ROOT should specify the root of the project in which all jumps
take place, it can be either a string directory path, or a
function returning

Optional argument DOC specifies the documentation of the
resulting function.

Optional argument MAKE can be used to specify that missing files
should be created.  If MAKE is a function then it will be called
with the file path as it's only argument.  After possibly calling
MAKE `find-file' will be used to open the path.

Optional argument METHOD-COMMAND overrides the function used to
find the current method which defaults to `which-function'.

\(fn NAME SPECS ROOT &optional DOC MAKE METHOD-COMMAND)" nil t)

;;;***

;;;### (autoloads nil nil ("findr-pkg.el" "findr.el") (20743 57339
;;;;;;  26636 0))

;;;***

(provide 'findr-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; findr-autoloads.el ends here
