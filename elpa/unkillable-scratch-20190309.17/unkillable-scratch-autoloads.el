;;; unkillable-scratch-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "unkillable-scratch" "unkillable-scratch.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from unkillable-scratch.el

(defvar unkillable-scratch nil "\
Non-nil if Unkillable-Scratch mode is enabled.
See the `unkillable-scratch' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `unkillable-scratch'.")

(custom-autoload 'unkillable-scratch "unkillable-scratch" nil)

(autoload 'unkillable-scratch "unkillable-scratch" "\
A minor mode to disallow the *scratch* buffer from being killed.

If called interactively, enable Unkillable-Scratch mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "unkillable-scratch" '("unkillable-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; unkillable-scratch-autoloads.el ends here
