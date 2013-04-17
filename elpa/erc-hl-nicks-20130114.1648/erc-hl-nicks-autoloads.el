;;; erc-hl-nicks-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (erc-hl-nicks erc-hl-nicks-alias-nick erc-hl-nicks-force-nick-face)
;;;;;;  "erc-hl-nicks" "erc-hl-nicks.el" (20846 42069 0 0))
;;; Generated autoloads from erc-hl-nicks.el

(autoload 'erc-hl-nicks-force-nick-face "erc-hl-nicks" "\
Force nick highlighting to be a certain color for a nick. Both NICK and COLOR
  should be strings.

\(fn NICK COLOR)" nil nil)

(autoload 'erc-hl-nicks-alias-nick "erc-hl-nicks" "\
Manually handle the really wacked out nickname transformations.

\(fn NICK &rest NICK-ALIASES)" nil nil)

(autoload 'erc-hl-nicks "erc-hl-nicks" "\
Retrieves a list of usernames from the server and highlights them

\(fn)" nil nil)

(when (and (boundp 'erc-modules) (not (member 'hl-nicks 'erc-modules))) (add-to-list 'erc-modules 'hl-nicks))

(eval-after-load 'erc '(progn (unless (featurep 'erc-hl-nicks) (require 'erc-hl-nicks)) (add-to-list 'erc-modules 'hl-nicks t)))

;;;***

;;;### (autoloads nil nil ("erc-hl-nicks-pkg.el") (20846 42069 382697
;;;;;;  0))

;;;***

(provide 'erc-hl-nicks-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; erc-hl-nicks-autoloads.el ends here
