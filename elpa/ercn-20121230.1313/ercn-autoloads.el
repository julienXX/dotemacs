;;; ercn-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (ercn-fix-hook-order ercn-match) "ercn" "ercn.el"
;;;;;;  (20846 28597 0 0))
;;; Generated autoloads from ercn.el

(autoload 'ercn-match "ercn" "\
Extracts information from the buffer and fires the ercn-notify hook
  if needed.

\(fn)" nil nil)

(autoload 'ercn-fix-hook-order "ercn" "\
Notify before timestamps are added

\(fn &rest ##)" nil nil)

(when (and (boundp 'erc-modules) (not (member 'ercn 'erc-modules))) (add-to-list 'erc-modules 'ercn))

(eval-after-load 'erc '(progn (unless (featurep 'ercn (require 'ercn))) (add-to-list 'erc-modules 'ercn t)))

;;;***

;;;### (autoloads nil nil ("ercn-pkg.el") (20846 28597 599494 0))

;;;***

(provide 'ercn-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; ercn-autoloads.el ends here
