;;; jxx-ruby.el --- Ruby stuff

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

;;; PACKAGES

;; YAML
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; RSpec mode
(require 'rspec-mode)
(setq rspec-use-rake-flag nil)

;; ruby-tools
(require 'ruby-tools)

;; SCSS
(setq scss-compile-at-save nil)

;; Rinari
(require 'rinari)


;;; FUNCTIONS
(defun ruby-open-spec-other-buffer ()
  (interactive)
  (when (featurep 'rspec-mode)
    (let ((source-buffer (current-buffer))
          (other-buffer (progn
                          (rspec-toggle-spec-and-target)
                          (current-buffer))))
      (switch-to-buffer source-buffer)
      (pop-to-buffer other-buffer))))

(defun jxx-show-ruby-tags ()
  (interactive)
  (occur "^\\s-*\\\(class \\\|module \\\|def \\\|[^:]include \\\|private\\b\\\|protected\\b\\\)"))

(define-key ruby-mode-map (kbd "C-c t") 'jxx-show-ruby-tags)

(defun goto-match-paren (arg)
  "Go to the matching  if on (){}[], similar to vi style of % "
  (interactive "p")
  ;; first, check for "outside of bracket" positions expected by forward-sexp, etc
  (cond ((looking-at "[\[\(\{]") (forward-sexp))
        ((looking-back "[\]\)\}]" 1) (backward-sexp))
        ;; now, try to succeed from inside of a bracket
        ((looking-at "[\]\)\}]") (forward-char) (backward-sexp))
        ((looking-back "[\[\(\{]" 1) (backward-char) (forward-sexp))
        (t nil)))

(defun goto-matching-ruby-block (arg)
  (cond
   ;; are we at an end keyword?
   ((equal (current-word) "end")
    (ruby-beginning-of-block))

   ;; or are we at a keyword itself?
   ((string-match (current-word) "\\(for\\|while\\|until\\|if\\|class\\|module\\|case\\|unless\\|def\\|begin\\|do\\|context\\|describe\\it\\)")
    (ruby-end-of-block))))

(defun dispatch-goto-matching (arg)
  (interactive "p")

  (if (or
       (looking-at "[\[\(\{]")
       (looking-at "[\]\)\}]")
       (looking-back "[\[\(\{]" 1)
       (looking-back "[\]\)\}]" 1))

      (goto-match-paren arg)

    (when (eq major-mode 'ruby-mode)
      (goto-matching-ruby-block arg))))

(global-set-key "\M--" 'dispatch-goto-matching)

;; HOOKS
(add-hook 'ruby-mode-hook
          (lambda ()
            (ruby-tools-mode t)))

(add-hook 'haml-mode-hook
          (lambda ()
            (ruby-tools-mode t)
            (setq indent-tabs-mode nil)
            (define-key haml-mode-map "\C-m" 'newline-and-indent)))


;; MODES
;; Rake files are ruby, too, so are gemspecs, rackup files, etc.
(add-to-list 'auto-mode-alist        '("\\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
(add-to-list 'auto-mode-alist        '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist        '("\\.thor$" . ruby-mode))
(add-to-list 'auto-mode-alist        '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist        '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist        '("\\.rabl$" . ruby-mode))
(add-to-list 'auto-mode-alist        '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist        '("Thorfile$" . ruby-mode))
(add-to-list 'auto-mode-alist        '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist        '("Procfile$" . ruby-mode))
(add-to-list 'auto-mode-alist        '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist        '("Vagrantfile$" . ruby-mode))
(add-to-list 'auto-mode-alist        (cons "\\.erb$" #'rhtml-mode))

(provide 'jxx-ruby)
;;; jxx-ruby.el ends here
