;;; jxx-gnus.el --- Gnus setup

;; Copyright (C) 2019 Julien Blanchard

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

;;; Commentary:

;;; Code:

(require 'gnus)

(setq user-mail-address	"julien@typed-hole.org"
      user-full-name	"Julien Blanchard")

(setq gnus-select-method
      '(nntp "orbitalfox"
             (nntp-address "orbitalfox.eu")
             (nntp-port-number 563)
             (nntp-open-connection-function
              nntp-open-tls-stream)))

(add-to-list 'gnus-secondary-select-methods '(nntp "news.tilde.club"))

(setq gnus-visual t)

(setq gnus-thread-sort-functions
      '(gnus-thread-sort-by-number
	gnus-thread-sort-by-author
	gnus-thread-sort-by-subject
	gnus-thread-sort-by-date))

(defun romildo-unicode-threads ()
  (interactive)
  (copy-face 'font-lock-variable-name-face 'gnus-face-6)
  (setq gnus-face-6 'gnus-face-6)
  (copy-face 'font-lock-constant-face 'gnus-face-7)
  (setq gnus-face-7 'gnus-face-7)
  (copy-face 'gnus-face-7 'gnus-summary-normal-unread)
  (copy-face 'font-lock-constant-face 'gnus-face-8)
  (set-face-foreground 'gnus-face-8 "gray50")
  (setq gnus-face-8 'gnus-face-8)
  (copy-face 'font-lock-constant-face 'gnus-face-9)
  (set-face-foreground 'gnus-face-9 "gray70")
  (setq gnus-face-9 'gnus-face-9)
  ;;
  ;; (setq gnus-summary-line-format "%[%U%R%z%]|%&user-date|%«%(%-23,23f%)%»%* %B%s\n")
  ;; (setq gnus-summary-line-format "%[%U%R%z%]|%10&user-date;|%(%-23,23f%)|%*%B%s\n")
  ;; (setq gnus-summary-line-format "%[%U%R%z%]│%10&user-date;│%(%-23,23f%)│%*%B%s\n")
  (setq gnus-summary-line-format "%8{%U%R%z%}│%10&user-date;│%(%-23,23f%)│%*%B%s\n"
        gnus-user-date-format-alist '((t . "%Y-%m-%d %H:%M")))

  ;; (setq gnus-summary-same-subject "")

  ;; (setq gnus-sum-thread-tree-root " >")
  ;; (setq gnus-sum-thread-tree-single-indent "  ")
  ;; (setq gnus-sum-thread-tree-vertical "|")
  ;; (setq gnus-sum-thread-tree-indent " ")
  ;; (setq gnus-sum-thread-tree-leaf-with-other "+-> ")
  ;; (setq gnus-sum-thread-tree-single-leaf "`-> ")

  ;;(setq gnus-sum-thread-tree-root nil)
  ;; (setq gnus-sum-thread-tree-single-indent "  ")
  ;; (setq gnus-sum-thread-tree-vertical "|")
  ;; (setq gnus-sum-thread-tree-indent " ")
  ;; (setq gnus-sum-thread-tree-leaf-with-other "+-> ")
  ;; (setq gnus-sum-thread-tree-single-leaf "`-> ")

  ;; (setq gnus-thread-indent-level 3)

  (setq gnus-sum-thread-tree-root "■ ")
  (setq gnus-sum-thread-tree-false-root "□ ")
  (setq gnus-sum-thread-tree-single-indent "▣ ")
  (setq gnus-sum-thread-tree-leaf-with-other "├► ")
  (setq gnus-sum-thread-tree-vertical "│ ")
  (setq gnus-sum-thread-tree-single-leaf "╰► ")
  (setq gnus-sum-thread-tree-indent "  "))

;; http://eschulte.github.com/emacs-starter-kit/starter-kit-gnus.html
;; http://groups.google.com/group/gnu.emacs.gnus/browse_thread/thread/a673a74356e7141f
(defun dan-unicode-threads ()
  (interactive)
  (when window-system
    (setq gnus-sum-thread-tree-indent "  ")
    (setq gnus-sum-thread-tree-root "") ;; "● ")
    (setq gnus-sum-thread-tree-false-root "") ;; "◯ ")
    (setq gnus-sum-thread-tree-single-indent "") ;; "◎ ")
    (setq gnus-sum-thread-tree-vertical        "│")
    (setq gnus-sum-thread-tree-leaf-with-other "├─► ")
    (setq gnus-sum-thread-tree-single-leaf     "╰─► "))
  (setq gnus-summary-line-format
        (concat
         "%0{%U%R%z%}"
         "%3{│%}" "%1{%d%}" "%3{│%}" ;; date
         "  "
         "%4{%-20,20f%}"               ;; name
         "  "
         "%3{│%}"
         " "
         "%1{%B%}"
         "%s\n"))
  (setq gnus-summary-display-arrow t))

;; http://www.emacswiki.org/emacs/TomRauchenwald
(defun oxy-unicode-threads ()
  (interactive)
  (setq gnus-summary-dummy-line-format "    %8{│%}   %(%8{│%}                       %7{│%}%) %6{□%}  %S\n"
	gnus-summary-line-format "%8{%4k│%}%9{%U%R%z%}%8{│%}%*%(%-23,23f%)%7{│%} %6{%B%} %s\n"
	gnus-sum-thread-tree-indent " "
	gnus-sum-thread-tree-root "■ "
	gnus-sum-thread-tree-false-root "□ "
	gnus-sum-thread-tree-single-indent "▣ "
	gnus-sum-thread-tree-leaf-with-other "├─▶ "
	gnus-sum-thread-tree-vertical "│"
	gnus-sum-thread-tree-single-leaf "└─▶ "))
(defun oxy-unicode-threads-heavy ()
  (interactive)
  (copy-face 'font-lock-variable-name-face 'gnus-face-6)
  (setq gnus-face-6 'gnus-face-6)
  (copy-face 'font-lock-constant-face 'gnus-face-7)
  (setq gnus-face-7 'gnus-face-7)
  (copy-face 'gnus-face-7 'gnus-summary-normal-unread)
  (copy-face 'font-lock-constant-face 'gnus-face-8)
  (set-face-foreground 'gnus-face-8 "gray50")
  (setq gnus-face-8 'gnus-face-8)
  (copy-face 'font-lock-constant-face 'gnus-face-9)
  (set-face-foreground 'gnus-face-9 "gray70")
  (setq gnus-face-9 'gnus-face-9)
  (setq gnus-summary-make-false-root 'dummy)
  (setq gnus-summary-make-false-root-always nil)
  ;;
  (setq gnus-summary-line-format "%8{%4k│%}%9{%U%R%z%}%8{│%}%*%(%-23,23f%)%7{║%} %6{%B%} %s\n"
	gnus-summary-dummy-line-format "    %8{│%}   %(%8{│%}                       %7{║%}%) %6{┏○%}  %S\n"
	gnus-sum-thread-tree-indent " "
	gnus-sum-thread-tree-root "┏● "
	gnus-sum-thread-tree-false-root " ○ "
	gnus-sum-thread-tree-single-indent " ● "
	gnus-sum-thread-tree-leaf-with-other "┣━━❯ "
	gnus-sum-thread-tree-vertical "┃"
	gnus-sum-thread-tree-single-leaf "┗━━❯ "))

(romildo-unicode-threads)
;; (oxy-unicode-threads-heavy)




;; (setq gnus-use-trees t)
;; (setq gnus-generate-tree-function 'gnus-generate-horizontal-tree)
;; (setq gnus-tree-minimize-window nil)
;; (gnus-add-configuration
;;  '(article
;;    (vertical 1.0
;; 	     (horizontal 0.25
;; 			 (summary 0.75 point)
;; 			 (tree 1.0))
;; 	     (article 1.0))))

;; do not hide killed threads automatically
(setq gnus-thread-hide-killed nil)


(provide 'jxx-gnus)
;;; jxx-gnus.el ends here
