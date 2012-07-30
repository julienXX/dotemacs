;;; nrepl-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (nrepl nrepl-jack-in nrepl-enable-on-existing-clojure-buffers
;;;;;;  clojure-nrepl-mode) "nrepl" "nrepl.el" (20502 17267))
;;; Generated autoloads from nrepl.el

(autoload 'clojure-nrepl-mode "nrepl" "\
Major mode for nrepl interaction from a Clojure buffer.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.clj\\'" . clojure-nrepl-mode))

(autoload 'nrepl-enable-on-existing-clojure-buffers "nrepl" "\


\(fn)" t nil)

(autoload 'nrepl-jack-in "nrepl" "\


\(fn PROMPT-PROJECT)" t nil)

(add-hook 'nrepl-connected-hook 'nrepl-enable-on-existing-clojure-buffers)

(autoload 'nrepl "nrepl" "\


\(fn PORT)" t nil)

;;;***

;;;### (autoloads nil nil ("nrepl-pkg.el") (20502 17267 351339))

;;;***

(provide 'nrepl-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; nrepl-autoloads.el ends here
