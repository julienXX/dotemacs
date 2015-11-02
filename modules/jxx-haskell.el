;;; jxx-haskell.el --- Haskell

;; Copyright (C) 2015 Julien Blanchard

;; Author: Julien Blanchard <julien@sideburns.eu>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:

(require 'haskell-mode)

;; Setup haskell-mode hooks
(with-eval-after-load "haskell-mode"
  (custom-set-variables
   '(haskell-mode-hook
     '(turn-on-haskell-indentation
       turn-on-haskell-doc))))

(add-hook 'haskell-mode-hook
          (lambda () (electric-indent-local-mode 0)))

;; Setup haskell-interactive-mode keybindings. Get started by using C-c C-z from
;; a buffer visiting a file in your Haskell project.
(with-eval-after-load "haskell-mode"
  ;; Switch to the current REPL buffer, starting a session if needed.
  (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  ;; Switch between REPL sessions.
  (define-key haskell-mode-map (kbd "C-c b") 'haskell-session-change)
  ;; Load the current buffer into the REPL.
  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-file)
  ;; Infer the type of the thing at point.
  (define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
  ;; Display info (in the REPL) about the thing at point.
  (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
  ;; Insert the inferred type of the function at point into the code.
  (define-key haskell-mode-map (kbd "C-c C-s") (lambda () (interactive) (haskell-process-do-type t)))
  ;; Run `cabal test' in a compile buffer.
  (define-key haskell-mode-map (kbd "C-c C-,") 'jxx-haskell/run-test-suite))

;; A function for launching a compile buffer with `cabal test'.
(defun jxx-haskell/run-test-suite ()
  (interactive)
  (require 'compile)
  (projectile-with-default-dir (projectile-project-root)
    (compile "cabal test")))

(provide 'jxx-haskell)
;;; jxx-haskell.el ends here
