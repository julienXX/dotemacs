;;; circe-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (circe) "circe" "circe.el" (21066 35446 0 0))
;;; Generated autoloads from circe.el

(autoload 'circe "circe" "\
Connect to IRC.

Connect to the given network specified by NETWORK-OR-SERVER.

When this function is called, it collects options from the
OPTIONS argument, the user variable `circe-network-options', and
the defaults found in `circe-networks', in this order.

If NETWORK-OR-SERVER is not found in any of these variables, the
argument is assumed to be the host name for the server, and all
relevant settings must be passed via OPTIONS.

All OPTIONS are treated as variables by getting the string
\"circe-\" prepended to their name. This variable is then set
locally in the server buffer.

See `circe-network-options' for a list of common options.

\(fn NETWORK-OR-SERVER &rest OPTIONS)" t nil)

;;;***

;;;### (autoloads (enable-circe-color-nicks) "circe-color-nicks"
;;;;;;  "circe-color-nicks.el" (21066 35445 0 0))
;;; Generated autoloads from circe-color-nicks.el

(autoload 'enable-circe-color-nicks "circe-color-nicks" "\
Enable the Color Nicks module for Circe.
This module colors all encountered nicks in a cross-server fashion.

\(fn)" t nil)

;;;***

;;;### (autoloads (enable-circe-highlight-all-nicks) "circe-highlight-all-nicks"
;;;;;;  "circe-highlight-all-nicks.el" (21066 35445 0 0))
;;; Generated autoloads from circe-highlight-all-nicks.el

(autoload 'enable-circe-highlight-all-nicks "circe-highlight-all-nicks" "\
Enable the Highlight Nicks module for Circe.
This module highlights all occurances of nicks in the current
channel in messages of other people.

\(fn)" t nil)

;;;***

;;;### (autoloads (circe-lagmon-mode) "circe-lagmon" "circe-lagmon.el"
;;;;;;  (21066 35446 0 0))
;;; Generated autoloads from circe-lagmon.el

(defvar circe-lagmon-mode nil "\
Non-nil if Circe-Lagmon mode is enabled.
See the command `circe-lagmon-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `circe-lagmon-mode'.")

(custom-autoload 'circe-lagmon-mode "circe-lagmon" nil)

(autoload 'circe-lagmon-mode "circe-lagmon" "\
Circe-lagmon-mode monitors the amount of lag on your
connection to each server, and displays the lag time in seconds
in the mode-line.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil nil ("circe-chanop.el" "circe-fix-minibuffer.el"
;;;;;;  "circe-pkg.el" "circe-tests.el") (21066 35446 146316 0))

;;;***

(provide 'circe-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; circe-autoloads.el ends here
